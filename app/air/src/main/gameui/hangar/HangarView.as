package gameui.hangar 
{
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.core.pick.ShaderPicker;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.materials.lightpickers.StaticLightPicker;
	import characters.Actor;
	import characters.view.ViewController;
	import core.fileSystem.IFS;
	import display.SceneController;
	import flash.display3D.Context3DProfile;
	import flash.events.Event;
	import gameui.MenuPanel;
	import gameui.PlayerPanel;
	import ui.style.Style;
	import ui.style.StylesCollector;
	import ui.UIContainer;
	
	public class HangarView extends UIContainer 
	{
		public var view:View3D;
		
		private var lights:DirectionalLight;
		private var lightPicker:StaticLightPicker;
		
		private var playerPanel:PlayerPanel;
		private var menuPanel:MenuPanel;
		private var sceneView:ObjectContainer3D;
		
		
		public var displayController:SceneController;
		
		[Inject]
		public var vfs:IFS
		
		[Inject]
		public var styles:StylesCollector;
		
		public function HangarView(style:Style=null) 
		{
			inject(this);
			super(style);
		}
		
		private function createViewport():void
		{
			view = new View3D(null, null, null, false, Context3DProfile.BASELINE_EXTENDED);
			view.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			view.antiAlias = 100;
			view.mousePicker = new ShaderPicker();
			
			displayController = new SceneController(view);
		}
		
		public function getChildOfByName(container:ObjectContainer3D, name:String):ObjectContainer3D
		{
			for (var i:int = 0; i < container.numChildren; i++)
			{
				if (container.getChildAt(i).name == name)
					return container.getChildAt(i);
			}
			
			return null
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			createViewport();
			
			createSceneView();
			createShip();
			
			playerPanel = new PlayerPanel();
			menuPanel = new MenuPanel();
		}
		
		private function createSceneView():void 
		{
			//sceneView = vfs.getFile('res/models/scenes/dock.awd').content;
			
			//var ship:ObjectContainer3D = vfs.getFile('res/models/ships/11marta01.obj').content;
			
			//getChildOfByName(sceneView, "shipslot").addChild(ship);
			//view.camera = getChildOfByName(sceneView, "camera") as Camera3D;
		}
		
		private function createShip():void
		{
			
			return
			/*shipView = vfs.getFile('res/models/ships/mainmenu/mesh.awd').content;
			var viewContorller:ViewController = new ViewController(shipView);
			starBase = new Actor(viewContorller);
			
			selectionLight = shipView.getChildAt(2).getChildAt(0) as PointLight;
			
			shipView.getChildAt(0).rotationY = 90 - 65 - 90 - 15;
			shipView.getChildAt(2).rotationY = 90 - 65 - 90 - 15;
			shipView.getChildAt(1).rotationY = 90 - 65 - 90 - 15;
			
			shipView.rotationX -= 25;
			shipView.rotationZ -= 15;*/
		}
		
		override protected function configureChildren():void 
		{
			super.configureChildren();
		}
		
		
		private function onAddedToStage(e:Event):void 
		{
			view.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			//view.filters3d = new <Filter3DBase>[new BloomFilter3D(8, 8, 0.5, 4, 4), new MotionBlurFilter3D(.80)];
			
			update();
		}
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			addChild(view);
			
			//view.scene.addChild(sceneView);
			
			addComponent(playerPanel);
			addComponent(menuPanel);
		}
		
		override public function update():void 
		{
			super.update();
			
			displayController.update();
			layoutChildren();
		}
		
		override protected function layoutChildren():void 
		{
			super.layoutChildren();
			
			if (!stage)
				return;
			
			menuPanel.x = (stage.stageWidth - menuPanel.width) / 2;
		}
		
	}

}