package com.harmony.longterm.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.harmony.longterm.vo.BaseColorVO;
import com.harmony.longterm.vo.CarVO;
import com.harmony.longterm.vo.ColorVO;
import com.harmony.longterm.vo.HoldingCarVO;
import com.harmony.longterm.vo.OptionVO;


@RestController
@RequestMapping({"/car/"})
public class CarDao
{
  protected Logger logger = LoggerFactory.getLogger(CarDao.class);
  
  @Autowired
  private SqlSessionTemplate sqlSession;
  
 // private final String NS = "rent.car.";

  @RequestMapping(value = {"holdingcarlist"}, method = {RequestMethod.POST})
  public List<HoldingCarVO> selectHoldingCar(@RequestBody HashMap<String, Object> map) {
    return this.sqlSession.selectList("rent.car.holdingcarlist", map);
  }
  
  @RequestMapping(value = {"modellist"}, method = {RequestMethod.POST})
  public List<CarVO> selectModels(@RequestBody HashMap<String, Object> map) {
    this.logger.debug(map.get("maker").toString());
    return this.sqlSession.selectList("rent.car.modellist", map.get("maker"));
  }


  
  @RequestMapping(value = {"lineuplist"}, method = {RequestMethod.POST})
  public List<CarVO> selectLineups(@RequestBody HashMap<String, Object> map) {
    return this.sqlSession.selectList("rent.car.lineuplist", map);
  }

  
  @RequestMapping(value = {"trimlist"}, method = {RequestMethod.POST})
  public List<CarVO> selectTrims(@RequestBody HashMap<String, Object> map) {
    return this.sqlSession.selectList("rent.car.trimlist", map);
  }
  
  @RequestMapping(value = {"optionlist"}, method = {RequestMethod.POST})
  public List<OptionVO> selectOptions(@RequestBody HashMap<String, Object> map) {
    int trim_id = Integer.parseInt(map.get("trim_id").toString());
    this.logger.debug("TRIM ID: " + map.get("trim_id").toString());
    return this.sqlSession.selectList("rent.car.optionlist", Integer.valueOf(trim_id));
  }

  @RequestMapping({"trim"})
  public CarVO selectTrim(@RequestBody HashMap<String, Object> map) {
    CarVO car = (CarVO)this.sqlSession.selectOne("rent.car.trim", map);
    this.logger.debug(car.getCar_type());
    return car;
  }
  
  @RequestMapping({"trimlist"})
  public List<CarVO> selectTrims(@RequestParam(name = "model", required = false) Integer model_id) {
    return this.sqlSession.selectList("rent.car.trimlist", model_id);
  }

