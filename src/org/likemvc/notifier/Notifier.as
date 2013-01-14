/**
 * @author Mykhailo Stoianchuk
 */

 package org.likemvc.notifier 
{
	import flash.utils.Dictionary;
	import org.likemvc.interfaces.IDestroy;
	public class Notifier implements IDestroy
	{
		private var _notificationList:Dictionary = null;
		
		public function Notifier() { _notificationList = new Dictionary() }
		
		public function registerNotification(notification:String, func:Function):void
		{
			if (!_notificationList[notification])
			{
				_notificationList[notification] = [];
			}
			
			_notificationList[notification].push(func);
		}
		
		public function notify(notifyName:String, params:Array):Array
		{
			var arr:Array = _notificationList[notifyName];
			var funcResult:Array = null;
			if (arr && arr.length)
			{
				for (var i:int = 0; i < arr.length; i++) 
				{
					var func:Function = arr[i];
					if (func == null) return null;
					
					if (func.length)
					{
						params.length = func.length;
						//try{
							funcResult = func.apply(null, params);
						//}catch (e:TypeError)
						//{
							//dropError(params, e, notifyName);
						//}
					}
					else
					{
						funcResult = func();
					}
				}
			}
			
			return funcResult;
		}
		
		public function removeNotification(notificationName:String, func:Function):void
		{
			var arr:Array = _notificationList[notificationName];
			if (arr && arr.length)
			{
				var index:int = arr.indexOf(func);
				if (index != -1)
				{
					arr.splice(index, 1);
				}
			}
		}
		
		public function onDestroy():void 
		{
			for each(var notifycationList:Array in _notificationList) 
			{
				notifycationList = [];
			}
		}
		
		private function dropError(params:Array, e:TypeError, notifyName:String):void 
		{
			var errMsg:String = "Can't convert types. Please recheck params in notification: '" + notifyName + "'\nParams:\n";
			for (var j:int = 0; j < params.length; j++) 
			{
				errMsg += params[j] + '\n';
			}
			errMsg += "\nOrigin:\n" + e.message;
			if (e.errorID == 1034)
			{
				throw errMsg;
			}
			else
			{
				throw e.getStackTrace();
			}
		}
		
		
		
	}

}