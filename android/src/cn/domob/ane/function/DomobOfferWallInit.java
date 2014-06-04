package cn.domob.ane.function;

import cn.domob.data.OManager;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class DomobOfferWallInit implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] arg1) {
		NativeExtensionShared.context = context;
		String publisherId;
		try{
			publisherId = arg1[0].getAsString();
		}catch(Exception e){
			return null;
		}
		NativeExtensionShared.PUBLISHID = publisherId;
		NativeExtensionShared.sManager = new OManager(context.getActivity(), publisherId);
		return null;
	}

}