  @RequestMapping({"colorlist"})
  public List<ColorVO> selectColors(@RequestBody HashMap<String, Object> map) {
    int model_id = Integer.parseInt(map.get("model_id").toString());
    return this.sqlSession.selectList("rent.car.colorlist", Integer.valueOf(model_id));
  }
  @RequestMapping(value = {"rentfee_ou"}, method = {RequestMethod.POST})
  public HashMap<String, String> rentFee_ou(@RequestBody HashMap<String, Object> map) {
	  HashMap<String, String> returnMap = new HashMap<>();

	  CarVO car = (CarVO)this.sqlSession.selectOne("rent.car.trim", Integer.valueOf(Integer.parseInt(map.get("trim_id").toString())));
	  if (car == null) return returnMap;
	  
	  float tax_rate = car.getTax_rate();
	  int option_price = Integer.parseInt(map.get("total_option_price").toString()) + Integer.parseInt(map.get("color_price").toString());
	  int period = Integer.parseInt(map.get("period").toString());
	  String car_type = car.getCar_type();
	  String fuel = car.getFuel();
	  float deposit_ratio = Float.parseFloat(map.get("deposit_ratio").toString());	//보증금 비율
	  
	  int price = car.getPrice() + option_price ;
	  int tax_price = price;
	  
//오너형 계산
	  if(tax_rate == 0.065F) {
		  if (fuel.equals("전기")) {
			  tax_price = (int)(price / 1.1715F * 1.1F);
		  }else {
			 tax_price = (int)(price / 1.1715F * 1.15005F);
		   	 if((price-tax_price) >1430000) {
		   		 tax_price = price - 1430000;
		   	 }
		  }
	   	 
	   	 tax_price = tax_price - car.getElecSub();
	  }else if(tax_rate == 0F) {
	   	tax_price = (int)(price / 1.1D * 1.15005F);
	  }else if(tax_rate == 0.0455F) {
	   	tax_price = price;
	  }

	  
	  if (car_type.equals("승합차") || car_type.equals("경차") ) {
		  tax_price=price;
	  }
	  
//	  tax_price+=price;
	  int base_price = 0; //기본약정금액
	  int deposit = 0; //초기금액
	   	this.logger.debug("deposit_ratio="+deposit_ratio );

	  if(deposit_ratio == 0.7F ){
	  	base_price = (int)(tax_price * 1.12D);
	  	deposit = (int)(tax_price * 0.7F);
//	  	deposit = (int)(tax_price * 0.7F)/10000 * 10000;
	  }else if(deposit_ratio == 0.8F) {
	  	base_price = (int)(tax_price * 1.10D);
	  	deposit = (int)(tax_price * 0.8F);
//	  	deposit = (int)(tax_price * 0.8F) /10000 * 10000;
	  }else if(deposit_ratio == 1.0F) {
	   	base_price = (int)(tax_price * 1.06D);
//	   	deposit = base_price/10000*10000;
	   	deposit = base_price;
	  }

	  
	  int add_price =0;
	  if(tax_price <= 20000000 ) {
		  add_price = (int)(tax_price * 0.03D);
	  }else if(tax_price <= 25000000) {
		  add_price = (int)(tax_price * 0.02D);
	  }else if(tax_price <= 30000000) {
		  add_price = (int)(tax_price * 0.01D);
	  }
	  
	  int acquisition=0;
	  float agent_fee_rate = Float.parseFloat(map.get("agent_fee_rate").toString()) * 0.01F;
	  int agent_fee = (int)(tax_price * agent_fee_rate);
this.logger.debug("tax_price="+tax_price + "기본약정금액="+base_price+",초기금액="+deposit +",기타금액:"+add_price + ",수수료:" + agent_fee + ",개월수:"+period);

int etcprice = Integer.parseInt(map.get("tagsong_price").toString()) + Integer.parseInt(map.get("blackbox_price").toString());

//	  int tot_price = (base_price + add_price + agent_fee) /10000 * 10000;
	  int tot_price = (base_price + add_price + agent_fee + etcprice);
	  int rentfee = (tot_price-deposit) / period;
	  if(deposit_ratio == 1.0F) {
		  deposit = base_price + add_price + agent_fee + etcprice;
		  rentfee = 0;
	  }

//	  rentfee = (rentfee) / 1000 * 1000;
	  agent_fee = agent_fee / 100 * 100;
	  acquisition = acquisition / 10000 * 10000;
	  deposit = deposit / 10000 * 10000;
	  this.logger.debug("tax_price="+tax_price + "기본약정금액="+base_price+",초기금액="+deposit +",기타금액:"+add_price + ",수수료:" + agent_fee + ",개월수:"+period);

	  returnMap.put("rentfee", Integer.toString(rentfee));	//월렌트료
	  returnMap.put("deposit", Integer.toString(deposit));	//보증금
	  returnMap.put("agent_fee", Integer.toString(agent_fee));	//
	  returnMap.put("acquisition", Integer.toString(acquisition));	// 인수가	  
	
	  return returnMap;
  }
  
