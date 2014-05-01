package ui 
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import ui.style.Style;

	public class CheckBoxWithLabel extends UIComponent 
	{
		private var _label:String;
		private var _selected:Boolean;
		private var checkBox:CheckBox;
		private var textField:TextField;
		
		private var textFormat:TextFormat = new TextFormat();
		
		public function CheckBoxWithLabel(selected:Boolean = false, label:String = '', style:Style = null) 
		{
			_selected = selected;
			_label = label;
			
			super(style);
		}
		
		public function get label():String 
		{
			return _label;
		}
		
		public function set label(value:String):void 
		{
			if (_label == value)
				return;
				
			_label = value;
			
			layoutChildren();
		}
		
		public function set font(value:String):void
		{
			textFormat.font = value;
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
			
			checkBox.selected = value;
		}
		
		
		override protected function buildStyleSheet():void 
		{
			super.buildStyleSheet();
			
			addStyleSheet('font', 'font');
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			textField = new TextField();
			checkBox = new CheckBox(_selected, style);
		}
	
		override protected function layoutChildren():void 
		{
			super.layoutChildren();
			
			checkBox.x = textField.width;
			checkBox.y = (textField.height - checkBox.height) / 2;
		}
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			addChild(textField);
			addChild(checkBox);
		}
		
		override protected function configureChildren():void 
		{
			super.configureChildren();
			
			textField.defaultTextFormat = textFormat;
			textField.textColor = 0xFFFFFF;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.selectable = false; 
			
			textField.text = _label;
			
			checkBox.mouseChildren = false;
			checkBox.mouseEnabled = false;	
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			this.selected = !_selected;
		}
		
		override protected function destroyChildren():void 
		{
			super.destroyChildren();
			
			checkBox.destroy();
		}
		
	}

}