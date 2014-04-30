package ui 
{
	import core.collections.SimpleMap;
	
	public class UIFactory 
	{
		private var components:SimpleMap = new SimpleMap();
		
		public function UIFactory() 
		{
			addToContext(this);
		}
		
		public function createComponent(type:String, style:String):void
		{
			
		}
		
	}

}