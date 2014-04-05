package ui 
{
	import core.collections.Iterable;
	
	public class StyleSheet 
	{
		private var _styles:Iterable = new Iterable();
		
		public function StyleSheet() 
		{
			
		}
		
		public function bindStyle(styleKey:String, fieldToBind:String):void
		{
			_styles.addItem(styleKey, fieldToBind);
		}
		
		public function get styles():Iterable 
		{
			return _styles;
		}
	}

}