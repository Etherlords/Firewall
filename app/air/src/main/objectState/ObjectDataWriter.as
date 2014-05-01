package objectState 
{
	import flash.utils.ByteArray;
	import flash.utils.Proxy;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class ObjectDataWriter extends Proxy 
	{
		
		public var writeStream:ByteArray = new ByteArray();
		
		public function ObjectDataWriter() 
		{
			super();
			
		}
		
		private function write(value:*, name:String):void
		{
			
		}
		
	}

}