  @RequestMapping(value = {"rentfee"}, method = {RequestMethod.POST})
  public HashMap<String, String> rentFee(@RequestBody HashMap<String, Object> map) {
    int option_price = Integer.parseInt(map.get("total_option_price").toString()) + 
      Integer.parseInt(map.get("color_price").toString());
    int rentfee = 0;
    int cal_price=0;
    float deposit_ratio = Float.parseFloat(map.get("deposit_ratio").toString());	//보증금 비율
    float temp_deposit = (deposit_ratio < 0.5F) ? 0.1F : 0.5F;
    
    int deposit = getRentDeposit(Integer.parseInt(map.get("trim_id").toString()), option_price, temp_deposit);
    int period = Integer.parseInt(map.get("period").toString());
    int prepayment = Integer.parseInt(map.get("prepayment").toString());

//한번의 쿼리로 3개의 값을 가져오면 안되나?  
    HashMap<String, Integer> retVal = new HashMap<>();
    retVal = getPrcFeeRate(Integer.parseInt(map.get("trim_id").toString()), option_price, period,temp_deposit,Integer.parseInt(map.get("distance").toString()), prepayment, Float.parseFloat(map.get("agent_fee_rate").toString()) * 0.01F );
    int acquisition = retVal.get("acquisition");
    int agent_fee = retVal.get("agent_fee");
    rentfee = retVal.get("rentfee");
    cal_price = retVal.get("cal_price");
    
//    int cal_price = retVal.get("cal_price");	//재세공과금+차량가+옵션가
//    this.logger.debug("cal_price="+cal_price);
//    int base_price = cal_price; //기본약정금액
//    if(deposit_ratio == 0.7 ){
//    	base_price = (int)(cal_price * 1.12D);
//    }else if(deposit_ratio == 0.8) {
//    	base_price = (int)(cal_price * 1.10D);
//    }else if(deposit_ratio == 1.0) {
//    	base_price = (int)(cal_price * 1.06D);
//    }

/*    
    int acquisition = getAcquisitionPrice(Integer.parseInt(map.get("trim_id").toString()), option_price, period, Integer.parseInt(map.get("distance").toString()), temp_deposit);
    int agent_fee = getAgentFee(Integer.parseInt(map.get("trim_id").toString()), option_price, period, Float.parseFloat(map.get("agent_fee_rate").toString()) * 0.01F, temp_deposit);
    rentfee = getRentFee_with_CalRate(Integer.parseInt(map.get("trim_id").toString()), option_price, period, Integer.parseInt(map.get("distance").toString()), Integer.parseInt(map.get("prepayment").toString()), temp_deposit);

    this.logger.debug("rentfee ="+ rentfee);
*/  
    int etcprice = Integer.parseInt(map.get("tagsong_price").toString()) + Integer.parseInt(map.get("blackbox_price").toString());

    
    rentfee = (int)(rentfee + (agent_fee + etcprice) * 1.3D / period);
    int cal_deposit = (int)(deposit / temp_deposit * deposit_ratio);
    
    rentfee -= (int)((cal_deposit - deposit) * 0.02D / 12.0D);
    deposit = cal_deposit;
    
    rentfee = rentfee - (prepayment / period);

    this.logger.debug("cal_price="+cal_price);
    
    HashMap<String, String> returnMap = new HashMap<>();
    deposit = (deposit + 9999) / 10000 * 10000;
    rentfee = (rentfee + 999) / 1000 * 1000;
    agent_fee = agent_fee / 100 * 100;
    acquisition = (acquisition + 9999) / 10000 * 10000;
    cal_price = (cal_price + 9999) / 10000 * 10000;
    returnMap.put("rentfee", Integer.toString(rentfee));
    returnMap.put("deposit", Integer.toString(deposit));
    returnMap.put("agent_fee", Integer.toString(agent_fee));
    returnMap.put("acquisition", Integer.toString(acquisition));
    returnMap.put("cal_price", Integer.toString(cal_price));
 //   returnMap.put("cal_price", Integer.toString(cal_price));
    
    return returnMap;
  }

