package cn.domob.ane.function;

import java.util.Locale;

import cn.domob.data.OErrorInfo;
import cn.domob.data.OManager;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class DomobGetPoint implements FREFunction {

	private static final String TAG = "DomobGetPoint";
	@Override
	public FREObject call(FREContext context, FREObject[] arg1) {
		// TODO Auto-generated method stub
		NativeExtensionShared.context = context;
		NativeExtensionShared.sManager.setCheckPointsListener(new OManager.CheckPointsListener() {

			@Override
			public void onCheckPointsSucess(final int point,
					final int consumed) {
				Object[] data = new Object[2];
				data[0] = point;
				data[1] = consumed;
				String jsonFormat = "{'totalPoint:'%d,'consumedPoint':%d}";
				String result = String.format(Locale.getDefault(), jsonFormat , data);
				NativeExtensionShared.event("receivedTotalPoint", result);
			}

			@Override
			public void onCheckPointsFailed(
					final OErrorInfo mDomobOfferWallErrorInfo) {
				NativeExtensionShared.event(TAG, mDomobOfferWallErrorInfo.toString());
			}
		});
		NativeExtensionShared.sManager.checkPoints();
		NativeExtensionShared.event(TAG, "start check point");
		return null;
	}

}
