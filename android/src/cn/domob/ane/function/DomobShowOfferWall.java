package cn.domob.ane.function;

import cn.domob.data.OErrorInfo;
import cn.domob.data.OManager;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class DomobShowOfferWall implements FREFunction {

	private static final String TAG = "DomobShowOfferWall";
	@Override
	public FREObject call(FREContext context, FREObject[] arg1) {
		// TODO Auto-generated method stub
		NativeExtensionShared.context = context;
		
		NativeExtensionShared.sManager.setAddWallListener(new OManager.AddWallListener() {

			@Override
			public void onAddWallFailed(
					OErrorInfo mDomobOfferWallErrorInfo) {

				NativeExtensionShared.showToast(mDomobOfferWallErrorInfo.toString());
			}

			@Override
			public void onAddWallClose() {
				//此处可以设置为横屏...
				//but how?
			}

			@Override
			public void onAddWallSucess() {

			}
		});
		NativeExtensionShared.sManager.loadOfferWall();
		NativeExtensionShared.event(TAG, "offer wall show~");
		return null;
	}

}
