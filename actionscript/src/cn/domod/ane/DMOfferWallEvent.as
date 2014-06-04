package cn.domod.ane
{
	public class DMOfferWallEvent
	{
		public function DMOfferWallEvent()
		{
		}
		
		public static const DM_WALL_LOADED:String = "dmOfferWallManagerDidFinishLoad";
		public static const DM_TOTALPOINT_RECEIVED:String = "receivedTotalPoint";
		public static const DMOfferWallConsumeSuccess:String = "eDMOfferWallConsumeSuccess";
		public static const DMOfferWallConsumeInsufficient:String = "eDMOfferWallConsumeInsufficient";
		public static const DMOfferWallConsumeDuplicateOrder:String = "eDMOfferWallConsumeDuplicateOrder";
		public static const didCheckEnableStatus:String = "didCheckEnableStatus";
	}
}