  public HashMap<String, Integer> getPrcFeeRate(int trim_id, int option_price, int period, float deposit_ratio, int distance, int prepayment, float agency_fee_rate ){
	  HashMap<String, Integer> retVal = new HashMap<>();
	  HashMap<String, String> data = new HashMap<>();
	  CarVO car = null;
	  
	  data.put("trim_id", Integer.toString(trim_id));
	  data.put("period", Integer.toString(period));
	  data.put("deposit", Float.toString(deposit_ratio));
	  car = (CarVO)this.sqlSession.selectOne("rent.car.trim", data);
	  if (car == null) {
	     this.logger.warn("NO DATA");
	     retVal.put("rentfee", 0);
	     return retVal;
	  } 
	  
//	    Integer price = Integer.valueOf(car.getPrice() + option_price);
	  	int price = car.getPrice() + option_price;
	    
	    float cal_rate = car.getCal_rate();
	    int maintain_fee = car.getMaintain_fee();
//	    float cal_rent = (float)((price.intValue() * cal_rate + maintain_fee) * 1.1D);
	    float cal_rent = (float)((price * cal_rate + maintain_fee) * 1.1D);
	    this.logger.debug("수수료 : " + Integer.toString((int)cal_rent));
	    retVal.put("rentfee",(int)cal_rent);

	    
	    int acquisition = 0;
	    float tax_rate = car.getTax_rate();
	    price = car.getPrice() + option_price;
	    int reg_car_price = (int)(price / 1.1D / (1.0F + tax_rate));
	    String tax_type = car.getTax_type();
	    String fuel = car.getFuel();
	    float janga = 0.0F;
	    if (period == 24) {
	      janga = car.getJanga24();
	    } else if (period == 36) {
	      janga = car.getJanga36();
	    } else if (period == 48) {
	      janga = car.getJanga48();
	    } 
	    float cal_tax_rate = 0.0455F;
	    int cal_price = 0;
	    if (tax_type.equals("면세")) {
	      cal_price = (int)(reg_car_price * 1.1D);
	    }
	    else if (fuel.equals("전기")) {
	      cal_price = (int)(reg_car_price * 1.1D);
	    } else {
	      cal_price = (int)((reg_car_price * (1.0F + cal_tax_rate)) * 1.1D);
	    } 
//	    if (fuel.equals("전기")) {
//	      acquisition = (int)(cal_price * janga);
//	    }
//	    else 
	    	if (deposit_ratio == 0.1F) {
	      acquisition = (int)(cal_price * (janga + 0.1D));
	    }
	    else if (deposit_ratio == 0.5F) {
	      acquisition = (int)(cal_price * (janga + 0.04D));
	    } else {
	      this.logger.error("CHECK deposit_ratio");
	    } 
	    this.logger.debug("만기인수가 : " + Integer.toString(acquisition));
	    retVal.put("acquisition", acquisition);
	    retVal.put("cal_price", cal_price);

	    int agent_fee = 0;
//	    float tax_rate = car.getTax_rate();
//	    int price = car.getPrice() + option_price;
//	    int reg_car_price = (int)(price / 1.1D / (1.0F + tax_rate));
//	    String tax_type = car.getTax_type();
//	    float cal_tax_rate = 0.0455F;
	    cal_price = 0;
	    if (tax_type.equals("면세")) {
	      cal_price = (int)(reg_car_price * 1.1D);
	    } else {
	      cal_price = (int)((reg_car_price * (1.0F + cal_tax_rate)) * 1.1D);
	    } 
	    agent_fee = (int)(cal_price * agency_fee_rate);
	    this.logger.debug("수수료 : " + Integer.toString(agent_fee));
	    retVal.put("agent_fee", agent_fee);
/*
// 오너형 계산
	    if (tax_type.equals("승합차") || tax_type.equals("경차") ) {
	    	cal_tax_rate = 0.0F;
	    	cal_price=0;
	    }
	    if(tax_rate == 0.065) {
	    	cal_price = (int)(price / 1.1715F * 1.15005F);
	    }else if(tax_rate == 0) {
	    	cal_price = (int)(price / 1.1D * 1.15005F);
	    }else if(tax_rate == 0.0455) {
	    	cal_price = 0;
	    }
	    cal_price+=price;
//	    cal_price = (int)(cal_price * (1.0F+agency_fee_rate));
	    retVal.put("cal_price",cal_price);
*/	    
	    return retVal;	  
  }
  
