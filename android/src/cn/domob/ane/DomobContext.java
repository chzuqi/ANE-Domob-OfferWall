package cn.domob.ane;

import java.util.HashMap;
import java.util.Map;

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
		return map;
	}

}
