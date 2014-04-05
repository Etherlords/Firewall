package ui 
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import ui.effects.OverEffect;
	import ui.style.Style;
	
	public class Button extends UIComponent 
	{
		private var background:ScaleBitmap;
		
		public var selectedPattern:BitmapData;
		public var normalPattern:BitmapData;
		
		private var _selected:Boolean = false;
		
		private var _width:Number = 140;
		private var _height:Number = 50;
		private var _label:String;
		private var textField:TextField;
		
		private var textFormat:TextFormat = new TextFormat();
		
		public function Button(style:Style=null, label:String = "default") 
		{
			_label = label;
			super(style);
		}
		
		public function set textAlign(align:String):void
		{
			textFormat.align = align;
		}
		
		public function set textColor(color:uint):void
		{
			textFormat.color = color;
		}
		
		public function set textSize(size:Number):void
		{
			textFormat.size = size;
		}
		
		public function set font(font:String):void
		{
			textFormat.font = font;
		}
		
		override protected function buildStyleSheet():void 
		{
			super.buildStyleSheet();
			addStyleSheet("normal", "normalPattern");
			addStyleSheet("selected", "selectedPattern");
			addStyleSheet("textSize", "textSize");
			addStyleSheet("font", "font");
			addStyleSheet("textColor", "textColor");
			addStyleSheet("textAlign", "textAlign");
			
			setEffect(new OverEffect());
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			textField = new TextField();
			background = new ScaleBitmap(normalPattern)
		}
		
		override protected function configureChildren():void 
		{
			super.configureChildren();
			
			background.scale9Grid = new Rectangle(1, 1, 1, 1);
			background.setSize(_width, _height);
			textField.width = _width;
			
			textField.defaultTextFormat = textFormat;
			textField.mouseEnabled = false;
			textField.selectable = false;
			//textField.autoSize = TextFieldAutoSize.LEFT;
			textField.text = _label;
			textField.height = textField.textHeight + 5;
		}
		
		override protected function layoutChildren():void 
		{
			super.layoutChildren();
			
			textField.x = (background.width - textField.width) / 2;
			textField.y = (background.height - textField.textHeight) / 2;
		}
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			addChild(background);
			addChild(textField);
		}
		
		private function setView():void
		{
			background.bitmapData = _selected? selectedPattern:normalPattern;
			background.setSize(_width, _height);
			
			textField.width = _width;
		}
		
		public function get selected():Boolean 
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void 
		{
			if (_selected == value)
				return;
				
			_selected = value;
			setView();
		}
		
		override public function get width():Number 
		{
			return _width;
		}
		
		override public function set width(value:Number):void 
		{
			if (value == _width)
				return;
				
			_width = value;
			textField.width = _width;
			background.width = _width;
			layoutChildren();
		}
		
		override public function get height():Number 
		{
			return _height;
		}
		
		override public function set height(value:Number):void 
		{
			if (value == _height)
				return;
				
			_height = value;
			
			textField.height = _height;
			background.height = _height;
			layoutChildren();
		}
		
		public function get label():String 
		{
			return _label;
		}
		
		public function set label(value:String):void 
		{
			_label = value;
		}
		
	}

}