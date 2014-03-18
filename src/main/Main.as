package 
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.events.ParserEvent;
	import away3d.lights.DirectionalLight;
	import away3d.lights.LightBase;
	import away3d.lights.PointLight;
	import away3d.loaders.parsers.AWDParser;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.TextureMaterial;
	import com.greensock.TweenLite;
	import core.ioc.Context;
	import display.SceneController;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class Main extends Sprite 
	{
		private var sceneController:SceneController;
		
		//[Embed(source = "../bin/Ogre.awd", mimeType = "application/octet-stream")]
		//[Embed(source="../bin/exampleScenes/awd/bear/PolarBear_c4d_SkeletonExport.awd", mimeType="application/octet-stream")]
		[Embed(source="../bin/exampleScenes/awd/sponza/sponza.awd", mimeType="application/octet-stream")]
		private var nissanClass:Class;
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function constructLights():void
		{
			light = new DirectionalLight();
			view3d.scene.addChild(light as LightBase);
			view3d.scene.addChild(light2 as LightBase);
			picker = new StaticLightPicker([light2, light]);
		}
		
		private function init(e:Event = null):void 
		{
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var context:Context = new Context();
			
			addToContext(stage, 'Stage');
			
			view3d = new View3D();
			view3d.antiAlias = 16;
			
			addChild(view3d);
			
			addChild(new AwayStats(view3d));
			
			addToContext(view3d);
			addToContext(view3d.camera);
			
			sceneController = new SceneController();
			
			view3d.camera.position = new Vector3D(0, 2500, -1000);
			view3d.camera.lookAt(new Vector3D());
			
			constructLights();
			
			var awdLoader:AWDParser = new AWDParser();
			awdLoader.parseAsync(new nissanClass);
			
			awdLoader.addEventListener(AssetEvent.CONTAINER_COMPLETE, onMeshComplete);
			awdLoader.addEventListener(AssetEvent.MESH_COMPLETE, onMeshComplete2);
			awdLoader.addEventListener(ParserEvent.PARSE_COMPLETE, onCompletet);
			
			light.position = view3d.camera.position;
			light.lookAt(new Vector3D(0, 100, 0));
			
			startTween();
			
			light2.fallOff = 600;
			light2.radius = 550
		
			var ll:PointLight = light2 as PointLight;
			ll.diffuse = 1
			ll.color += 0x0;
			light.diffuse = 0.5;
			light.direction  = new Vector3D(0, -1, -1);
			light2.position = new Vector3D(0, 50, 0);
			
			stage.addEventListener(Event.ENTER_FRAME, update);
			
			return
		
		}
		
		private function update(e:Event):void 
		{
			//light.lookAt(obj);
			light2.lookAt(new Vector3D);
			light2.position = obj;
			sceneController.update();
			//cube.rotationY+=0.5
			
		}
		
		
		private function onCompletet(e:ParserEvent):void 
		{
			trace('completed');
		}
		
		private function onMeshComplete2(e:AssetEvent):void 
		{
			view3d.scene.addChild(e.asset as Mesh);
		}
		
		private function onMeshComplete(e:AssetEvent):void 
		{
			view3d.scene.addChild(e.asset as ObjectContainer3D);
			trace(e.asset, e.asset.name);
			
			var container:ObjectContainer3D = e.asset as ObjectContainer3D;
			
			TweenLite.to(container, 5, { rotationX:379 } );
			//(e.asset as Mesh).material.lightPicker = picker;
			//(e.asset as Mesh).scale(0.5);
		}
		
		private function startTween():void
		{
			TweenLite.to(obj, 5, { z:-1000 + Math.random() * 1000, x:1000, onComplete:completTween } );
		}
		private function completTween():void 
		{
			TweenLite.to(obj, 5, { z:-1000 + Math.random() * 1000,x:-1000, onComplete:startTween } );
		}
		
		
		
		private var obj:Vector3D = new Vector3D(0, 550, 0);
		private var light:Object;
		private var light2:PointLight = new PointLight();;
		private var picker:StaticLightPicker;
		private var mat:TextureMaterial;
		private var view3d:View3D;
		
		
	}
	
}