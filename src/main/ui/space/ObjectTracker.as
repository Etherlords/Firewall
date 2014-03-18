package ui.space 
{
	import characters.Actor;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class ObjectTracker extends Sprite 
	{
		private var _actor:Actor;
		
		private var icon:Bitmap;
		private var info:TextField;
		
		public function ObjectTracker() 
		{
			super();
			
			initialize();
		}
		
		private function initialize():void 
		{
			info = new TextField();
			icon = new Bitmap();
			
			addChild(icon);
			addChild(info);
		}
		
		public function update():void
		{
			if (!actor)
				return;
				
			align();
		}
		
		private function align():void 
		{
			icon.x = -icon.width / 2;
			icon.y = -icon.height / 2;
			
			info.x = icon.x + (icon.width - info.width) / 2;
			info.y = icon.y + icon.height * 5;
		}
		
		public function get actor():Actor 
		{
			return _actor;
		}
		
		public function set actor(value:Actor):void 
		{
			_actor = value;
		}
		
	}

}