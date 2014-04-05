package ui 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import ui.effects.OverEffect;
	import ui.style.Style;
	
	public class ScrollBar extends UIComponent
	{
		public var backgroundPattern:BitmapData;
		public var sliderPattern:BitmapData;
		
		private var slider:ScaleBitmap;
		private var background:ScaleBitmap;
		
		private var _size:Number;
		private var _position:Number;
		private var _pageSize:Number;
		
		private var invalidateView:Boolean = true;
		private var isDrag:Boolean = false;
		
		private var onPressMouseDelta:Number = 0;
		
		public function ScrollBar(size:Number = 200, position:Number = 0, pageSize:Number = 200, style:Style = null) 
		{
			_pageSize = pageSize;
			_position = position;
			_size = size;
			
			super(style);
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			slider = new ScaleBitmap(sliderPattern);
			background = new ScaleBitmap(backgroundPattern);
		}
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			addChild(background);
			addChild(slider);
		}
		
		override protected function buildStyleSheet():void 
		{
			super.buildStyleSheet();
			
			addStyleSheet("background", "backgroundPattern");
			addStyleSheet("slider", "sliderPattern");
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			this.addEventListener(MouseEvent.RELEASE_OUTSIDE, onMouseUp);
			
			setEffect(new OverEffect());
		}
		
		override public function update():void 
		{
			super.update();
			
			if (isDrag)
				calculatePosition(mouseY);
			
			if (invalidateView)
				validateView();
		}
		
		private function calculatePosition(mouseY:Number):void
		{
			var y:Number = mouseY - onPressMouseDelta;
			
			if (y < 0)
				y = 0;
				
			var actualSize:Number = _size - slider.height
				
			if (y > actualSize)
				y = actualSize;
				
			_position = y / actualSize;
			
			setPosition();
		}
		
		private function setPosition():void
		{
			slider.y = (_size - slider.height) * _position;
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			isDrag = false;
			onPressMouseDelta = 0;
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			var isSliderClicked:Boolean = isInside(e.localX, e.localY, slider);
			
			if (!isSliderClicked)
			{
				onPressMouseDelta = slider.height / 2;
				calculatePosition(mouseY);
			}
			else
			{
				onPressMouseDelta = mouseY - slider.y;
			}
			
			isDrag = true;
		}
		
		private function isInside(x:Number, y:Number, obj:DisplayObject):Boolean
		{
			return x > obj.x && obj.x < obj.width + obj.x && y > obj.y && y < obj.height + obj.y
		}
		
		override protected function configureChildren():void 
		{
			slider.width = 6;
			background.width = 2;
			
			slider.scale9Grid = new Rectangle(1, 1, 1, 1);
			
			super.configureChildren();
		}
		
		override protected function layoutChildren():void 
		{
			super.layoutChildren();
			
			setPosition();
			background.x = (slider.width - background.width) / 2;
		}
		
		private function validateView():void 
		{
			invalidateView = false;
			
			var sliderHeight:Number = _size * (_size / _pageSize);
			if (sliderHeight > _size)
				sliderHeight = _size;
				
			slider.height = sliderHeight;
			background.height = _size;
			
			layoutChildren();
		}
		
		public function get size():Number 
		{
			return _size;
		}
		
		public function set size(value:Number):void 
		{
			if (_size == value)
				return;
				
			_size = value;
			
			invalidateView = true;
		}
		
		public function get position():Number 
		{
			return _position;
		}
		
		public function set position(value:Number):void 
		{
			if (value < 0)
				value = 0;
				
			if (value > 1)
				value = 1;
			
			if (_position == value)
				return;
				
			_position = value;
			
			invalidateView = true;
		}
		
		public function get pageSize():Number 
		{
			return _pageSize;
		}
		
		public function set pageSize(value:Number):void 
		{
			if (_pageSize == value)
				return;
				
			_pageSize = value;
			
			invalidateView = true;
		}
		
	}

}