  public int getRentDeposit(int trim_id, int option_price, float deposit_ratio) {
    int deposit = 0;

    CarVO car = (CarVO)this.sqlSession.selectOne("rent.car.trim", Integer.valueOf(trim_id));
    if (car == null) return 0; 
    float tax_rate = car.getTax_rate();
    int reg_car_price = (int)((car.getPrice() + option_price) / 1.1D / (1.0F + tax_rate));
    
    if (tax_rate == 0.0F) {
      deposit = (int)((reg_car_price * deposit_ratio) * 1.1D);
    } else if (car.getFuel().contains("전기")) {
      deposit = (int)((reg_car_price * deposit_ratio) * 1.1D);
    } else {
      
      deposit = (int)(reg_car_price * 1.0455D * deposit_ratio * 1.1D);
    } 
    return deposit;
  }

  
  public int getRentFee_with_CalRate(int trim_id, int option_price, int period, int distance, int prepayment, float deposit_ratio) {
    int rent_fee = 0;

    CarVO car = null;
    HashMap<String, String> data = new HashMap<>();
    data.put("trim_id", Integer.toString(trim_id));
    data.put("period", Integer.toString(period));
    data.put("deposit", Float.toString(deposit_ratio));
    car = (CarVO)this.sqlSession.selectOne("rent.car.trim", data);
    if (car == null) {
      this.logger.warn("NO DATA");
      return -1;
    } 
    
//    Integer price = Integer.valueOf(car.getPrice() + option_price - prepayment);
    Integer price = Integer.valueOf(car.getPrice() + option_price);
    
    float cal_rate = car.getCal_rate();
    int maintain_fee = car.getMaintain_fee();
    float cal_rent = (float)((price.intValue() * cal_rate + maintain_fee) * 1.1D);
    
    rent_fee = (int)cal_rent;
    
    return rent_fee;
  }
/*
  private int getAcquisitionPrice(int trim_id, int option_price, int period, int distance, float deposit_ratio) {
    int acquisition = 0;
    
    CarVO car = null;
    
    HashMap<String, String> data = new HashMap<>();
    data.put("trim_id", Integer.toString(trim_id));
    data.put("period", Integer.toString(period));
    data.put("deposit", Float.toString(deposit_ratio));
    car = (CarVO)this.sqlSession.selectOne("rent.car.trim", data);
    if (car == null) {
      this.logger.warn("NO DATA");
      return -1;
    } 
    
    float tax_rate = car.getTax_rate();
    
    int price = car.getPrice() + option_price;
    
    int reg_car_price = (int)(price / 1.1D / (1.0F + tax_rate));
    
    String tax_type = car.getTax_type();
    String fuel = car.getFuel();
    float janga = 0.0F;
    if (period == 24) {
      janga = car.getJanga24();
    } else if (period == 36) {
      janga = car.getJanga36();
    } else if (period == 48) {
      janga = car.getJanga48();
    } 
    
    float cal_tax_rate = 0.0455F;
    int cal_price = 0;
    if (tax_type.equals("면세")) {
      cal_price = (int)(reg_car_price * 1.1D);
    }
    else if (fuel.equals("전기")) {
      cal_price = (int)(reg_car_price * 1.1D);
    } else {
      cal_price = (int)((reg_car_price * (1.0F + cal_tax_rate)) * 1.1D);
    } 
    if (fuel.equals("전기")) {
      acquisition = (int)(cal_price * janga);
    }
    else if (deposit_ratio == 0.1F) {
      acquisition = (int)(cal_price * (janga + 0.1D));
    }
    else if (deposit_ratio == 0.5F) {
      acquisition = (int)(cal_price * (janga + 0.04D));
    } else {
      this.logger.error("CHECK deposit_ratio");
    } 
    
    this.logger.debug("만기인수가 : " + Integer.toString(acquisition));
    return acquisition;
  }
*/
  private int getAgentFee(int trim_id, int option_price, int period, float agency_fee_rate, float deposit_ratio) {
    int agent_fee = 0;
    
    CarVO car = null;
    
    HashMap<String, String> data = new HashMap<>();
    data.put("trim_id", Integer.toString(trim_id));
    data.put("period", Integer.toString(period));
    data.put("deposit", Float.toString(deposit_ratio));
    car = (CarVO)this.sqlSession.selectOne("rent.car.trim", data);
    if (car == null) {
      this.logger.warn("NO DATA");
      return -1;
    } 
    float tax_rate = car.getTax_rate();
    
    int price = car.getPrice() + option_price;
    
    int reg_car_price = (int)(price / 1.1D / (1.0F + tax_rate));
    
    String tax_type = car.getTax_type();
    float cal_tax_rate = 0.0455F;
    int cal_price = 0;
    if (tax_type.equals("면세")) {
      cal_price = (int)(reg_car_price * 1.1D);
    } else {
      cal_price = (int)((reg_car_price * (1.0F + cal_tax_rate)) * 1.1D);
    } 
    agent_fee = (int)(cal_price * agency_fee_rate);
    this.logger.debug("수수료 : " + Integer.toString(agent_fee));
    return agent_fee;
  }
  
