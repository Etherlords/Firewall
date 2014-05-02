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
	import away3d.loaders.parsers.AWD2Parser;
	import away3d.loaders.parsers.AWDParser;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.TextureMaterial;
	import away3d.materials.utils.DefaultMaterialManager;
	import away3d.primitives.CubeGeometry;
	import away3d.textures.BitmapTexture;
	import away3d.textures.SpecularBitmapTexture;
	import away3d.textures.Texture2DBase;
	import characters.Actor;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import core.collections.SimpleMap;
	import core.fileSystem.Directory;
	import core.fileSystem.external.DirectoryScaner;
	import core.ioc.Context;
	import core.utils.dump.dumpByteArray;
	import display.SceneController;
	import display.ViewController;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.PNGEncoderOptions;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Vector3D;
	import flash.system.ApplicationDomain;
	import flash.system.JPEGLoaderContext;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class Main extends Sprite 
	{
		private var sceneController:SceneController;
		
		//[Embed(source = "../res/textures/ci-fi_box/Sci_Fi_Tile_01_Normal.png")]
		[Embed(source="../res/textures/T_002_Metal_N.png")]
		private var bumpRes:Class;
		private var bumpSrc:BitmapData = new bumpRes().bitmapData;
		
		//[Embed(source = "../res/textures/ci-fi_box/Sci_Fi_Tile_01_Diffuse.png")]
		[Embed(source="../res/textures/T_002_Metal_D.png")]
		private var difRes:Class;
		private var difSrc:BitmapData = new difRes().bitmapData;
		
		//[Embed(source = "../res/textures/ci-fi_box/Sci_Fi_Tile_01_Emissive.png")]
		[Embed(source="../res/textures/T_002_Metal_E.png")]
		private var emRes:Class;
		private var emSrc:BitmapData = new emRes().bitmapData;
		
		//[Embed(source = "../res/textures/ci-fi_box/Sci_Fi_Tile_01_Specular.png")]
		[Embed(source="../res/textures/T_002_Metal_S.png")]
		private var specRes:Class;
		private var specSrc:BitmapData = new specRes().bitmapData;
		private var cube:ObjectContainer3D;
		
		
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
		
		private function constructMaterial():void
		{
			
			mat = new TextureMaterial(DefaultMaterialManager.getDefaultTexture(), true, false, true);
			mat.normalMap = new BitmapTexture(new BitmapData(2, 2));
			mat.ambientTexture = new BitmapTexture(new BitmapData(2, 2));
			mat.specularMap = new SpecularBitmapTexture(new BitmapData(2, 2));
			mat.lightPicker = picker;
			mat.specular = 1;
			mat.gloss = 160;
			mat.ambient = 10.5
			mat.specular = 1;
		}
		
		private var dates:Object = { };
		
		private var texturesDir:File = new File("C:/git/Firewall/res/textures");
		public function fillMaterial():void
		{
			
		

			loadTexture('D', 'texture');
			loadTexture("S", 'specularMap');
			loadTexture("E", 'ambientTexture');
			loadTexture("N", 'normalMap');
		}
		
		private function loadTexture(type:String, field:String):void
		{
			if (!mat)
				return;
				
			var index:int = 2;
			var name:String = "T_00%_Metal_@.png"
			
			var source:File = texturesDir.resolvePath(name.replace('%', index.toString()).replace('@', type));
			
			if(!source.exists || (type in dates && dates[type] >= source.modificationDate.getTime()))
				return;
				
			dates[type] = source.modificationDate.getTime();
			
			var stream:FileStream = new FileStream();
			stream.open(source, FileMode.READ);
			var ba:ByteArray = new ByteArray();
			stream.readBytes(ba, 0, stream.bytesAvailable);
			stream.close();
			
			var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			var loader:Loader = new Loader();
			loader.loadBytes(ba, context);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void{mat[field]['bitmapData'] = (e.currentTarget as LoaderInfo).content['bitmapData']})
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
			constructMaterial();
			fillMaterial();
			
			var size:Number = 300
			
			cube = new Mesh(new CubeGeometry(size, 10, size, 1, 1, 1, false), mat);
			var viewController:ViewController = new ViewController(cube);
			var actor:Actor = new Actor(viewController)
			
			sceneController.addDisplayObject(actor);
			
			
			
			cube.x = -1000;
			for (var i:int = 0; i < 20; i++)
			{
				cube.x = -1000;
				for (var j:int = 0; j < 20; j++)
				{
					cube = cube.clone() as ObjectContainer3D
					viewController = new ViewController(cube);
					actor = new Actor(viewController)
					
					sceneController.addDisplayObject(actor);
					cube.x = -1000 + i * size;
					cube.z = 1000 + j * -size;
				}
			}
			
			
			
			
			
			return
			var dir:DirectoryScaner = new DirectoryScaner();
			
			var dirsStorage:Directory = new Directory();
			dirsStorage.name = 'root';
			dir.scan(new File('C://git/Firewall/res'), dirsStorage);
			
			scan(dirsStorage);
			
			
			
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
		
		
		
		private function scan(dir:Directory):void
		{
			for (var next:Directory = dir.currentItem; next != null; next = dir.nextItem)
			{
				trace('dir', next.name);
				
				scan(next);
			}
		}
		
		private function update(e:Event):void 
		{
			//light.lookAt(obj);
			light2.lookAt(new Vector3D);
			light2.position = obj;
			sceneController.update();
			//cube.rotationY+=0.5
			
			fillMaterial();
		}
		
	}
	
}