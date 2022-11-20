package xrt.lingoframework.utils;

import java.util.LinkedHashMap;
import java.util.Map;

public class LDataLinkedMap extends LinkedHashMap<String, Object> {

	private static final long serialVersionUID = 1L;

	public LDataLinkedMap() {
		super();
	}

	public LDataLinkedMap(Map<? extends String, ? extends Object> m) {
		super(m);
	}

	public String getString(String key) {
		String str = "";
		if (super.get(key) == null) {
			str = "";
		} else {
			str = String.valueOf(super.get(key));
		}

		return str;
	}

	public int getInt(String key) {
		return (int) super.get(key);
	}

	public boolean getBoolean(String key) {
		return (boolean) super.get(key);
	}

	public short getShort(String key) {
		return (short) super.get(key);
	}

	public byte getByte(String key) {
		return (byte) super.get(key);
	}

	public long getLong(String key) {
		return (long) super.get(key);
	}

	public float getFloat(String key) {
		return Float.parseFloat(String.valueOf(super.get(key)));
	}

	public double getDouble(String key) {
		return Double.parseDouble(String.valueOf(super.get(key)));
	}
}