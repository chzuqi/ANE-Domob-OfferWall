package cn.domob.ane.function;

import android.util.Log;

import cn.domob.data.OManager;

import com.adobe.fre.FREContext;

public class NativeExtensionShared {
	public static FREContext context = null;
	
	public static String PUBLISHID = "";
	public static OManager sManager;
	
	public static void event(String code,String level  ){
		Log.d(code, "event" + ":"+level );
		context.dispatchStatusEventAsync(code, level );
	}
	
}
