package ui 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import ui.style.Style;
	
	public class ImageViewer extends UIComponent 
	{
		public var chromePattern:BitmapData;
		private var image:BitmapData;
		
		public var isUseChrome:Boolean;
		
		private var chrome:ScaleBitmap;
		private var imageView:Bitmap;
		
		private var _width:Number;
		private var _height:Number;
		
		private var invalidateSize:Boolean = true;
		
		public function ImageViewer(image:BitmapData = null, _width:Number = 100, _height:Number = 100, style:Style=null) 
		{
			this._height = _height;
			this._width = _width;
			this.image = image;
			
			super(style);
		}
		
		override public function get width():Number 
		{
			return _width;
		}
		
		override public function set width(value:Number):void 
		{
			if (_width == value)
				return;
				
			_width = value;
			
			invalidateSize = true;
		}
		
		override public function get height():Number 
		{
			return _height;
		}
		
		override public function set height(value:Number):void 
		{
			if (_height == value)
				return;
				
			_height = value;
			
			invalidateSize = true;
		}
		
		override public function update():void 
		{
			applySize();
			
			super.update();
		}
		
		override protected function applyStyle():void 
		{
			super.applyStyle();
			
			if (chromePattern)
				isUseChrome = true;
		}
		
		override protected function buildStyleSheet():void 
		{
			super.buildStyleSheet();
			
			addStyleSheet("chrome", "chromePattern");
			addStyleSheet("width", "width");
			addStyleSheet("height", "height");
			//addStyleSheet("isUseChrome", "isUseChrome");
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			createChrome();
			imageView = new Bitmap(image);
		}
		
		private function createChrome():void 
		{
			if (!isUseChrome)
				return;
				
			chrome = new ScaleBitmap(chromePattern);
		}
		
		override protected function layoutChildren():void 
		{
			super.layoutChildren();
			
			imageView.x = imageView.y = 1;
		}
		
		override protected function configureChildren():void 
		{
			super.configureChildren();
			
			if (chrome)
				chrome.scale9Grid = new Rectangle(1, 1, 1, 1);
		}
		
		private function applySize():void
		{
			if (!invalidateSize)
				return;
				
			imageView.width = _width - 2;
			imageView.height = _height - 2;
			
			if (chrome)
			{
				chrome.width = _width;
				chrome.height = _height;
			}
			
			invalidateSize = false;
		}
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			if (chrome)
				addChild(chrome);
				
			addChild(imageView);
		}
		
	}

}