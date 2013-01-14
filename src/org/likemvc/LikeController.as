/**
 * @author Mykhailo Stoianchuk
 */

package org.likemvc 
{
	import flash.display.DisplayObjectContainer;
	import org.likemvc.interfaces.ILikeMVCPart;
	public class LikeController implements ILikeMVCPart
	{
		private var _rootController:RootController = null;
		
		public function LikeController() {}
		
		public function onRegister():void
		{
			
		}
		
		public function onDestroy():void
		{
			_rootController = null;
		}
		
		public function getModel(modelClass:Class):LikeModel
		{
			return _rootController.getModel(modelClass);
		}
		
		public function getView(viewClass:Class):LikeView
		{
			return _rootController.getView(viewClass);
		}
		
		public function getService(serviceClass:Class):LikeService
		{
			return _rootController.getService(serviceClass);
		}
		
		public function registerNotification(notification:String, func:Function):void
		{
			_rootController.registerNotification(notification, func, RootController.CONTROLLER);
		}
		
		public function notify(notification:String, ...params):void
		{
			_rootController.notify(notification, params);
		}
		
		public function removeNotification(notification:String, func:Function):void
		{
			_rootController.removeNotification(notification, func, RootController.CONTROLLER);
		}
		
		public function removeView(viewClass:Class):void
		{
			_rootController.removeView(viewClass);
		}
		
		public function registerView(viewClass:Class, content:DisplayObjectContainer = null):LikeView
		{
			return _rootController.registerView(viewClass, content);
		}
		
		public function removeModel(modelClass:Class):void
		{
			_rootController.removeModel(modelClass);
		}
		
		public function registerModel(modelClass:Class, data:Object = null):void
		{
			_rootController.registerModel(modelClass, data);
		}
		
		public function removeService(serviceClass:Class):void
		{
			_rootController.removeService(serviceClass);
		}
		
		public function registerService(serviceClass:Class, data:Object = null):void
		{
			_rootController.registerService(serviceClass, data);
		}
		
		public function registerController(controllerClass:Class):void
		{
			_rootController.registerController(controllerClass);
		}
		
		public function removeController(controllerClass:Class):void
		{
			_rootController.removeController(controllerClass);
		}
		
		public function set rootController(value:RootController):void 
		{
			_rootController = value;
		}
	}

}