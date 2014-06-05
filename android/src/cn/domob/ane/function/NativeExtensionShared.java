package cn.domob.ane.function;

import android.app.Activity;
import android.util.Log;
import android.widget.Toast;

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
	
	public static void showToast(final String content) {
		((Activity) context.getActivity()).runOnUiThread(new Runnable() {
			@Override
			public void run() {
				Toast.makeText(context.getActivity(), content, Toast.LENGTH_SHORT).show();
			}
		});
	}
	
}
