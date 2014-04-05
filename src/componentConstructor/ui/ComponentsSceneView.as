package ui 
{
	import core.fileSystem.IFS;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import ui.floderViewer.FloderViewer;
	import ui.floderViewer.IconsFactory;
	import ui.style.StylesCollector;
	
	public class ComponentsSceneView extends UIContainer
	{
		private var flodersView:FloderViewer;
		private var background:ScaleBitmap;
		
		[Inject]
		public var vfs:IFS;
		
		[Inject]
		public var styles:StylesCollector;
		
		public var saveButton:Button;
		
		private var invaildLayout:Boolean = true;
		private var text:Text;
			
		public function ComponentsSceneView() 
		{
			inject(this);
			super();
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			addToContext(new IconsFactory());
			
			text = new TextWidthBackground(styles.getStyle('componentsSceneText'));
			background = new ScaleBitmap(vfs.getFile("res/textures/ui/frame.png").content);
			flodersView = new FloderViewer(null, vfs.directoriesList, 'res/');
			saveButton = new Button(styles.getStyle("mainMenuButton"), "Save")
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			flodersView.addEventListener(Event.CHANGE, onChange);
		}
		
		override public function update():void 
		{
			if (invaildLayout)
				layoutChildren();
				
			super.update();
		}
		
		private function onChange(e:Event):void 
		{
			layoutChildren();
			text.text = flodersView.directory.path;
		}
		
		override protected function configureChildren():void 
		{
			super.configureChildren();
			
			background.scale9Grid = new Rectangle(1, 1, 1, 1);
		}
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			addChild(background);
			addComponent(flodersView);
			addComponent(text);
			addComponent(saveButton);
		}
		
		override protected function layoutChildren():void 
		{
			super.layoutChildren();
			//invaildLayout = false;
			
			
			text.y = 1;
			
			flodersView.y = text.y + text.height + 2;
			background.y = flodersView.y-1;
			
			flodersView.x = 1;
			background.setSize(flodersView.width + 2, flodersView.height + 2);
			
			text.width = flodersView.width + 2;
			
			saveButton.x = background.width - saveButton.width;
			saveButton.y = background.y + background.height +2;
		}
		
	}

}