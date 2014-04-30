package ui 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import ui.style.Style;
	
	public class Animation extends UIComponent 
	{
		private var bitmap:Bitmap;
		private var animations:Vector.<BitmapData>;
		private var frameRate:int;
		
		private var currentFrame:Number = 0;
		private var loop:Boolean;
		
		public function Animation(animations:Vector.<BitmapData>, frameRate:int, loop:Boolean = false, style:Style=null) 
		{
			this.loop = loop;
			this.frameRate = frameRate;
			this.animations = animations;
			
			super(style);
		}
		
		override public function update():void 
		{
			currentFrame++;
			
			super.update();
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			bitmap = new Bitmap();
		}
		
		override protected function buildStyleSheet():void 
		{
			super.buildStyleSheet();
		}
		
	}

}