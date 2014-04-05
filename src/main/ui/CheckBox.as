package ui 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import ui.style.Style;
	
	public class CheckBox extends UIComponent 
	{
		public var selectedView:BitmapData;
		public var normalView:BitmapData;
		
		private var _selected:Boolean = false;
		
		private var background:Bitmap = new Bitmap();
		
		public function CheckBox(selected:Boolean = false, style:Style = null) 
		{
			super(style);
			
			_selected = selected;
		}
		
		public function get selected():Boolean 
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void 
		{
			if (value == _selected)
				return
			
			_selected = value;
			setView();
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			background = new Bitmap();
		}
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			addChild(background);
		}
		
		override protected function destroyChildren():void 
		{
			super.removeChildren();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			setView();
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			this.selected = !_selected;
		}
		
		override protected function buildStyleSheet():void 
		{
			super.buildStyleSheet();
			
			addStyleSheet("selectedView", "selectedView");
			addStyleSheet("normalView", "normalView");
		}
		
		private function setView():void
		{
			background.bitmapData = _selected? selectedView:normalView;
		}
		
	}

}