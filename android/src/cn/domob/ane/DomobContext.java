package cn.domob.ane;

import java.util.HashMap;
import java.util.Map;

import cn.domob.ane.function.DomobGetPoint;
import cn.domob.ane.function.DomobNothing;
import cn.domob.ane.function.DomobOfferWallInit;
import cn.domob.ane.function.DomobShowOfferWall;
import cn.domob.ane.function.DomobShowVideoWall;
import cn.domob.ane.function.DomobUsePoint;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;

public class DomobContext extends FREContext {
	
	private static final String DMINIT = "DMInit";
	private static final String DMCONSUME = "DMConsume";
	private static final String DMCHECKSOCRE = "DMcheckSocre";
	private static final String DMCHECKSTATUS = "DMcheckStatus";
	private static final String DMSHOWOFFERWALL = "DMShowOfferWall";
	private static final String DMSHOWVIDEOOFFERWALL = "DMShowVideoOfferWall";
	private static final String DMLOADINTERSTITIALOFFERWALL = "DMLoadInterstitialOfferWall";
	private static final String DMSHOWINTERSTITIALOFFERWALL = "DMShowInterstitialOfferWall";
	@Override
	public void dispose() {

	}

	@Override
	public Map<String, FREFunction> getFunctions() {
		Map<String, FREFunction> map = new HashMap<String, FREFunction>();
		//映射
//		map.put(UM_FEEDBACK_INIT, new FeedbackInit());
//		map.put(UM_FEEDBACK_OPEN, new FeedbackOpen());
		map.put(DMINIT, new DomobOfferWallInit());
		map.put(DMCONSUME, new DomobUsePoint());
		map.put(DMCHECKSOCRE, new DomobGetPoint());
		map.put(DMCHECKSTATUS, new DomobNothing());
		map.put(DMSHOWOFFERWALL, new DomobShowOfferWall());
		map.put(DMSHOWVIDEOOFFERWALL, new DomobShowVideoWall());
		//这两个安卓没啊，蛋疼
		map.put(DMLOADINTERSTITIALOFFERWALL, new DomobNothing());
		map.put(DMSHOWINTERSTITIALOFFERWALL, new DomobNothing());
		return map;
	}

}
