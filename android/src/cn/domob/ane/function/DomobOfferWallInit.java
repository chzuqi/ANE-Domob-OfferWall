package cn.domob.ane.function;

import android.util.Log;
import cn.domob.data.OManager;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class DomobOfferWallInit implements FREFunction {

	private static final String TAG = "DomobOfferWallInit";
	@Override
	public FREObject call(FREContext context, FREObject[] arg1) {
		NativeExtensionShared.context = context;
		String publisherId;
		Log.d(TAG, "DM init begin");
		try{
			publisherId = arg1[0].getAsString();
		}catch(Exception e){
			Log.d(TAG, "args error!");
			return null;
		}
		NativeExtensionShared.PUBLISHID = publisherId;
		NativeExtensionShared.sManager = new OManager(context.getActivity(), publisherId);
		Log.d(TAG, "DM init complete");
		return null;
	}

}
