package  
{
	import core.fileSystem.Directory;
	import core.fileSystem.FsFile;
	import core.external.LocalFileSystem;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import ui.LineDrawer;
	import ui.style.StylesCollector;

	[SWF(backgroundColor="0x0", width=1280, height=960)]
	public class StartUp extends Sprite 
	{
		private static const classRef:ClassesRef = new ClassesRef();
		private static const defaultUI:DefaultUI = new DefaultUI();
		
		public function StartUp() 
		{
			super();
			
			stage.quality = StageQuality.BEST;
			

			
		//	return;
			
			/*var objState:ObjectState = new ObjectState();
			var o:Object3D = new Object3D();
			o.name = 'test';
			var ba:ByteArray = objState.writeObject(o, new < String > ["rotationX", "rotationY", "rotationZ", 'name']);
			
			ba.position = 0;
			objState.readObject(ba, o);
		
			
			return;
			*/
			
			
			if (stage)
				initialize();
			else
				addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		/*private function test():void
		{
			calc();
			calc();
			calc();
			calc();
			
			rotationNormal.x = 0.79
			
			calc();
			calc();
			calc();
			calc();
			calc();
			calc();
			calc();
		}
		
		private var rotationNormal:Vector3D = new Vector3D(-0.69);
		private var rotationData:RotationData = new RotationData();
		
		private function calc():void
		{
			var partOfIteration:Number = 33 / 1000;
			
			var rotationDeltaX:Number = Math.abs(rotationNormal.x - rotationData.currentRotationX);
			var xIteration:Number = rotationData.rotationRate * partOfIteration
				
			trace(rotationDeltaX, xIteration, rotationDeltaX > xIteration, rotationNormal.x, rotationData.currentRotationX)
			if (rotationDeltaX > xIteration)
			{
				if (rotationData.currentRotationX > rotationNormal.x)
					rotationData.currentRotationX -= xIteration
				else
					rotationData.currentRotationX += xIteration
			}
			else
				rotationData.currentRotationX = rotationNormal.x;
		}*/
		
		private function initialize(e:Event = null):void 
		{
			//test();
			//return
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
			XMLBootsTrap.loadConfig('./config/test/main.xml');
		}
		
	}

}