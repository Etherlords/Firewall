package  
{
	import core.fileSystem.Directory;
	import core.fileSystem.FsFile;
	import core.fileSystem.LocalFileSystem;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import ui.AutoCompleteManager;
	import ui.style.StylesCollector;
	
	public class ComponentsStartUp extends Sprite 
	{
		private static const classRef:ComponentsClassesRef = new ComponentsClassesRef();
		
		public function ComponentsStartUp() 
		{
			super();
			
			/*var text:TextField = new TextField();
			text.type = TextFieldType.INPUT;
			text.border = true;
			text.width = 150;
			text.height = 20;
			
			addChild(text);
			text.borderColor = 0xFFFFFF;
			text.textColor = 0xFFFFFF;
			
			var autoComplete:AutoCompleteManager = new AutoCompleteManager(text);
			autoComplete.completionMap.push("test", "test.find.text");
			return;*/
			if (stage)
				initialize();
			else
				addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		private function initialize(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			stage.align = 'TL';
			stage.scaleMode = 'noScale';
			
			var defaultVfs:LocalFileSystem = new LocalFileSystem();
			var defaultDir:Directory = new Directory();
			
			defaultVfs.directoriesList = defaultDir;
			
			defaultDir.name = '/';
			defaultDir.path = '/'
			
			var progress:FsFile = new FsFile();
			progress.content = new DefaultUI.progressProgress().bitmapData;
			var background:FsFile = new FsFile();
			background.content = new DefaultUI.progressBackground().bitmapData;;
			
			defaultDir.addItem('progress', progress);
			defaultDir.addItem('background', background);
			
			
			
			addToContext(defaultVfs);
			addToContext(stage);
			addToContext(new StylesCollector());
			
			var XMLBootsTrap:XMLBootstrap = new XMLBootstrap();
			XMLBootsTrap.loadConfig('./config/test/comps/componentsMain.xml');
		}
		
	}

}