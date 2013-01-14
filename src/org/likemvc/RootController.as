/**
 * @author Mykhailo Stoianchuk
 */

 package org.likemvc 
{
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;
	import org.likemvc.interfaces.IDestroy;
	import org.likemvc.interfaces.ILikeMVCPart;
	import org.likemvc.notifier.Notifier;
	internal class RootController implements IDestroy
	{
		public static const SERVICE:String = 'service';
		public static const CONTROLLER:String = 'controller';
		public static const VIEW:String = 'view';
		
		private var _controllersList:Dictionary = null;
		private var _viewsList:Dictionary = null;
		private var _modelsList:Dictionary = null;
		private var _serviceList:Dictionary = null;
		
		private var _serviceNotifier:Notifier = null;
		private var _viewNotifier:Notifier = null;
		private var _controllerNotifier:Notifier = null;
		
		public function RootController() 
		{
			_controllersList = new Dictionary();
			_viewsList = new Dictionary();
			_modelsList = new Dictionary();
			_serviceList = new Dictionary();
			
			_controllerNotifier = new Notifier();
			_viewNotifier = new Notifier();
			_serviceNotifier = new Notifier();
		}
		
		public function removeController(controllerClass:Class):void{	removePart(_controllersList, controllerClass);	}		
		public function removeView(viewClass:Class):void{					removePart(_viewsList, viewClass);				}		
		public function removeModel(modelClass:Class):void	{				removePart(_modelsList, modelClass);			}
		public function removeService(serviceClass:Class):void	{				removePart(_serviceList, serviceClass);			}
		
		private function removePart(container:Dictionary, object:Class):void
		{
			var obj:ILikeMVCPart = container[object];
			obj.onDestroy();
			obj = null;
			delete container[object];
		}
		
		public function registerView(viewClass:Class, content:DisplayObjectContainer):LikeView
		{
			var view:LikeView = new viewClass();
			view.rootController = this;
			view.content = content;
			_viewsList[viewClass] = view;
			view.onRegister();
			return view;
		}
		
		public function registerModel(modelClass:Class, data:Object):void
		{
			var model:LikeModel = new modelClass();
			model.rootController = this;
			model.data = data;
			_modelsList[modelClass] = model;
			model.onRegister();
		}
		
		public function registerService(serviceClass:Class, data:Object = null):void
		{
			var service:LikeService= new serviceClass();
			service.rootController = this;
			service.data = data;
			_serviceList[serviceClass] = service;
			service.onRegister();
		}
		
		public function registerController(controllerClass:Class):void
		{
			var controller:LikeController = new controllerClass();
			controller.rootController = this;
			_controllersList[controllerClass] = controller;
			controller.onRegister();
		}
		
		public function getModel(modelClass:Class):LikeModel
		{
			return _modelsList[modelClass];
		}
		
		public function getView(viewClass:Class):LikeView
		{
			return _viewsList[viewClass];
		}
		
		public function getService(serviceClass:Class):LikeService
		{
			return _serviceList[serviceClass];
		}
		
		public function notify(notifyName:String, params:Array):void
		{
			var result:Array = _controllerNotifier.notify(notifyName, params);
			if (result) params = result;
			
			_serviceNotifier.notify(notifyName, params);			
			if (result) params = result;
			
			_viewNotifier.notify(notifyName, params);
		}
		
		public function registerNotification(notification:String, func:Function, owner:String):void
		{
			if (owner == CONTROLLER) _controllerNotifier.registerNotification(notification, func);
			else if (owner == SERVICE) _serviceNotifier.registerNotification(notification, func);
			else if (owner == VIEW) _viewNotifier.registerNotification(notification, func);
		}
		
		public function removeNotification(notification:String, func:Function, owner:String):void
		{
			if (owner == CONTROLLER) _controllerNotifier.removeNotification(notification, func);
			else if (owner == SERVICE) _serviceNotifier.removeNotification(notification, func);
			else if (owner == VIEW) _viewNotifier.removeNotification(notification, func);
		}
		
		public function onDestroy():void 
		{
			_controllersList = destroyList(_controllersList);
			_viewsList = destroyList(_viewsList);
			_modelsList = destroyList(_modelsList);
			_serviceList = destroyList(_serviceList);
			
			_serviceNotifier.onDestroy();
			_viewNotifier.onDestroy();
			_controllerNotifier.onDestroy();
		}
		
		private function destroyList(list:Dictionary):Dictionary
		{
			for each (var likeClass:IDestroy in list) 
			{
				likeClass.onDestroy();
				likeClass = null;
			}
			
			return null;
		}
		
	}

}