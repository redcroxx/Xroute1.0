package xrt.lingoframework.utils;

import java.util.HashMap;
import java.util.Map;

public class LDataMap extends HashMap<String, Object> {

	private static final long serialVersionUID = 1L;

	public LDataMap() {
		super();
	}

	public LDataMap(Map<? extends String, ? extends Object> m) {
		super(m);
	}

	public String getString(String key) {
		Object obj = super.get(key);
		if (obj == null || obj.toString().trim().length() == 0) {
			return "";
		}

		return obj.toString().trim();
	}

	public int getInt(String key) {
		Object obj = super.get(key);
		if (obj == null || obj.toString().trim().length() == 0) {
			return 0;
		}

		return Integer.parseInt(obj.toString().trim());
	}

	public boolean getBoolean(String key) {
		return Boolean.valueOf(String.valueOf(super.get(key)).trim());
	}

	public short getShort(String key) {
		Object obj = super.get(key);
		if (obj == null || obj.toString().trim().length() == 0) {
			return 0;
		}

		return Short.parseShort(obj.toString().trim());
	}

	public byte getByte(String key) {
		Object obj = super.get(key);
		if (obj == null || obj.toString().trim().length() == 0) {
			return 0;
		}

		return Byte.parseByte(obj.toString().trim());
	}

	public long getLong(String key) {
		Object obj = super.get(key);
		if (obj == null || obj.toString().trim().length() == 0) {
			return 0;
		}

		return Long.parseLong(obj.toString().trim());
	}

	public float getFloat(String key) {
		Object obj = super.get(key);
		if (obj == null || obj.toString().trim().length() == 0) {
			return 0;
		}

		return Float.parseFloat(obj.toString().trim());
	}

	public double getDouble(String key) {
		Object obj = super.get(key);
		if (obj == null || obj.toString().trim().length() == 0) {
			return 0;
		}

		return Double.parseDouble(obj.toString().trim());
	}
}