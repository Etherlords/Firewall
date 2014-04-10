package ui 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import ui.style.Style;
	
	public class ScrollContainer extends UIComponent 
	{
		private var _content:UIComponent;
		private var container:UIComponent;
		
		private var scrollBar:ScrollBar;
		
		private var _w:Number;
		private var _h:Number;
		
		public function ScrollContainer(scrollBar:ScrollBar, w:Number, h:Number, style:Style=null) 
		{
			this.scrollBar = scrollBar;
			_h = h;
			_w = w;
			
			super(style);	
		}
		
		override public function update():void 
		{
			super.update();
			
			if (_content)
			{
				scrollBar.pageSize = _content.height;
				scrollBar.size = _h;
				_content.y = -((_content.height - _h) * scrollBar.position);
			}
		}
		
		public function setSize(w:Number, h:Number):void
		{
			_w = w;
			_h = h;
			
			applySize();
		}
		
		private function applySize():void
		{
			if(container)
				container.scrollRect = new Rectangle(0, 0, _w, _h);
		}
		
		override protected function configureChildren():void 
		{
			super.configureChildren();
			scrollBar.size = _h;
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		private function onMouseWheel(e:MouseEvent):void 
		{
			if (!isInside(e.localX, e.localY, this))
				return;
				
			this.scrollBar.position -= e.delta / 100;
		}
		
		private function isInside(x:Number, y:Number, obj:DisplayObject):Boolean
		{
			return x > obj.x && obj.x < obj.width + obj.x && y > obj.y && y < obj.height + obj.y
		}
		
		override protected function layoutChildren():void 
		{
			super.layoutChildren();
			
			scrollBar.x = _w - scrollBar.width
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			container = new UIComponent();
		}
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			addComponent(container);
			addComponent(scrollBar);
		}
		
		public function get content():UIComponent 
		{
			return _content;
		}
		
		public function set content(value:UIComponent):void 
		{
			_content = value;
			
			if (!_content)
				container.removeComponent(_content);
				
			_content = value;
			
			container.addComponent(_content);
			
			applySize();
		}
		
	}

}