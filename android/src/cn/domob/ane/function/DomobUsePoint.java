package cn.domob.ane.function;

import java.util.Locale;

import cn.domob.data.OErrorInfo;
import cn.domob.data.OManager;
import cn.domob.data.OManager.ConsumeStatus;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class DomobUsePoint implements FREFunction {
	private static final String TAG = "DomobUsePoint";
	@Override
	public FREObject call(FREContext context, FREObject[] arg1) {
		String point;
		try{
			point = arg1[0].getAsString();
		}catch(Exception e){
			return null;
		}
		NativeExtensionShared.sManager.setConsumeListener(new OManager.ConsumeListener() {

			@Override
			public void onConsumeFailed(
					final OErrorInfo mDomobOfferWallErrorInfo) {
				NativeExtensionShared.event("eDMOfferWallConsumeFail", mDomobOfferWallErrorInfo.toString());

			}

			@Override
			public void onConsumeSucess(final int point, final int consumed, final ConsumeStatus cs) {
				
				Object[] data = new Object[2];
				data[0] = point;
				data[1] = consumed;
				String jsonFormat = "{'totalPoint:'%d,'consumedPoint':%d}";
				String result = String.format(Locale.getDefault(), jsonFormat , data);
				
				switch (cs) {
				case SUCCEED:
					NativeExtensionShared.event("eDMOfferWallConsumeSuccess", result);
					break;
				case OUT_OF_POINT:
					NativeExtensionShared.event("eDMOfferWallConsumeFail", "eDMOfferWallConsumeInsufficient");
					break;
				case ORDER_REPEAT:
					NativeExtensionShared.event("eDMOfferWallConsumeFail", "eDMOfferWallConsumeDuplicateOrder");
					break;

				default:
					NativeExtensionShared.event("eDMOfferWallConsumeFail", "unkonw");
					break;
				}
			}
		});
		if(point==null || point.equals("")){
			NativeExtensionShared.showToast("消费积分不能为空");
		}else{
			NativeExtensionShared.sManager.consumePoints(Integer.parseInt(point));
			NativeExtensionShared.event(TAG, "start use point");
		}
		return null;
	}

}
