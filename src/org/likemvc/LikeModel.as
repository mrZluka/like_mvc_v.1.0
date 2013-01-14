/**
 * @author Mykhailo Stoianchuk
 */

 
package org.likemvc 
{
	import org.likemvc.interfaces.IDestroy;
	import org.likemvc.interfaces.ILikeMVCPart;
	public class LikeModel implements ILikeMVCPart, IDestroy
	{
		private var _rootController:RootController = null;
		private var _data:Object = null;
		
		public function LikeModel() 
		{
			
		}
		
		public function onRegister():void
		{
			
		}
		
		public function onDestroy():void
		{
			_data = null;
			_rootController = null;
		}
		
		protected function notify(notification:String, ...params):void
		{
			_rootController.notify(notification, params);
		}
		
		public function set rootController(value:RootController):void 
		{
			_rootController = value;
		}
		
		public function get data():Object {	return _data;	}		
		public function set data(value:Object):void {	_data = value;}
		
	}

}