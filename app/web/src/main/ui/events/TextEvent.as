package ui.events 
{
	import flash.events.Event;
	

	public class TextEvent extends Event 
	{
		public static const TEXT_ENTER:String = "textEnter";
		
		public var text:String;
		
		public function TextEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, text:String = '') 
		{
			super(type, bubbles, cancelable);
			this.text = text;
			
		}
		
		override public function clone():Event 
		{
			return new TextEvent(type, bubbles, cancelable, text);
		}
		
	}

}