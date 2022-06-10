package com.harmony.longterm.utils;

import java.io.Serializable;

import lombok.Data;

@Data
public class SelectBoxVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String text;
	private String value;

}
