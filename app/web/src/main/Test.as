package  
{
	import away3d.Away3D;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.debug.AwayStats;
	import away3d.entities.Entity;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.loaders.Loader3D;
	import away3d.loaders.parsers.AWD2Parser;
	import away3d.loaders.parsers.Parsers;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.MaterialBase;
	import away3d.materials.methods.CascadeShadowMapMethod;
	import away3d.materials.methods.EnvMapMethod;
	import away3d.materials.methods.FilteredShadowMapMethod;
	import away3d.materials.methods.SoftShadowMapMethod;
	import away3d.materials.MultiPassMaterialBase;
	import away3d.materials.SkyBoxMaterial;
	import away3d.materials.utils.DefaultMaterialManager;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.SkyBox;
	import away3d.textures.BitmapCubeTexture;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Vector3D;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class Test extends Sprite 
	{
		private var scene:Scene3D;
		
		[Embed(source = "../../bin/skybox/snow_negative_x.jpg")]
		private var sbNegX:Class
		[Embed(source = "../../bin/skybox/snow_negative_y.jpg")]
		private var sbNegY:Class
		[Embed(source = "../../bin/skybox/snow_negative_z.jpg")]
		private var sbNegZ:Class
		[Embed(source = "../../bin/skybox/snow_positive_x.jpg")]
		private var sbPosX:Class
		[Embed(source = "../../bin/skybox/snow_positive_y.jpg")]
		private var sbPosY:Class
		[Embed(source = "../../bin/skybox/snow_positive_z.jpg")]
		private var sbPosZ:Class
		
		private var view:View3D;
		
		
		private var ignoreMaterials:Object = { 'gum':true, "black":true, "black m":true, "dash":true, "organge":true, "Material1":true };
		
		public function Test() 
		{
			super();
			
			stage.align = 'TL';
			stage.scaleMode = 'noScale';
			
			Parsers.enableAllBundled()

			
			camera = new GameCamera(stage);
			
			view = new View3D(null, camera.camera);
			view.antiAlias = 4;
			scene = view.scene;
			addChild(new AwayStats(view));
			
			
			addChild(view);
			
			init();
			
			view.camera.position = new Vector3D(0, 1500, 1000);
			view.camera.lookAt(new Vector3D());
			
			stage.addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		private function onFrame(e:Event):void 
		{
			camera.render();
			view.render();
			
			if(light)
				light.position = obj;
		}
		
		private function init():void 
		{
			
			var cubeTexture:BitmapCubeTexture = new BitmapCubeTexture(new sbPosX().bitmapData, new sbNegX().bitmapData, new sbPosY().bitmapData, new sbNegY().bitmapData, new sbPosZ().bitmapData, new sbNegZ().bitmapData)
			envMethod = new EnvMapMethod(cubeTexture, 0.18);
			
			scene.addChild(new SkyBox(cubeTexture));
			
			var parser:AWD2Parser = new AWD2Parser();
			parser.materialMode = 2;
			parser.addEventListener(AssetEvent.LIGHTPICKER_COMPLETE, onGetLightPicker);
			parser.addEventListener(AssetEvent.MATERIAL_COMPLETE, onMaterialComplete);
			parser.addEventListener(AssetEvent.MESH_COMPLETE, onMesh);
			
			var loader:Loader3D = new Loader3D();
			loader.load(new URLRequest('Nissan2.awd'), null, null, parser);
			scene.addChild(loader);
			
		
			camera.setTracingObject(loader);
		}
		
		private function onMesh(e:AssetEvent):void 
		{
			var mesh:Mesh = e.asset as Mesh;
		}
		
		private function onMaterialComplete(e:AssetEvent):void 
		{
			if (e.asset.name in ignoreMaterials)
				return;
				
			
				
			e.asset['addMethod'](envMethod);
		}
		
		private function onGetLightPicker(e:AssetEvent):void 
		{
			light = new PointLight();
			
			light.fallOff = 800;
			light.radius = 600
		
			
			light.color += 0x0;
			light.diffuse = 0.5;
			
			light.position = new Vector3D(0, 50, 0);
			
			picker = e.asset as StaticLightPicker;
			picker.lights.push(light);
			//picker.lights = [light];
			picker.lights = picker.lights;
			startTween();
			
			
			
		}
		
		private function startTween():void
		{
			TweenLite.to(obj, 5, { z:1000, x:0, onComplete:completTween } );
		}
		private function completTween():void 
		{
			TweenLite.to(obj, 5, { z:-1000, x:0, onComplete:startTween } );
		}
		
		
		
		private var obj:Vector3D = new Vector3D(0, 800, 0);
		private var light:PointLight;
		private var controller:HoverController;
		private var camera:GameCamera;
		private var envMethod:EnvMapMethod;
		private var picker:StaticLightPicker;
		
	}

}