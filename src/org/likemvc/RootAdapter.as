/**
 * @author Mykhailo Stoianchuk
 */

package org.likemvc 
{
	import flash.display.DisplayObjectContainer;
	import org.likemvc.interfaces.IDestroy;
	public class RootAdapter implements IDestroy
	{
		private var _rootController:RootController = null;
		
		public function RootAdapter() 
		{
			_rootController = new RootController();
		}
		
		public function registerController(controllerClass:Class):void
		{
			_rootController.registerController(controllerClass);
		}
		
		public function registerView(viewClass:Class, content:DisplayObjectContainer = null):LikeView
		{
			return _rootController.registerView(viewClass, content);
		}
		
		public function registerModel(modelClass:Class, data:Object = null):void
		{
			_rootController.registerModel(modelClass, data);
		}
		
		public function notify(notification:String, params:Array = null):void
		{
			_rootController.notify(notification, params);
		}
		
		public function registerNotification(notification:String, func:Function):void
		{
			_rootController.registerNotification(notification, func, RootController.CONTROLLER);
		}
		
		public function removeNotification(notification:String, func:Function):void
		{
			_rootController.removeNotification(notification, func, RootController.CONTROLLER);
		}
		
		public function getModel(model:Class):LikeModel
		{
			return _rootController.getModel(model);
		}
		
		public function onDestroy():void 
		{
			if (_rootController)
			{
				_rootController.onDestroy();
				_rootController = null;
			}
		}
	}

}