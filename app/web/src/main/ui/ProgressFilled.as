package ui 
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import ui.style.Style;
	
	public class ProgressFilled extends UIComponent
	{
		private var _width:Number = 200;
		private var _height:Number = 25;
		
		public var bgPattern:BitmapData;
		public var progressPattern:BitmapData;
		
		private var background:ScaleBitmap;
		private var progressView:ScaleBitmap
		
		private var _progress:Number = 0;
		
		private var invalidateView:Boolean = true;
		
		public var fillStyle:int = 0;
		
		public function ProgressFilled(style:Style, progress:Number = 0.5, _width:Number = 200, _height:Number = 25) 
		{
			this._height = _height;
			this._width = _width;
			this._progress = progress;
			
			super(style);
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
			
			invalidateView = true;
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
			
			invalidateView = true;
		}
		
		override protected function buildStyleSheet():void 
		{
			super.buildStyleSheet();
			
			addStyleSheet("width", "width");
			addStyleSheet("height", "height");
			addStyleSheet("background", "bgPattern");
			addStyleSheet("progress", "progressPattern");
		}
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			addChild(background);
			addChild(progressView);
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			background = new ScaleBitmap(bgPattern);
			progressView = new ScaleBitmap(progressPattern);
		}
		
		override protected function configureChildren():void 
		{
			super.configureChildren();
			
			progressView.scale9Grid = new Rectangle(1, 1, 1, 1);
			background.scale9Grid = new Rectangle(1, 1, 1, 1);
			
			background.setSize(_width, _height);
		}
		
		override protected function initialize():void 
		{
			super.initialize();
		}
		
		override public function update():void
		{
			draw();
		}
		
		private function draw():void 
		{
			if (!invalidateView)
				return;
				
			progressView.setSize((_width - 2) * progress, _height - 2);
			invalidateView = false;
			
			layoutChildren()
		}
		
		override protected function layoutChildren():void 
		{
			super.layoutChildren();
			
			this.progressView.x = 1;
			this.progressView.y = (_height - progressView.height) / 2;
		}
		
		public function get progress():Number 
		{
			return _progress;
		}
		
		public function set progress(value:Number):void 
		{
			_progress = value;
			invalidateView = true;
		}
	}

}