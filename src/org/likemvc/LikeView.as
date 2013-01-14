/**
 * @author Mykhailo Stoianchuk
 */

 package org.likemvc 
{
	import flash.display.DisplayObjectContainer;
	import org.likemvc.interfaces.ILikeMVCPart;
	import org.likemvc.notifier.Notifier;
	import org.likemvc.vl.LikeVL;
	public class LikeView implements ILikeMVCPart
	{
		private var _rootController:RootController = null;
		private var _content:DisplayObjectContainer;
		private var _vlNotifier:Notifier = null;
		
		public function LikeView() 
		{
			_vlNotifier = new Notifier();
		}
		
		public function onRegister():void
		{
			
		}
		
		public function onDestroy():void
		{
			_vlNotifier.onDestroy();
			_vlNotifier = null;
			_rootController = null;
			_content = null;
		}
		
		protected function registerVLNotification(notification:String, func:Function):void
		{
			_vlNotifier.registerNotification(notification, func);
		}
		
		protected function removeVLNotification(notification:String, func:Function):void
		{
			_vlNotifier.removeNotification(notification, func);
		}
		
		public function createVL(vlClass:Class, content:DisplayObjectContainer, isInitNow:Boolean = true):*
		{
			var vl:LikeVL = new vlClass;
			vl.content = content;
			vl.notifier = _vlNotifier;
			if (isInitNow) vl.init();
			return vl;
		}
		
		public function registerNotification(notification:String, func:Function):void
		{
			_rootController.registerNotification(notification, func, RootController.VIEW);
		}
		
		public function notify(notification:String, ...params):void
		{
			_rootController.notify(notification, params);
		}
		
		public function removeNotification(notification:String, func:Function):void
		{
			_rootController.removeNotification(notification, func, RootController.VIEW);
		}
		
		public function set rootController(value:RootController):void 
		{
			_rootController = value;
		}
		
		public function getModel(modelClass:Class):LikeModel
		{
			return _rootController.getModel(modelClass);
		}
		
		public function get content():DisplayObjectContainer {	return _content;}		
		public function set content(value:DisplayObjectContainer):void {	_content = value;}
		
	}

}