  public int getRentFee_Hi24(int trim_id, int option_price, int period, int distance) {
    int monthlyfee, rent_fee = 0;
    
    CarVO car = (CarVO)this.sqlSession.selectOne("rent.car.trim24", Integer.valueOf(trim_id));
    if (car == null) {
      this.logger.warn("NO DATA");
      return -1;
    } 
    this.logger.info(String.valueOf(car.getModel_name()) + car.getTrim_name());
    
    String name = car.getTrim_name();
    Integer price = Integer.valueOf(car.getPrice() + option_price);
    Integer displacement = Integer.valueOf(car.getDisplacement());
    String tax_type = car.getTax_type();
    String car_type = car.getCar_type();
    String fuel = car.getFuel();
    float tax_rate = car.getTax_rate();
    int tagsong = car.getTagsong();
    float cal_tax_rate = 0.0455F;
    float regist_rate = 0.04F;
    float interest_rate = 0.0054166666F;
    if (car_type.equals("승합차")) cal_tax_rate = 0.0F; 
    if (car_type.equals("경차")) cal_tax_rate = 0.0F;
    Integer reg_car_price = Integer.valueOf((int)(price.intValue() / 1.1D / (1.0F + tax_rate)));
    Integer regist_fee = Integer.valueOf((int)(reg_car_price.intValue() * regist_rate));
    if (fuel.equals("하이브리드")) {
      regist_fee = Integer.valueOf(regist_fee.intValue() - 400000);
    }
    if (regist_fee.intValue() < 0) regist_fee = Integer.valueOf(0); 
    Integer tax = Integer.valueOf((int)(reg_car_price.intValue() * cal_tax_rate));
    if (fuel.equals("하이브리드")) {
      tax = Integer.valueOf(tax.intValue() - 1300000);
    }
    if (tax.intValue() < 0) tax = Integer.valueOf(0);
    Integer total_price = Integer.valueOf(reg_car_price.intValue() + regist_fee.intValue() + tax.intValue());
    float janga_rate = 0.0F;
    
    if (period == 24) {
      janga_rate = car.getJanga24();
    }
    else if (period == 36) {
      janga_rate = car.getJanga36();
    }
    else if (period == 48) {
      janga_rate = car.getJanga48();
    } 
    
    if (distance == 20000) {
      janga_rate = (float)(janga_rate * 1.01D);
    } else if (distance == 40000) {
      janga_rate = (float)(janga_rate * 0.95D);
    } 
    
    Integer gamga = Integer.valueOf((int)((total_price.intValue() / period) * (1.0F - janga_rate - 0.0F)));
    rent_fee = total_price.intValue();
    Integer suik = Integer.valueOf((int)(reg_car_price.intValue() * 1.1D / 2.332E7D * 100000.0D));
    double temp = Math.pow((1.0F + interest_rate), 48.0D);
    Integer halbu = Integer.valueOf((int)((total_price.intValue() - price.intValue() * 0.1D) * interest_rate * temp / (temp - 1.0D)));
    Integer eja = Integer.valueOf((int)(((halbu.intValue() * 48 - total_price.intValue()) + (reg_car_price.intValue() * (1.0F + cal_tax_rate)) * 1.1D * 0.1D) / 48.0D));
    if (displacement.intValue() < 1600) {
      monthlyfee = 18 * displacement.intValue() / 12;
    }
    else if (displacement.intValue() < 2500) {
      monthlyfee = 19 * displacement.intValue() / 12;
    } else {
      monthlyfee = 24 * displacement.intValue() / 12;
    } 
    Integer chungdangum = Integer.valueOf((int)(reg_car_price.intValue() * 1.1D * 0.025D / 12.0D * 0.3D));
    Integer ujibee = Integer.valueOf((int)(tagsong / 1.1D * 1.04D / period + 
        monthlyfee + (35000 / period) + 62666.0D + 7000.0D + 3000.0D + 2000.0D));
    
    rent_fee = (int)((gamga.intValue() + suik.intValue() + eja.intValue() + chungdangum.intValue() + ujibee.intValue()) * 1.1D);
    
    System.out.printf("HI24 : 차량가격:%d %s %f%% 기준가격:%d 등록비:%d 개소세: %d 취득원가:%d 기간:%d 잔가:%f 감가:%d \n수익:%d 할부:%d 이자:%d 충당금:%d 탁송:%d 월자동차세:%d 유지비:%d 렌트료:%d\n", new Object[] {
          
          price, tax_type, Double.valueOf(tax_rate / 1.3D * 100.0D), reg_car_price, regist_fee, tax, total_price, 
          Integer.valueOf(period), Float.valueOf(janga_rate), gamga, suik, halbu, 
          eja, chungdangum, Integer.valueOf(tagsong), Integer.valueOf(monthlyfee), ujibee, Integer.valueOf(rent_fee)
        });
    rent_fee = (rent_fee + 999) / 1000 * 1000;
    System.out.printf("%d \n", new Object[] { Integer.valueOf(rent_fee) });

    return rent_fee;
  }

