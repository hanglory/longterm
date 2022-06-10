package com.harmony.longterm.utils;


import java.lang.reflect.Field;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.mysql.cj.util.StringUtils;

public class VOUtils
{
    
    /**
     * List 타입 여부를 반환한다.
     * 
     * @param object
     * @return
     * @throws Exception
     */
    public static boolean isList(Object object) throws Exception {
        if (object instanceof List || object instanceof ArrayList || object instanceof LinkedList) {
            return true;
        }
        
        return false;
    }
    
    /**
     * List 타입 여부를 반환한다.
     * 
     * @param type
     * @return
     * @throws Exception
     */
    public static boolean isList(Type type) throws Exception {
        if(List.class.isAssignableFrom(((Class<?>) type))) {
            return true;
        }
        
        return ArrayList.class.isAssignableFrom((Class<?>) type);
    }
    
    /**
     * 두개의 모델간 필드명이 같을 경우 데이터를 convert 한다. 단, 반환되는 모델의 파라미터는 class이다.
     * 
     * @param inObject
     * @param outClass
     * @return
     * @throws Exception
     */
    public static Object convert(Object inObject, Class<?> outClass) throws Exception {
        try {
            return convert(inObject, outClass.newInstance());
        }
        catch (InstantiationException e) {
            throw new Exception(e);
        }
        catch (IllegalAccessException e) {
            throw new Exception(e);
        }
    }
    
    /**
     * 두개의 모델간 필드명이 같을 경우 데이터를 convert 한다. 단, 반환되는 모델의 파라미터는 Object이다.
     * 
     * @param inObject
     * @param outObject
     * @return
     * @throws Exception
     */
    public static Object convert(Object inObject, Object outObject) throws Exception {
        if (inObject == null || outObject == null) {
            return null;
        }
        
        Type type = inObject.getClass().getGenericSuperclass();
        Class<?> inClass = null;
        Class<?> outClass = outObject.getClass();
        
        if (VOUtils.isList(type)) {
            List<Object> returnList = new ArrayList<Object>();
            List<?> inList = (List<?>) inObject;
            
            for (Object object : inList) {
                inClass = object.getClass();
                
                returnList.add(_convertReturn(object, outObject, inClass, outClass));
            }
            return returnList;
        } else {
            inClass = inObject.getClass();
            
            return _convertReturn(inObject, outObject, inClass, outClass);
        }
    }
    
    /**
     * 두개의 모델간 필드명이 같을 경우 데이터를 convert 한다.
     * 
     * @param inObject
     * @param outObject
     * @param inClass
     * @param outClass
     * @return
     * @throws Exception
     */
    private static Object _convertReturn(Object inObject, Object outObject, Class<?> inClass, Class<?> outClass) throws Exception {
        // 해당
        outObject = _convert(inObject, outObject, inClass, outClass);
        
        // super : IN 재귀
        Class<?> inSuperClass = inClass.getSuperclass();
        
        if (inSuperClass != null) {
            outObject = _convertReturn(inObject, outObject, inSuperClass, outClass);
        }
        
        // super : OUT 재귀
        Class<?> outSuperClass = outClass.getSuperclass();
        
        if (outSuperClass != null) {
            outObject = _convertReturn(inObject, outObject, inClass, outSuperClass);
        }
        
        return outObject;
    }
    
    /**
     * 두개의 모델간 필드명이 같을 경우 데이터를 convert 한다.
     * 
     * @param inObject
     * @param outObject
     * @param inClass
     * @param outClass
     * @return
     * @throws Exception
     */
    private static Object _convert(Object inObject, Object outObject, Class<?> inClass, Class<?> outClass) throws Exception {
        Object value = null;
        
        // abstract 모델 convert
        Field[] inFields = inClass.getDeclaredFields();
        Field[] outFields = outClass.getDeclaredFields();
        
        for (Field inField : inFields) {
            for (Field outField : outFields) {
                if (inField.getName().equals(outField.getName())) {
                    try {
                        outField.setAccessible(true);
                        value = outField.get(outObject);
                        
                        // 값이 없는 경우에만
                        if (isNull(value)) {
                            inField.setAccessible(true);
                            setValue(inField.get(inObject), outField, outObject);
                        }
                        break;
                    } catch (IllegalArgumentException e) {
                        throw new Exception(e);
                    } catch (IllegalAccessException e) {
                        throw new Exception(e);
                    }
                }
            }
        }
        
        return outObject;
    }
    
    /**
     * 해당 필드의 데이터를 세팅한다.
     * 
     * @param inField
     * @param outField
     * @param outObject
     * @throws Exception
     */
    private static void setValue(Object value, Field outField, Object outObject) throws Exception {
        try {
            outField.setAccessible(true);
            
            Class<?> cls = outField.getType();
            
            if (value != null) {
                if (cls.equals(value.getClass())) {
                    outField.set(outObject, outField.getType().cast(value));
                } else {
                    if (cls == int.class) {
                        outField.set(outObject, Integer.parseInt((String) value));
                    } else if (cls == double.class) {
                        outField.set(outObject, Double.parseDouble((String) value));
                    } else if (cls == float.class) {
                        outField.set(outObject, Float.parseFloat((String) value));
                    } else if (cls == long.class) {
                        outField.set(outObject, Long.parseLong((String) value));
                    } else {
                        outField.set(outObject, outField.getType().cast(value));
                    }
                }
            }
        }
        catch (Exception e) {
            // e.printStackTrace();
        }
    }
    
    /**
     * 타입별 null을 체크한다.
     * 
     * @param value
     * @return
     * @throws Exception
     */
    private static boolean isNull(Object value) throws Exception {
        if (value instanceof Integer) {
            if (((Integer) value) == 0) {
                return true;
            }
        } else if (value instanceof Double) {
            if (((Double) value) == 0.0) {
                return true;
            }
        } else if (value instanceof Float) {
            if (((Float) value) == 0.0) {
                return true;
            }
        } else if (value instanceof Long) {
            if (((Long) value) == 0) {
                return true;
            }
        } else {
            if (value == null) {
                return true;
            }
        }
        
        return false;
    }
    
    public static Map<String, Object> convert(Object object) throws Exception {
    	Map<String, Object> map = new HashMap<String, Object>();
    	
        if (object == null) {
            return map;
        }
        
        Object value = null;
        List<Field> fields = getAllFields(object.getClass());
        
        for (Field field : fields) {
        	field.setAccessible(true);
            value = field.get(object);
            
            if(value != null) {
            	if (value instanceof String) {
                    if( ! StringUtils.isNullOrEmpty(String.valueOf(value))) {
                    	map.put(field.getName(), value);
                    }
            	} else if(value instanceof Integer) {
           			map.put(field.getName(), value);
            	} else if(value instanceof Boolean) {
           			map.put(field.getName(), value);
            	}
            }
        }
        
        return map;
    }
    
    public static Map<String, Object> convert(Object object, String[] targetFiels) throws Exception {
    	Map<String, Object> map = new HashMap<String, Object>();
    	
    	if (object == null || targetFiels == null) {
    		return map;
    	}
    	
    	Object value = null;
    	List<Field> fields = getAllFields(object.getClass());
    	
    	for(String targetField : targetFiels) {
    		for (Field field : fields) {
    			if(field.getName().equalsIgnoreCase(targetField)) {
    				field.setAccessible(true);
    				value = field.get(object);
    				
    				if(value != null) {
    					if (value instanceof String) {
    						if( ! StringUtils.isNullOrEmpty(String.valueOf(value))) {
    							map.put(field.getName(), value);
    						}
    					} else if(value instanceof Integer) {
    						map.put(field.getName(), value);
    					} else if(value instanceof Boolean) {
    						map.put(field.getName(), value);
    					}
    				}
    			}
    		}
    	}
    	
    	return map;
    }
    
    private static List<Field> getAllFields(Class<?> cls) throws Exception {
    	List<Field> fields = new ArrayList<Field>();
    	
    	fields.addAll(Arrays.asList(cls.getDeclaredFields()));
    	
    	Class<?> superClazz = cls.getSuperclass();
    	
        if(superClazz != null){
            fields.addAll(getAllFields(superClazz));
        }
    	
    	return fields;
    }
    
}
