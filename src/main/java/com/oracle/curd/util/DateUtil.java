package com.oracle.curd.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
	public String getDate() {
		Date now = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sf.format(now);
	}
}
