package cn.domob.ane.function;

import android.app.Activity;
import android.util.Log;
import cn.domob.data.OErrorInfo;
import cn.domob.data.OManager.AddVideoWallListener;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class DomobShowVideoWall implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] arg1) {
		// TODO Auto-generated method stub
		NativeExtensionShared.context = context;
		//缓存屏幕方向
		final int orientation = ((Activity) NativeExtensionShared.context.getActivity()).getRequestedOrientation();
		NativeExtensionShared.sManager.setAddVideoWallListener(new AddVideoWallListener() {
			
			@Override
			public void onAddWallSucess() {
				Log.i("", "onAddWallSucess");
			}
			
			@Override
			public void onAddWallFailed(OErrorInfo mOErrorInfo) {
				Log.i("", "onAddWallFailed");
			}
			
			@Override
			public void onAddWallClose() {
				Log.i("", "onAddWallClose");
				//退出墙后需要再次设置屏幕方向
				((Activity) NativeExtensionShared.context.getActivity())
				.setRequestedOrientation(orientation);
			}
		});
		NativeExtensionShared.sManager.presentVideoWall();
		
		return null;
	}

}
