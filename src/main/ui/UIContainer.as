package ui 
{
	import flash.events.Event;
	import ui.style.Style;
	
	public class UIContainer extends UIComponent 
	{
		
		public function UIContainer(style:Style = null) 
		{
			super(style);
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			addEventListener(Event.ENTER_FRAME, onFrameEnter);
		}
		
		private function onFrameEnter(e:Event):void 
		{
			update();
		}
		
	}

}