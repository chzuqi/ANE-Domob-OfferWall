package cn.domod.ane
{
	public class DMOfferWallEvent
	{
		/**
		 * 插页积分墙加载完成 
		 */		
		public static const DM_WALL_LOADED:String = "dmOfferWallManagerDidFinishLoad";
		/**
		 * 用户积分状态返回 
		 */		
		public static const DM_TOTALPOINT_RECEIVED:String = "receivedTotalPoint";
		/**
		 * 积分消费成功 
		 */		
		public static const DMOfferWallConsumeSuccess:String = "eDMOfferWallConsumeSuccess";
		/**
		 * 积分消费失败 
		 */		
		public static const eDMOfferWallConsumeFail:String = "eDMOfferWallConsumeFail";
		/**
		 * 积分墙可用状态返回 
		 */		
		public static const didCheckEnableStatus:String = "didCheckEnableStatus";
		/**
		 * 积分墙关闭 
		 */		
		public static const dmOfferWallManagerDidClosed:String = "dmOfferWallManagerDidClosed";
	}
}