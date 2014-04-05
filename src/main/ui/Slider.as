package ui 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import ui.effects.OverEffect;
	import ui.style.Style;
	
	public class Slider extends UIComponent 
	{
		public var fullBackgoundView:BitmapData;
		public var emptyBackgoundView:BitmapData;
		public var sliderView:BitmapData;
		
		private var fullBackground:ScaleBitmap;
		private var emptyBackground:ScaleBitmap;
		private var slider:Bitmap;
		
		private var _size:Number = 250;
		private var position:Number = 0;
		private var stepSize:Number = 1;
		
		private var isDragSlider:Boolean;
		
		public function Slider(position:Number = 0, stepSize:Number = 1, size:Number = 250, style:Style = null) 
		{
			_size = size;
			this.position = position;
			this.stepSize = stepSize;
			
			super(style);
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			fullBackground = new ScaleBitmap(fullBackgoundView);
			emptyBackground = new ScaleBitmap(emptyBackgoundView);
			slider = new Bitmap(sliderView);
		}
		
		override protected function buildStyleSheet():void 
		{
			super.buildStyleSheet();
			
			addStyleSheet("fullBackground", "fullBackgoundView");
			addStyleSheet("emptyBackground", "emptyBackgoundView");
			addStyleSheet("sliderView", "sliderView");
		}
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			addChild(fullBackground);
			addChild(emptyBackground);
			addChild(slider);
		}
		
		override protected function configureChildren():void 
		{
			fullBackground.scale9Grid = new Rectangle(1, 1, 1, 1);
			emptyBackground.scale9Grid = new Rectangle(1, 1, 1, 1);
			
			super.configureChildren();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			applySize();
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			this.addEventListener(MouseEvent.RELEASE_OUTSIDE, onMouseUp);
			
			setEffect(new OverEffect());
		}
		
		public override function update():void 
		{
			if (!isDragSlider)
				return;
				
			calculatePosition(mouseX);
		}
		
		private function calculatePosition(mouseX:Number):void
		{
			var x:Number = mouseX;
			
			if (x < 0)
				x = 0;
				
			if (x > _size)
				x = _size;
				
			position = x / _size;
			
			setPosition();
		}
		
		private function setPosition():void
		{
			slider.x = -slider.width / 2 + _size * position;
			fullBackground.width = _size * position;
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			isDragSlider = false;
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			var isSliderClicked:Boolean = isInside(e.localX, e.localY, slider);
			
			if (!isSliderClicked)
			{
				calculatePosition(mouseX);
			}
			
			isDragSlider = true
		}
		
		private function isInside(x:Number, y:Number, obj:DisplayObject):Boolean
		{
			return x > obj.x && obj.x < obj.width + obj.x && y > obj.y && y < obj.height + obj.y
		}
		
		public function get size():Number 
		{
			return _size;
		}
		
		override protected function layoutChildren():void 
		{
			super.layoutChildren();
			
			slider.y = (fullBackground.height - slider.height) / 2;
			
			setPosition();
		}
		
		public function set size(value:Number):void 
		{
			if (_size == value)
				return;
			
			_size = value;
			applySize();
		}
		
		private function applySize():void
		{
			fullBackground.setSize(_size, 10);
			emptyBackground.setSize(_size, 10);
			
			layoutChildren();
		}
		
	}

}