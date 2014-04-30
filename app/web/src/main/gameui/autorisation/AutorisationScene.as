package gameui.autorisation 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import ui.scenes.AbstractScene;
	
	public class AutorisationScene extends AbstractScene 
	{
		private var autorisationScreenView:AutorisationView;
		private var step:Number = 0;
		
		public function AutorisationScene() 
		{
			super();
			
		}
		
		override public function initialize():void 
		{
			super.initialize();
			
			autorisationScreenView = new AutorisationView()
			sceneView = autorisationScreenView;
			
			var timer:Timer = new Timer(100, 17);
			timer.addEventListener(TimerEvent.TIMER, onTime);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onComplete);
			timer.start();
		}
		
		private function onComplete(e:TimerEvent):void 
		{
			broadcast("global", new Event("autorised"));
		}
		
		private function onTime(e:TimerEvent):void 
		{
			autorisationScreenView.text = "Обождите идет авторизация" + (".......".substr(0, step));
			
			step++;
			if (step == 4)
				step = 0
		}
		
	}

}