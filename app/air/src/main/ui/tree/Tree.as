package ui.tree 
{
	import core.fileSystem.Directory;
	import core.fileSystem.IFS;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import ui.events.FloderEvent;
	import ui.ScrollBar;
	import ui.ScrollContainer;
	import ui.style.Style;
	import ui.style.StylesCollector;
	import ui.UIComponent;
	
	public class Tree extends UIComponent 
	{
		private var directory:Directory;
		private var scrollContainer:ScrollContainer;
		private var floderElement:FloderElement;
		private var background:ScaleBitmap;
		
		private var _width:Number;
		private var _height:Number;
		
		private var selectedItem:TreeElement;
		
		[Inject]
		public var styles:StylesCollector;
		
		[Inject]
		public var vfs:IFS;
		
		public function Tree(style:Style=null, directory:Directory = null, _width:Number = 200, _height:Number = 500) 
		{
			this._height = _height;
			this._width = _width;
			this.directory = directory;
			
			inject(this);
			super(style);
		}
		
		public function setSize(width:Number, height:Number):void 
		{
			_width = width;
			_height = height;
			
			scrollContainer.setSize(_width - 3, _height - 3);
			
			background.setSize(_width, _height);
			
			invalidateLayout();
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			var scrollStyle:Style = new Style();
			scrollStyle.fillStyle(new <String>[
				"background=@res/textures/ui/scroll/background.png", "slider=@res/textures/ui/scroll/slider.png",
			]);
			
			var contianerStyle:Style = new Style();
			contianerStyle.fillStyle(new <String>[
				"background=@res/textures/ui/frame.png"
			]);
			
			background = new ScaleBitmap(vfs.getFile("res/textures/ui/frame.png").content);
			var scrollBar:ScrollBar = new ScrollBar(scrollStyle)
			scrollContainer = new ScrollContainer(contianerStyle, scrollBar, _width-3, _height-2);
			
			floderElement = new FloderElement(null, directory);
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			floderElement.addEventListener(Event.CHANGE, onChangeFloders);
			floderElement.addEventListener(FloderEvent.OPEN, onOpen);
			floderElement.addEventListener(FloderEvent.SELECT, onSelect);
		}
		
		private function onSelect(e:FloderEvent):void 
		{
			if (selectedItem)
				selectedItem.selected = false;
				
			selectedItem = e.target as TreeElement;
			selectedItem.selected = true;
		}
		
		private function onOpen(e:FloderEvent):void 
		{
			
		}
		
		private function onChangeFloders(e:Event):void 
		{
			
		}
		
		override protected function configureChildren():void 
		{
			super.configureChildren();
			
			background.scale9Grid = new Rectangle(1, 1, 1, 1);
			scrollContainer.content = floderElement;
			setSize(_width, _height);
		}
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			addChild(background);
			addComponent(scrollContainer);
		}
		
		override protected function layoutChildren():void 
		{
			super.layoutChildren();
			
			scrollContainer.x = 3;
			scrollContainer.y = 1;
		}
	}

}