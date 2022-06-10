<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>


  <link rel="stylesheet" href="/css/static.css">
  <link rel="stylesheet" href="/css/admin.css">
  <link rel="stylesheet" href="/css/adm-form.css">


    <div class="main_content content_box">
    <h2>
      차량등록
    </h2>
 <form action="usedcarAction">
    <div class="register_wrap">
      <div class="left_area">
        <h3 class="sub_title">
          차량정보
        </h3>
        <ul class="info_list">
          <li class="info_item">
            <p class="info_title">차량번호</p>
            <div class="input_wrap">
              <input type="text" placeholder="입력창(텍스트)" name="car_no">
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">제조사</p>
            <div class="input_wrap">
              <select class="box_style" name="maker">
                <option>현대</option>
                <option>기아</option>
                <option>르노삼성</option>
                <option>쉐보레</option>
                <option>쌍용</option>
              </select>
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">차량명</p>
            <div class="input_wrap">
              <input type="text" placeholder="입력창(텍스트)" name="name">
              
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">차량연식</p>
            <div class="input_wrap select_wrap">
              <select class="box_style" name="vehicle_year">
<c:forEach var="year" begin="2010" end="2050" step="1">
	<option value="${year}">${year}년<option>
</c:forEach>              

              </select>
              <select class="box_style" name="vehicle_mon">
<c:forEach var="month" begin="1" end="12" step="1">
	<option value="${month}">${month}월식<option>
</c:forEach>              
              </select>
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">계약기간 <br>(표준)</p>
            <div class="input_wrap sub_wrap">
              <input class="box_style" type="text" name="period">
              <div class="sub_inputwrap">
                <span>
                  기타
                </span>
                <input class="box_style" type="text" name="another">
              </div>
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">보증금</p>
            <div class="input_wrap">
              <input class="box_style" type="text" name="deposit">
              <span class="suffix">
                원
              </span>
            </div>
          </li>
          <li class="info_item">
            <p class="info_title ">무심사 <br>(렌트료)</p>
            <div class="input_wrap price_wrap">
              <div class="price_item">
                <input class="box_style" type="text" name="rentfee">
                <span class="suffix">
                  원
                </span>
              </div>
              <div class="price_item sub_price_item">
                <span class="prefix">하이렌트</span>
                <input class="box_style" type="text" name="rentfee_1">
                <span class="suffix">
                  원
                </span>
              </div>
              <div class="price_item sub_price_item">
                <span class="prefix">마이다스</span>
                <input class="box_style" type="text" name="rentfee_24">
                <span class="suffix">
                  원
                </span>
              </div>

            </div>
          </li>
          <li class="info_item">
            <p class="info_title ">차량가격</p>
            <div class="input_wrap ">
              <input class="box_style" type="text" name="trim_price">
              <span class="suffix">
                원
              </span>
            </div>
          </li>
          <li class="info_item">
            <p class="info_title ">만기인수가</p>
            <div class="input_wrap ">
              <input class="box_style" type="text" name="acquisition">
              <span class="suffix">
                원
              </span>
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">출력순서</p>
            <div class="input_wrap">
              <input type="text" placeholder="입력창(텍스트)" name="rank">
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">판매여부</p>
            <div class="input_wrap">
              <select class="box_style" name="status">
                <option>판매</option>
                <option>계약</option>
                <option>출고완료</option>
                <option>계약취소</option>
                <option>진행</option>
                <option>완료</option>
              </select>
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">차량구분</p>
            <div class="input_wrap">
              <select class="box_style" name="car_type">
                <option>신차</option>
                <option>중고차</option>
              </select>
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">주행거리</p>
            <div class="input_wrap">
              <input class="text_box" type="text" placeholder="입력창(텍스트)" name="distance">
              <span class="suffix">
                km
              </span>
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">연료</p>
            <div class="input_wrap">
              <select class="box_style" name="fuel">
                <option>LPG</option>
                <option>휘발유</option>
                <option>경유</option>
                <option>전기</option>
                <option>하이브리드</option>
              </select>
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">차량 대표 <br>이미지</p>
            <div class="input_wrap file_wrap">
              <label for="img_upload">파일선택</label>
              <input type="file" id="img_upload" name="image">
            </div>
          </li>
        </ul>
      </div>
      <div class="right_area">
        <h3 class="sub_title">
          옵션
        </h3>
        <ul class="option_list">
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox" name="option">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>네비게이션</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>전동시트</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>블랙박스</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>전방감지센서</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>후방감지센서</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>후방카메라</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox">
              <div class="check_style">
                <img src=/img/check_blue.svg" alt="">
              </div>
              <span>크루즈컨트롤</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>스마트키</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>하이패스</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>열선시트</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>통풍시트</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>열선핸들</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>썬루프</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>엔진오일 2회</span>
            </label>
          </li>
          <li class="option_item">
            <label class="check_lable">
              <input type="checkbox">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>엔진오일 4회</span>
            </label>
          </li>
        </ul>

        <h3 class="sub_title">
          아이콘
        </h3>
        <ul class="option_list icon_list">
          <li class="option_item icon_item">
            <label class="check_lable">
              <input type="checkbox" name="icon">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>엔진오일 2회</span>
            </label>
          </li>
          <li class="option_item icon_item">
            <label class="check_lable">
              <input type="checkbox">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>엔진오일 4회</span>
            </label>
          </li>
          <li class="option_item icon_item">
            <label class="check_lable">
              <input type="checkbox">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>즉시출고</span>
            </label>
          </li>
          <li class="option_item icon_item">
            <label class="check_lable">
              <input type="checkbox">
              <div class="check_style">
                <img src="/img/check_blue.svg" alt="">
              </div>
              <span>신차급</span>
            </label>
          </li>
        </ul>

        <div class="text_section">
          <h3 class="sub_title">
            기타사항
          </h3>
          <div class="textarea_wrap">
            <textarea name="etc_memo"></textarea>
          </div>
        </div>

        <div class="text_section">
          <h3 class="sub_title">
            사고이력
          </h3>
          <div class="textarea_wrap">
            <textarea name="accident"></textarea>
          </div>
        </div>
      </div>
    </div>
    <div class="bottom_area">
      <textarea></textarea>
      <div class="button_wrap">
        <button>미리보기</button>
        <button type="submit">등록</button>
      </div>
    </div>
  </div>
</form>