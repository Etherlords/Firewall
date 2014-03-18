package  
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	import away3d.lights.PointLight;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.FogMethod;
	import away3d.materials.TextureMaterial;
	import away3d.materials.utils.DefaultMaterialManager;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.SkyBox;
	import away3d.textures.BitmapCubeTexture;
	import away3d.textures.BitmapTexture;
	import away3d.textures.SpecularBitmapTexture;
	import characters.Actor;
	import characters.controller.FlightVehicleMoveController;
	import characters.controller.FlightVenhicleRotationController;
	import characters.view.ViewController;
	import core.external.KeyBoardController;
	import core.fileSystem.FsFile;
	import core.fileSystem.IFS;
	import demo.PlanetoidFactory;
	import demo.SimpleUI;
	import display.SceneController;
	import display.ui.DisplayManager;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;

	
	
	public class GameScene extends Sprite 
	{
		[Inject]
		public var worldTime:WorldTimeController;
		
		private var hoverController:HoverController;
		private var objectController:ObjectController;
		private var target:ObjectContainer3D;
		public var controller:SpaceSceneController
		private var view:View3D;
		
		public var displayManager:DisplayManager;
		public var vfs:IFS;
		
		private var planetFactory:PlanetoidFactory;
		private var simpleUi:SimpleUI = new SimpleUI();
		
		public function GameScene() 
		{
			super();
			
			initialize();
			describe("vfs", "complete", onVfsReady);
			
			if (stage)
				onAddedToStage();
			else
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private var fog:FogMethod = new FogMethod(2000, 15000);
		
		private function initialize():void 
		{
			var light:PointLight = new PointLight();
			light.radius = 10000;
			light.fallOff = 15000;
			light.ambient = 0.9;
			
			lights = new StaticLightPicker([light]);
			
			light.y = 800;
			
		
			
			addToContext(lights);
			addToContext(fog);
			
			view = new View3D();
			view.antiAlias = 16;
			view.camera.lens.far = 100000;
			
			view.scene.addChild(light);
			
			
			addToContext(view);
			view.camera.z = -100;
			view.camera.y = 50;
			view.camera.lookAt(new Vector3D())
			
			controller = new SpaceSceneController(view);
			
			addChild(view);
			addChild(new AwayStats(view));
			
			hoverController = new HoverController();
			
			addChild(simpleUi);
		}
		
		private function onAddedToStage(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(Event.ENTER_FRAME, onFrameEnter);
			objectController = new ObjectController(stage);
			keyController = new KeyBoardController(stage);
			
			keyController.registerKeyDownReaction(Keyboard.W, launch);
			keyController.registerKeyUpReaction(Keyboard.W, stop);
			
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			isMouseDown = false;
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			isMouseDown = true;
		}
		
		private function stop():void 
		{
			mobileController.stop();
		}
		
		private function launch():void 
		{
			mobileController.launch();
		}
		
		private function onVfsReady(e:Event):void 
		{
			inject(this);
			displayManager.stage.addChild(this);
			
			var skybox:SkyBox = new SkyBox(new BitmapCubeTexture(vfs.getFile("res/textures/skybox/space/posX.jpg").content, vfs.getFile("res/textures/skybox/space/negX.jpg").content,
									vfs.getFile("res/textures/skybox/space/posY.jpg").content, vfs.getFile("res/textures/skybox/space/negY.jpg").content,
									vfs.getFile("res/textures/skybox/space/posZ.jpg").content, vfs.getFile("res/textures/skybox/space/negZ.jpg").content));
			
			view.scene.addChild(skybox);
			
			var file:FsFile = vfs.getFile('res/models/ships/11marta01.obj')
			
			target = file.content;
			
			var diffuse:BitmapData = vfs.getFile('res/textures/T_006_Metal_D.png').content;
			var normal:BitmapData = vfs.getFile('res/textures/T_006_Metal_N.png').content;
			var specular:BitmapData = vfs.getFile('res/textures/T_006_Metal_S.png').content;
			
			var material:TextureMaterial = new TextureMaterial(new BitmapTexture(diffuse), true, true);
			//material.alphaBlending = true;
			material.normalMap = new BitmapTexture(normal);
			material.specularMap = new SpecularBitmapTexture(specular);
			
			material.gloss = 100;
			material.specular = 0.4;
			material.bothSides = true;
			material.lightPicker = lights;
			material.alphaThreshold = 0.1;
			
			
			view.scene.addChild(file.content);
			view.scene.addChild(marker);
			
			for (var i:int = 0 ; i < target.numChildren; i++)
			{
				target.getChildAt(i).rotationY = 180;
				
				(target.getChildAt(i) as Mesh).material = material;
			}
			
			planetFactory = new PlanetoidFactory();
		
			
			target.x = 0;
			target.y = 0;
			
			//target.lookAt(new Vector3D());
			
			var testTarget:ObjectContainer3D = target.clone() as ObjectContainer3D;
			target = testTarget;
			
			var objCon:ObjectContainer3D = new ObjectContainer3D();
			objCon.addChild(target);
			
			target = objCon;
			
			var viewController:ViewController = new ViewController(objCon);
			mobileController = new FlightVehicleMoveController(viewController);
			rotationController = new FlightVenhicleRotationController(viewController);
			
			simpleUi.rotationData = rotationController.rotationData;
			
			actor = new Actor(viewController);
			actor.addController(mobileController);
			actor.addController(rotationController);
			
			controller.addDisplayObject(actor);
			
			view.scene.addChild(objCon);
			
			target.x = -1400;
			target.y = -1550;
			target.z = 250;
			
			
			target.x = 705500/50;
			target.y = 0;
			target.z = 0;
			
			view.camera.x = target.x;
			view.camera.y = target.y + 50;
			view.camera.z = target.z - 100;
		
			buildSolarSystem();
			
		
		}
		
		private function buildSolarSystem():void
		{
			
			addPlanet("earth_001", 1, 63700, 149600000-695500);
			addPlanet("fire_001", 1, 24400, 57910000-695500);
			addPlanet("snow_003", 1, 33900, 227900000-695500)
			addPlanet("ice_002", 1, 60520, 778500000-695500)
			
			addPlanet("yellow_star", 0, 695500, 0);
		}
		
		private function addPlanet(path:String, rot:Number, radius:Number, orbitRadius:Number):void
		{
			var planet:Actor = planetFactory.build(path, rot, radius/50, orbitRadius/1000);
			
			controller.addDisplayObject(planet);
			planets.push(planet);
			
		}
		
		private var moveVector:Vector3D = new Vector3D(0, 0, 500);
		private var marker:Mesh = new Mesh(new CubeGeometry(15, 15, 15), DefaultMaterialManager.getDefaultMaterial());
		private var planets:Vector.<Actor> = new Vector.<Actor>;
		private var keyController:KeyBoardController;
		private var currentSpeed:Number = 0;
		private var lights:StaticLightPicker;
		
		private var actor:Actor;
		
		
		private var lastTime:Number = 0;
		private var mobileController:FlightVehicleMoveController;
		private var rotationController:FlightVenhicleRotationController;
		private var isMouseDown:Boolean = false;
		
		
		private function onFrameEnter(e:Event):void 
		{
			
			if (lastTime == 0)
				lastTime = new Date().getTime();
			
			worldTime.updateTime();
			
			lastTime = new Date().getTime();
			
			
			
			
			objectController.render();
			
			//if(isMouseDown)
				rotationController.rotationNormal = new Vector3D(objectController.lastTiltAngle, objectController.lastPanAngle);
			//else
			//	rotationController.rotationNormal = new Vector3D();
			//rotationController.rotationNormal.normalize();
		
			
			//target.rotateTo(objectController.lastTiltAngle, objectController.lastPanAngle, 0);
			
			moveVector = target.forwardVector;
			moveVector.scaleBy(400);
			moveVector = moveVector.add(target.position);
			
			//target.lookAt(moveVector);
			
			var cameraPosition:Vector3D = target.backVector;
			cameraPosition.scaleBy(150);
			cameraPosition = cameraPosition.add(target.position);
			
			var upvec:Vector3D = target.upVector
			upvec.scaleBy(25);
			upvec = upvec.add(cameraPosition);
			
			view.camera.x = upvec.x
			view.camera.y = upvec.y
			view.camera.z = upvec.z	
			
			var lookVector:Vector3D = target.forwardVector
			lookVector.scaleBy(50)
			lookVector = lookVector.add(target.position);
			//lookVector.scaleBy(1.1)
			
			//view.camera.lookAt(target.position);
			//trace(view.camera.rotationX, view.camera.rotationY, view.camera.rotationZ);
			
			view.camera.rotationX = target.rotationX;
			view.camera.rotationY = target.rotationY;
			view.camera.rotationZ = target.rotationZ;
			///
			
			
			var moveVecotr2:Vector3D = moveVector.clone().subtract(target.position);
			
			marker.position = moveVector;
			//target.rotationZ = objectController.lastTiltAngle;
			
			
			graphics.clear();
			graphics.beginFill(0xFFFFFF, 0.5);
			for (var i:int = 0; i < planets.length; i++)
			{
				
				
				graphics.beginFill(0xFFFFFF, 0.5);
				var p:Vector3D = planets[i].viewController.displayObject.position.clone();
				
				var v:Vector3D = view.project(p);
				
				if (v.z < 0)
				{
					v.y = (v.y) * -100
					v.x = (v.x) * -1;
				}
				
				if (v.x < 0)
					v.x = 0;
				if (v.y < 0)
					v.y = 0;
					
				if (v.x > stage.stageWidth)
					v.x = stage.stageWidth;
					
				if (v.y > stage.stageHeight)
					v.y = stage.stageHeight;
					
		
				graphics.drawCircle(v.x, v.y, 15);
				graphics.endFill();
			}
			
			controller.update();
		}
		
	}

}