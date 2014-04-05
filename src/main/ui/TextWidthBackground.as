package ui 
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import ui.style.Style;

	public class TextWidthBackground extends Text
	{
		private var background:ScaleBitmap;
		
		public var backgroundPattern:BitmapData;
		
		public function TextWidthBackground(style:Style=null) 
		{
			super(style);
		}
		
		override protected function buildStyleSheet():void 
		{
			super.buildStyleSheet();
			
			addStyleSheet('background', 'backgroundPattern');
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			background = new ScaleBitmap(backgroundPattern);
		}
		
		override protected function configureChildren():void 
		{
			super.configureChildren();
			
			background.scale9Grid = new Rectangle(1, 1, 1, 1);
		}
		
		override protected function layoutChildren():void 
		{
			super.layoutChildren();
			
			
		}
		
		override protected function updateDisplayList():void 
		{
			addChild(background);
			super.updateDisplayList();
		}
		
		override protected function validateSize():void 
		{
			super.validateSize();
			
			background.setSize(_width, _height);
		}
		
	}

}