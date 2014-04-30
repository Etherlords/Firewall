package  
{
	import away3d.containers.View3D;
	import away3d.entities.Mesh;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.CubeGeometry;
	import characters.Actor;
	import core.fileSystem.IFS;
	import core.materials.MaterialFactory;
	import display.SceneController;
	import display.ui.DisplayManager;
	import display.view.ViewController;
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	public class EditorScene extends Sprite 
	{
		private var view:View3D;
		
		
		public var displayManager:DisplayManager;
		
		public var vfs:IFS;
		
		public var controller:SceneController = new SceneController();
		public var materialFactory:MaterialFactory = new MaterialFactory();
		
		
		public function EditorScene() 
		{
			super();
			
			initialize();
			describe("vfs", "complete", onVfsReady);
			
			if (stage)
				onAddedToStage();
			else
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function initialize():void 
		{
			
		}
		
		private function createTestMaterial():void
		{
			materialFactory.buildMaterial(
		}
		
		private function manageTestActor():void
		{
			var targetMaterial:TextureMaterial = new TextureMaterial()
			var defaultMesh:Mesh = new Mesh(new CubeGeometry(), targetMaterial);
			var actorView:ViewController = new ViewController();
			var actor:Actor = new Actor(
		}
		
		private function onAddedToStage(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(Event.ENTER_FRAME, onFrameEnter);
		}
		
		private function onVfsReady(e:Event):void 
		{
			displayManager.stage.addChild(this);
		}
		
		private function onFrameEnter(e:Event):void 
		{
			
			controller.update();
		}
		
	}

}