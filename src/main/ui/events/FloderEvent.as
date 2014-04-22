package ui.events 
{
	import core.fileSystem.IFile;
	import flash.events.Event;
	
	public class FloderEvent extends Event 
	{
		public static const OPEN:String = "open";
		public static const SELECT:String = "select";
		
		public var selected:IFile;
		
		public function FloderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, selected:IFile = null) 
		{
			super(type, bubbles, cancelable);
			this.selected = selected;
		}
		
		override public function clone():Event 
		{
			return new FloderEvent(type, bubbles, cancelable, selected);
		}
		
	}

}