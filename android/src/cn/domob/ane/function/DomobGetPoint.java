package cn.domob.ane.function;

import android.annotation.SuppressLint;
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
//				NSString *result = [NSString stringWithFormat:@"{'totalPoint:'%d,'consumedPoint':%d}", [totalPoint integerValue], [consumedPoint integerValue]];
//			    DISPATCH_STATUS_EVENT(self.context, [@"receivedTotalPoint" UTF8String], [result UTF8String]);
				String result = String.format("{'totalPoint:'%d,'consumedPoint':%d}", point, consumed);
				NativeExtensionShared.event("receivedTotalPoint", result);
//				showToast("总积分：" + point + "总消费积分：" + consumed);
//				showText("总积分：" + point + "总消费积分：" + consumed);
			}

			@Override
			public void onCheckPointsFailed(
					final OErrorInfo mDomobOfferWallErrorInfo) {
				NativeExtensionShared.event(TAG, mDomobOfferWallErrorInfo.toString());
			}
		});
		NativeExtensionShared.sManager.checkPoints();
		return null;
	}

}
