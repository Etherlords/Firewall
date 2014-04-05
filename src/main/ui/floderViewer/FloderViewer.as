package ui.floderViewer 
{
	import core.external.KeyBoardController;
	import core.fileSystem.Directory;
	import core.fileSystem.FsFile;
	import core.fileSystem.IFile;
	import core.fileSystem.IFS;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import ui.ScrollBar;
	import ui.ScrollContainer;
	import ui.style.Style;
	import ui.UIComponent;
	
	public class FloderViewer extends UIComponent 
	{
		[Inject]
		public var iconFactory:IconsFactory;
		
		[Inject]
		public var vfs:IFS;
		
		private var path:String;
		private var maxWidth:Number;
		private var maxHeight:Number;
		
		public var directory:IFile;
		
		private var currentFlodersList:Vector.<FloderView> = new Vector.<FloderView>
		
		private var selectedFloder:FloderView;
		private var scrollContainer:ScrollContainer;
		private var container:Sprite;
		private var keyboardController:KeyBoardController;
		private var scrollBar:ScrollBar;
		
		public function FloderViewer(style:Style=null, directory:IFile = null, path:String = '', maxWidth:Number = 500, maxHeight:Number = 200) 
		{
			inject(this);
			
			this.maxHeight = maxHeight;
			this.maxWidth = maxWidth;
			
			this.directory = directory;
			this.path = path;
			
			super(style);
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			container = new Sprite();
			
			var scrollStyle:Style = new Style();
			scrollStyle.fillStyle(new <String>[
				"background=@res/textures/ui/scroll/background.png", "slider=@res/textures/ui/scroll/slider.png",
			]);
			
			var contianerStyle:Style = new Style();
			contianerStyle.fillStyle(new <String>[
				"background=@res/textures/ui/frame.png"
			]);
			
			scrollBar = new ScrollBar(maxHeight, 0, maxHeight, scrollStyle);
			scrollContainer = new ScrollContainer(scrollBar, maxWidth, maxHeight, contianerStyle);
		}
		
		override protected function configureChildren():void 
		{
			super.configureChildren();
			 
			scrollContainer.content = container;
		}
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			//addChild(container);
			addComponent(scrollContainer);
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage); 
			setView();
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			keyboardController = new KeyBoardController(stage);
			keyboardController.registerKeyDownReaction(Keyboard.BACKSPACE, onBackspace);
		}
		
		private function onBackspace():void 
		{
			if (!directory.parent)
				return;
				
			directory = directory.parent;
			setView();
		}
		
		private function setView():void
		{
			var i:int;
			var currentFloder:Object = directory;
			
			if (currentFloder is FsFile)
				return;
				
			scrollBar.position = 0;
			
			for (i = 0; i < currentFlodersList.length; i++)
			{
				currentFlodersList[i].removeEventListener(MouseEvent.MOUSE_DOWN, onFloderSelect);
				container.removeChild(currentFlodersList[i]);
			}
			
			currentFlodersList = new Vector.<FloderView>;
			
			for (i = 0; i < currentFloder.length; i++)
			{
				var file:Object = currentFloder.nextItem;
				var floderView:FloderView = new FloderView(file, iconFactory.getIcon(file), 64, file.name)
				
				floderView.addEventListener(MouseEvent.MOUSE_DOWN, onFloderSelect);
				floderView.doubleClickEnabled = true;
				floderView.addEventListener(MouseEvent.DOUBLE_CLICK, onOpenFile);
				
				currentFlodersList.push(floderView);
				container.addChild(floderView);
			}
			
			layoutChildren();
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function onOpenFile(e:MouseEvent):void 
		{
			var floderView:FloderView = e.currentTarget as FloderView;
			var file:IFile = floderView.file as IFile;
			
			if (file is Directory)
			{
				directory = file;
				setView();
			}
		}
		
		private function onFloderSelect(e:MouseEvent):void 
		{
			var floderView:FloderView = e.currentTarget as FloderView;
			
			if (selectedFloder)
			{
				selectedFloder.selected = false;
			}
			
			selectedFloder = floderView;
			selectedFloder.selected = true;
		}
		
		override protected function layoutChildren():void 
		{
			super.layoutChildren();
			
			var x:Number = 0;
			var y:Number = 0
			for (var i:int = 0; i < currentFlodersList.length; i++)
			{
				currentFlodersList[i].x = x;
				currentFlodersList[i].y = y;
				
				x += currentFlodersList[i].width + 5;
				
				if (x + currentFlodersList[i].width > maxWidth)
				{
					x = 0
					y += currentFlodersList[i].height * 1.5 + 5;
				}
			}
		}
		
		
		
	}

}