  public int getRentFee_Midas(int trim_id, int option_price, int period, int distance) {
    int monthlyfee;
    Integer janga;
    int rent_fee = 0;
    
    System.out.printf("%d %d %d %d\n", new Object[] { Integer.valueOf(trim_id), Integer.valueOf(option_price), Integer.valueOf(period), Integer.valueOf(distance) });
    CarVO car = null;
    if (period == 36) {
      car = (CarVO)this.sqlSession.selectOne("rent.car.trim36", Integer.valueOf(trim_id));
    } else if (period == 48) {
      car = (CarVO)this.sqlSession.selectOne("rent.car.trim48", Integer.valueOf(trim_id));
    }  if (car == null) {
      this.logger.warn("NO DATA");
      return -1;
    } 
    String name = car.getTrim_name();
    Integer price = Integer.valueOf(car.getPrice() + option_price);
    Integer displacement = Integer.valueOf(car.getDisplacement());
    String tax_type = car.getTax_type();
    String car_type = car.getCar_type();
    String fuel = car.getFuel();
    float tax_rate = car.getTax_rate();
    int tagsong = car.getTagsong();
    float fees_rate = car.getFees_rate();
    float maker_rate = car.getMaker_rate();
    float cal_tax_rate = 0.0455F;
    float regist_rate = 0.04F;
    float interest_rate = 0.0054166666F;

    if (car_type.equals("승합차")) cal_tax_rate = 0.0F; 
    if (car_type.equals("경차")) cal_tax_rate = 0.0F;
    
    double reg_car_price = price.intValue() / 1.1D / (1.0F + tax_rate);
    Integer regist_fee = Integer.valueOf((int)(reg_car_price * regist_rate));
    if (fuel.equals("하이브리드")) {
      regist_fee = Integer.valueOf(regist_fee.intValue() - 400000);
    }
    if (regist_fee.intValue() < 0) regist_fee = Integer.valueOf(0); 
    Integer tax = Integer.valueOf((int)(reg_car_price * cal_tax_rate));
    if (fuel.equals("하이브리드")) {
      tax = Integer.valueOf(tax.intValue() - 1300000);
    }
    if (tax.intValue() < 0) tax = Integer.valueOf(0);
    
    Integer total_price = Integer.valueOf((int)(reg_car_price + regist_fee.intValue() + tax.intValue()));
    float janga_rate = 0.0F;
    
    if (period == 24) {
      janga_rate = car.getJanga24();
    }
    else if (period == 36) {
      janga_rate = car.getJanga36();
    }
    else if (period == 48) {
      janga_rate = car.getJanga48();
    } 
    
    if (distance == 20000) {
      janga_rate = (float)(janga_rate * 1.01D);
    } else if (distance == 40000) {
      janga_rate = (float)(janga_rate * 0.95D);
    } 
    
    if (janga_rate == 0.0F) {
      this.logger.warn("잔가가 0이다.");
      return 0;
    } 
    if (tagsong == 0) {
      this.logger.warn("탁송비가 0이다.");
      return 0;
    } 
    
    Integer gamga = Integer.valueOf((int)((total_price.intValue() / period) * (1.0F - janga_rate - 0.0F)));
    rent_fee = total_price.intValue();
    Integer chogibeeyong = Integer.valueOf((int)(reg_car_price * 1.1D * 0.2D));
    double temp = Math.pow((1.0F + interest_rate), 48.0D);
    double halbu = reg_car_price * 1.1D * 0.8D * interest_rate * temp / (temp - 1.0D);
    
    if (displacement.intValue() == 0)
      return 0; 
    if (displacement.intValue() < 1600) {
      monthlyfee = 18 * displacement.intValue() / 12;
    }
    else if (displacement.intValue() < 2500) {
      monthlyfee = 19 * displacement.intValue() / 12;
    } else {
      
      monthlyfee = 24 * displacement.intValue() / 12;
    } 
    Integer bozeung = Integer.valueOf(0);
    if (tax_type.equals("면세")) {
      bozeung = Integer.valueOf((int)(reg_car_price * 1.1D * 0.5D));
      janga = Integer.valueOf((int)(reg_car_price * 1.1D * janga_rate));
      gamga = Integer.valueOf((int)(reg_car_price * 1.1D * (1.0F - janga_rate)));
    } else {
      bozeung = Integer.valueOf((int)(reg_car_price * (1.0F + cal_tax_rate) * 1.1D * 0.5D));
      janga = Integer.valueOf((int)(reg_car_price * (1.0F + cal_tax_rate) * 1.1D * janga_rate));
      gamga = Integer.valueOf((int)(reg_car_price * (1.0F + cal_tax_rate) * 1.1D * (1.0F - janga_rate)));
    } 
    
    Integer chungdangum = Integer.valueOf((int)(reg_car_price * 1.1D * 0.025D / 12.0D * 0.3D));
    Integer hapgae_outcome = Integer.valueOf((int)((tagsong + regist_fee.intValue() + tax.intValue() + chogibeeyong.intValue()) + halbu * 48.0D + 
        reg_car_price * 1.1D * fees_rate + (
        752000 * period / 12) + 
        chungdangum.intValue() + (
        monthlyfee * period) + (
        36000 * period / 12) + 
        bozeung.intValue()));

    Integer hapgae_income = Integer.valueOf((int)(bozeung.intValue() + reg_car_price * 1.1D * 0.017D + reg_car_price * 0.1D + 
        reg_car_price * 0.7D * maker_rate + janga.intValue() + gamga.intValue()));
    Integer gwanlibi = Integer.valueOf((hapgae_outcome.intValue() - hapgae_income.intValue()) / period);
    rent_fee = (int)((gamga.intValue() / period + gwanlibi.intValue()) * 1.1D);
    System.out.printf("MIDAS: 차량가격:%d %s %f%% 기준가격:%f 등록비:%d 개소세: %d 취득원가:%d 기간:%d \n초기비용:%d 잔가:%d 감가:%d \n수입합계:%d 지출합계:%d 할부:%f 보증:%d 관리비:%d 탁송:%d 자동차세:%d 할부총액:%d 렌트료:%d\n", new Object[] {
          price, tax_type, Double.valueOf(tax_rate / 1.3D * 100.0D), Double.valueOf(reg_car_price), regist_fee, tax, total_price, Integer.valueOf(period), 
          chogibeeyong, janga, gamga, hapgae_income, hapgae_outcome, Double.valueOf(halbu), 
          bozeung, gwanlibi, Integer.valueOf(tagsong), Integer.valueOf(monthlyfee * period), Integer.valueOf((int)(halbu * 48.0D)), Integer.valueOf(rent_fee)
        });
    rent_fee = (rent_fee + 999) / 1000 * 1000;
    System.out.printf("탁송: %d 등록비:%d 개소세:%d 초기비용:%d 할부총액:%d 수수료:%d 보험:%d 보험충당:%d 자동차세:%d 검사:%d, 보증:%d 합계:%d\n", new Object[] { 
          Integer.valueOf(tagsong), regist_fee, tax, chogibeeyong, Integer.valueOf((int)(halbu * 48.0D)), 
          Integer.valueOf((int)(reg_car_price * 1.1D * fees_rate)), 
          Integer.valueOf(752000 * period / 12), 
          Integer.valueOf((int)(reg_car_price * 1.1D * 0.025D * 0.3D * period / 12.0D)), 
          Integer.valueOf(monthlyfee * period), 
          Integer.valueOf(36000 * period / 12), 
          bozeung, 
          Integer.valueOf(tagsong + regist_fee.intValue() + tax.intValue() + chogibeeyong.intValue() + (int)(halbu * 48.0D) + 
            (int)(reg_car_price * 1.1D * fees_rate) + 
            752000 * period / 12 + 
            (int)(reg_car_price * 1.1D * 0.025D * 0.3D * period / 12.0D) + 
            monthlyfee * period + 
            36000 * period / 12 + 
            bozeung.intValue()) });
    return rent_fee;
  }

  @RequestMapping({"/updatemodelranking"})
  public String updateModelRanking(@RequestBody HashMap<String, Object> map) {
    System.out.println(map.toString());
    this.sqlSession.update("admin.model_ranking", map);
    return "";
  }
  
  @RequestMapping({"/basecolorlist"})
  public List<BaseColorVO> baseColorList() {
    return this.sqlSession.selectList("admin.basecolorlist");
  }
}


/* Location:              D:\web\base\ROOT\WEB-INF\classes\!\com\harmony\longterm\dao\CarDao.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */