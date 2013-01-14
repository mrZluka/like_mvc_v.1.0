/**
 * @author Mykhailo Stoianchuk
 */

 package org.likemvc.vl 
{
	import flash.display.DisplayObjectContainer;
	import org.likemvc.interfaces.IDestroy;
	import org.likemvc.notifier.Notifier;
	public class LikeVL implements IDestroy
	{
		private var _content:DisplayObjectContainer = null;
		private var _notifier:Notifier = null;
		//private var _name:String = '';
		
		public function LikeVL() { }
		
		public function init():void
		{
			
		}
		
		public function notifyView(notification:String, ...params):void
		{
			_notifier.notify(notification, params);
		}
		
		public function onDestroy():void 
		{
			_content = null;
			_notifier.onDestroy();
		}
		
		public function get content():DisplayObjectContainer {	return _content;}		
		public function set content(value:DisplayObjectContainer):void {_content = value;}
		
		//public function get name():String {return _name;}
		//public function set name(value:String):void {_name = value;}
		
		public function set notifier(value:Notifier):void {_notifier = value;}
		
	}

}