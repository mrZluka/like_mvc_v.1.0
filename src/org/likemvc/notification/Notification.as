/**
 * @author Mykhailo Stoianchuk
 */

package org.likemvc.notification 
{
	public class Notification
	{
		private static var _totalIndex:int = 0;
		public static function createNotification(name:String, moduleName:String = ''):String
		{
			return  moduleName + "::" + name + '_' + _totalIndex++;
		}
	}
}

