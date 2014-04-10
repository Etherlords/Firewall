package ui 
{
	import core.datavalue.model.LazyProxy;
	import core.datavalue.model.ObjectProxy;
	import core.fileSystem.FsFile;
	import core.fileSystem.IFS;
	import ui.floderViewer.IconsFactory;
	import ui.style.Style;
	import ui.style.StylesCollector;
	import ui.styles.ComponentStyleViewer;
	import ui.styles.ComponentsViewer;
	
	public class ComponentsSceneView extends UIComponent
	{
		
		[Inject]
		public var vfs:IFS;
		
		[Inject]
		public var styles:StylesCollector;
		
		private var componentsListViewer:ComponentsViewer;
		private var styleViewer:ComponentStyleViewer;
		
		private var dataModel:ObjectProxy = new LazyProxy(100);
		private var explorer:Explorer;
		private var filePreview:FilePreviewer;
			
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
				file.name = field;
				file.content = style;
				file.path = '/';
				file.extension = 'style';
				vfs.directoriesList.addItem(field, file);
			}
			
			explorer = new Explorer(null, dataModel);
			componentsListViewer = new ComponentsViewer(500, 400, dataModel);
			styleViewer = new ComponentStyleViewer(dataModel);	
			filePreview = new FilePreviewer(dataModel);
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			addComponent(explorer);
			addComponent(styleViewer);
			addComponent(componentsListViewer);
			addComponent(filePreview);
		}
		
		override protected function layoutChildren():void 
		{
			super.layoutChildren();
			
			explorer.x = 0;
			explorer.y = 0;
			componentsListViewer.x = explorer.x + explorer.width + 2;
			
			filePreview.x = 0;
			filePreview.y = explorer.y + explorer.height + 2;
			
			//styleViewer.y = saveButton.y + saveButton.height + 2;
		}
		
	}

}