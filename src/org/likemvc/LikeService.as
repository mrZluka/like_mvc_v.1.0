/**
 * @author Mykhailo Stoianchuk
 */
	
package org.likemvc 
{	
	
	public class LikeService extends LikeModel
	{
		private var _rootController:RootController = null;
		
		public function LikeService() 
		{
			
		}
		
		override public function onDestroy():void 
		{
			super.onDestroy();
			_rootController = null;
		}
		
		public function registerNotification(notification:String, func:Function):void
		{
			_rootController.registerNotification(notification, func, RootController.SERVICE);
		}
		
		override public function set rootController(value:RootController):void 
		{
			super.rootController = value;
			_rootController	 = value;
		}
		
		public function removeNotification(notification:String, func:Function):void
		{
			_rootController.removeNotification(notification, func, RootController.SERVICE);
		}
	}
	
}