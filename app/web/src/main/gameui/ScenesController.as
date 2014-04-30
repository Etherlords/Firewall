package gameui 
{
	import display.ui.DisplayManager;
	import flash.events.Event;
	import ui.style.StylesCollector;
	
	public class ScenesController 
	{
		[Inject]
		public var styleCollector:StylesCollector;
		
		public var displayManager:DisplayManager;
		
		public function ScenesController() 
		{
			inject(this);
		}
		
		public function initialize():void 
		{
			describe('vfs', Event.COMPLETE, onVfsReady);
			describe('global', "autorised", onAutorised);
			
			displayManager.scene = "preloaderScene";
		}
		
		public function showGame():void 
		{
			displayManager.scene = "gameScene";
		}
		
		private function onAutorised(e:Event):void 
		{
			displayManager.scene = "mainMenuScene";
			//displayManager.scene = "hangarScene";
		}
		
		private function onVfsReady(e:Event):void 
		{
			styleCollector.currentStyles();
			
			displayManager.scene = "autorisationScene";
		}
		
	}

}