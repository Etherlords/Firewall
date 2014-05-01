package gameui.gamescene  
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.entities.Mesh;
	import away3d.filters.BloomFilter3D;
	import away3d.filters.Filter3DBase;
	import away3d.filters.MotionBlurFilter3D;
	import away3d.lights.DirectionalLight;
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
	import display.ui.DisplayManager;
	import flash.display.BitmapData;
	import flash.display3D.Context3DProfile;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import ui.space.ObjectTracker;
	import ui.UIComponent;
	
	public class GameSceneView extends UIComponent 
	{
		[Inject]
		public var worldTime:WorldTimeController;
		
		private var hoverController:HoverController;
		private var objectController:ObjectController;
		private var target:ObjectContainer3D;
		public var controller:SpaceSceneController
		private var view:View3D;
		
		public var displayManager:DisplayManager;
		
		[Inject]
		public var vfs:IFS;
		
		private var planetFactory:PlanetoidFactory;
		private var simpleUi:SimpleUI = new SimpleUI();
		
		public function GameSceneView() 
		{
			super();
			
			if (stage)
				onAddedToStage();
			else
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private var fog:FogMethod = new FogMethod(2000, 15000);
		
		override protected function initialize():void 
		{
			super.initialize();
			
			var light:PointLight = new PointLight();
			light.radius = 10000;
			light.fallOff = 15000;
			light.ambient = 0.17;
			light.diffuse = 3;
			
			var light2:DirectionalLight = new DirectionalLight( 1, 0, 0);
			light2.ambient = 0.17;
			light2.diffuse = 3;
			
			lights = new StaticLightPicker([light2]);
			
			light.x = -300;
			light.z = -500;
			
			addToContext(lights);
			//addToContext(fog);
			
			view = new View3D(null, null, null, false, Context3DProfile.BASELINE_EXTENDED);
			view.addEventListener(Event.ADDED_TO_STAGE, onViewAdded);
			view.antiAlias = 16;
			view.camera.lens.far = 100000;
			
			view.scene.addChild(light);
			
			
			addToContext(view);
			view.camera.z = -100;
			view.camera.y = 50;
			view.camera.lookAt(new Vector3D())
			
			controller = new SpaceSceneController(view);
			
			addChild(view);
			//addChild(new AwayStats(view));
			
			hoverController = new HoverController();
			
			addChild(simpleUi);
		}
		
		private function onViewAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onViewAdded);
			view.filters3d = new <Filter3DBase>[new BloomFilter3D(8, 8, 0.5, 4, 4), new MotionBlurFilter3D(.30)];
		}
		
		private function onAddedToStage(e:Event = null):void 
		{
			onVfsReady(e);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
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
			
			
			var skybox:SkyBox = new SkyBox(new BitmapCubeTexture(vfs.getFile("res/textures/skybox/space/posX.jpg").content, vfs.getFile("res/textures/skybox/space/negX.jpg").content,
									vfs.getFile("res/textures/skybox/space/posY.jpg").content, vfs.getFile("res/textures/skybox/space/negY.jpg").content,
									vfs.getFile("res/textures/skybox/space/posZ.jpg").content, vfs.getFile("res/textures/skybox/space/negZ.jpg").content));
			
			view.scene.addChild(skybox);
			
			var file:FsFile = vfs.getFile('res/models/ships/11marta01.obj')
			
			target = file.content;
			
			var diffuse:BitmapData = vfs.getFile('res/textures/T_006_Metal_D.png').content;
			var normal:BitmapData = vfs.getFile('res/textures/T_006_Metal_N.png').content;
			var specular:BitmapData = vfs.getFile('res/textures/T_006_Metal_S.png').content;
			
			material = new TextureMaterial(new BitmapTexture(diffuse), true, true);
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
			
			
			var x:Number = -150;
			
			for (var z:int = 0; z < 6; z++)
			{
				buildShip(x, 0, 150);
				x += 50
			}
			
			planetIcons.push(new ObjectTracker('planet'));
			planetIcons.push(new ObjectTracker('planet'));
			planetIcons.push(new ObjectTracker('planet'));
			planetIcons.push(new ObjectTracker('planet'));
			
			sunIcon = new ObjectTracker('sun');
		
			addChild(sunIcon);
			
			for (i = 0; i < planetIcons.length; i++)
			{
				addChild(planetIcons[i]);
			}
			
			var t:Timer = new Timer(1000, 1);
			t.addEventListener(TimerEvent.TIMER_COMPLETE, onTimer);
			t.start();
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			for (var i:int = 0 ; i < controller.ships.length; i++)
			{
				(controller.ships[i].getController(FlightVehicleMoveController.IDENT) as FlightVehicleMoveController).launch();
			}
		}
		
		private function buildShip(x:int, y:int, z:int):void
		{
			var targg:ObjectContainer3D = target.clone() as ObjectContainer3D;
			var targ:ObjectContainer3D = target.getChildAt(0);
			
			var viewController:ViewController = new ViewController(targg);
			var mobileController:FlightVehicleMoveController = new FlightVehicleMoveController(viewController);
			var rotationController:FlightVenhicleRotationController = new FlightVenhicleRotationController(viewController);
			
			
			for (var i:int = 0 ; i < targ.numChildren; i++)
			{
				targ.getChildAt(i).rotationY = 180;
				
				(targ.getChildAt(i) as Mesh).material = material;
			}
			
			var actor:Actor = new Actor(viewController);
			actor.addController(mobileController);
			actor.addController(rotationController);
			
			
			controller.addSpaceShip(actor);
			
			targg.x = 705500/50 + x;
			targg.y = 0 + y;
			targg.z = z;
			
			
			
			shipIcons.push(new ObjectTracker('ship'));
			addChild(shipIcons[shipIcons.length - 1]);
			//shipIcons[shipIcons.length].actor = actor;
		}
		
		private function buildSolarSystem():void
		{
			
			addPlanet("earthhires", 1, 63700, 14960000-695500);
			//addPlanet("fire_001", 1, 24400, 57910000-695500);
			//addPlanet("snow_003", 1, 33900, 227900000-695500)
			//addPlanet("ice_002", 1, 60520, 778500000-695500)
			
			addPlanet("yellow_star", 0, 63700, 0, true, 0x995500, 120);
		}
		
		private function addPlanet(path:String, rot:Number, radius:Number, orbitRadius:Number, sun:Boolean = false, col:uint = 0x1671cc, atm:Number = 80):void
		{
			var planet:Actor = planetFactory.build(path, rot, radius/150, orbitRadius/2000, atm, false, true, col);
			
			if (sun)
			{
				//planet.viewController.x += 500
				controller.addSun(planet);
			}
			else
				controller.addPlanet(planet);
			
			
		}
		
		private var planetIcons:Vector.<ObjectTracker> = new Vector.<ObjectTracker>;
		private var shipIcons:Vector.<ObjectTracker> = new Vector.<ObjectTracker>;
		private var sunIcon:ObjectTracker;
		
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
		private var material:TextureMaterial;
		private var i:int;
		
		
		private function onFrameEnter(e:Event):void 
		{
			
			var v:Vector3D;
			var p:Vector3D;
			i;
			
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
			
			for (i = 0; i < controller.ships.length; i++)
			{
				p = controller.ships[i].viewController.displayObject.position.clone();
				
				
				v = view.project(p);
				
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
					
				shipIcons[i].x = v.x;
				shipIcons[i].y = v.y;
				
			}
			
		
			for (i = 0; i < controller.planets.length; i++)
			{
				p = controller.planets[i].viewController.displayObject.position.clone();
				
				v = view.project(p);
				
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
					
				planetIcons[i].x = v.x;
				planetIcons[i].y = v.y;
				
			}
			
			p = controller.sun.viewController.displayObject.position.clone();
			v = view.project(p);
				
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
				
			sunIcon.x = v.x;
			sunIcon.y = v.y;
			
			
			controller.update();
		}
		
	}

}