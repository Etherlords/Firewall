package ui 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import ui.style.Style;
	
	public class ScrollContainer extends UIComponent 
	{
		private var _content:UIComponent;
		private var container:UIComponent;
		
		private var scrollBar:ScrollBar;
		
		private var _w:Number;
		private var _h:Number;
		
		public function ScrollContainer(style:Style=null, scrollBar:ScrollBar = null, w:Number = 100, h:Number = 250) 
		{
			this.scrollBar = scrollBar;
			_h = h;
			_w = w;
			
			super(style);	
		}
		
		private var contentOldHeight:Number = 0;
		
		override public function update():void 
		{
			super.update();
			
			if (_content && _content.height != contentOldHeight)
			{
				contentOldHeight = _content.height;
				setContentPosition();
			}
		}
		
		private function setContentPosition():void 
		{
			if (_content)
			{
				scrollBar.pageSize = contentOldHeight;
				scrollBar.size = _h;
				
				var heightDelta:Number = _h - contentOldHeight;
				
				if (heightDelta > 0)
					heightDelta = 0;
				
				_content.y = heightDelta * scrollBar.position;
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
				container.scrollRect = new Rectangle(0, 0, _w - scrollBar.width, _h);
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
		
		private static var topLeft:Point = new Point();
		private static var bottomRight:Point = new Point();
		
		private function onMouseWheel(e:MouseEvent):void 
		{
			topLeft.setTo(this.x, this.y);
			topLeft = localToGlobal(topLeft);
			bottomRight.setTo(topLeft.x + width, topLeft.y + height);
			
			if (!isInside(e.stageX, e.stageY, this))
				return;
			
			var delta:Number = -100 / (_h - _content.height);
			
			if (e.delta < 0)
				delta *= -1;
			
			this.scrollBar.position -= delta;
			
			setContentPosition();
		}
		
		private function isInside(x:Number, y:Number, obj:DisplayObject):Boolean
		{
			return x > topLeft.x && x < bottomRight.x && y > topLeft.y && y < bottomRight.y
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