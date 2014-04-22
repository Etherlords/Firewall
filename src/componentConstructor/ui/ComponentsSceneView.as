package ui 
{
	import core.datavalue.model.LazyProxy;
	import core.datavalue.model.ObjectProxy;
	import core.fileSystem.FsFile;
	import core.fileSystem.IFS;
	import flash.display.Stage;
	import flash.events.Event;
	import ui.events.FloderEvent;
	import ui.floderViewer.IconsFactory;
	import ui.style.Style;
	import ui.style.StylesCollector;
	import ui.styles.ComponentStyleViewer;
	import ui.styles.ComponentsViewer;
	import ui.tree.Tree;
	
	public class ComponentsSceneView extends UIComponent
	{
		
		[Inject]
		public var vfs:IFS;
		
		[Inject]
		public var styles:StylesCollector;
		
		[Inject]
		public var __stage:Stage;
		
		private var componentsListViewer:ComponentsViewer;
		private var styleViewer:ComponentStyleViewer;
		
		private var dataModel:ObjectProxy = new LazyProxy(100);
		public var explorer:Explorer;
		private var filePreview:FilePreviewer;
		private var flodersTree:Tree;
			
		public function ComponentsSceneView() 
		{
			inject(this);
			super();
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			addToContext(new IconsFactory());
			
			for (var field:String in styles.styles.map)
			{
				var style:Style = styles.styles.map[field]
				var file:FsFile = new FsFile();
				file.name = field + '.style';
				file.content = style;
				file.path = '/';
				file.extension = 'style';
				vfs.directoriesList.addItem(field, file);
			}
			
			explorer = new Explorer(null, dataModel);
			componentsListViewer = new ComponentsViewer(500, 400, dataModel);
			styleViewer = new ComponentStyleViewer(dataModel);	
			filePreview = new FilePreviewer(dataModel);
			vfs.directoriesList.index = 0;
			
			flodersTree = new Tree(null, vfs.directoriesList, 400, 551);
			
			flodersTree.addEventListener(FloderEvent.OPEN, onOpen);
			flodersTree.addEventListener(FloderEvent.SELECT, onSelect);
		}
		
		private function onSelect(e:FloderEvent):void 
		{
			dataModel.selectedFile = e.selected;
		}
		
		private function onOpen(e:FloderEvent):void 
		{
			if(!e.selected.isDerictory)
				dataModel.openFile = e.selected;
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			__stage.addEventListener(Event.RESIZE, onResize);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			onResize();
		}
		
		private function onResize(e:Event = null):void 
		{
			flodersTree.setSize(flodersTree.width, stage.stageHeight)
			invalidateLayout();
		}
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			addComponent(explorer);
			addComponent(styleViewer);
			addComponent(componentsListViewer);
			addComponent(filePreview);
			addComponent(flodersTree);
		}
		
		override protected function layoutChildren():void 
		{
			super.layoutChildren();
			
			explorer.x = 0;
			explorer.y = 0;
			componentsListViewer.x = explorer.x + explorer.width + 2;
			
			filePreview.x = 0;
			filePreview.y = explorer.y + explorer.height + 2;
			
			flodersTree.x = (stage.stageWidth - flodersTree.width);
			flodersTree.y = 0;// componentsListViewer.y + componentsListViewer.height + 2;
			
			//styleViewer.y = saveButton.y + saveButton.height + 2;
		}
		
	}

}