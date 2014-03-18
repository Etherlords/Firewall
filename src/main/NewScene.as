package  
{
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.textures.BitmapTexture;
	import core.materials.TextureMaterialController;
	import core.textures.BitmapFile;
	import core.textures.BitmapTextureBuilder;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class NewScene extends Sprite 
	{
			
		private var view:View3D;
		private var scene:Scene3D;
		private var camera:GameCamera;
		private var bitmapSource:BitmapFile;
		private var texture:BitmapTexture;
		private var materialController:TextureMaterialController;
		
		public function NewScene() 
		{
			super();
			
			stage.align = 'TL';
			stage.scaleMode = 'noScale';
			
			
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
			
			
			bitmapSource = new BitmapFile();
			var specularSource:BitmapFile = new BitmapFile();
			var normalSource:BitmapFile = new BitmapFile();
			var ambientSource:BitmapFile = new BitmapFile();
			
			var bitmapTextureBuilder:BitmapTextureBuilder = new BitmapTextureBuilder();
			bitmapTextureBuilder.source = bitmapSource;
			
			var bitmapTextureBuilder1:BitmapTextureBuilder = new BitmapTextureBuilder();
			bitmapTextureBuilder1.source = specularSource;
			
			var bitmapTextureBuilder2:BitmapTextureBuilder = new BitmapTextureBuilder();
			bitmapTextureBuilder2.source = normalSource;
	
			var bitmapTextureBuilder3:BitmapTextureBuilder = new BitmapTextureBuilder();
			bitmapTextureBuilder3.source = ambientSource;
			
			materialController = new TextureMaterialController();
			materialController.diffuseTextureBuilder = bitmapTextureBuilder;
			materialController.specularTextureBuilder = bitmapTextureBuilder1;
			materialController.normalTextureBuilder = bitmapTextureBuilder2;
			materialController.ambientTextureBuilder = bitmapTextureBuilder3;
			
			bitmapSource.addEventListener(Event.CHANGE, onSourceChange);
			
			bitmapSource.addEventListener(Event.COMPLETE, onSourceLoaded);
			normalSource.addEventListener(Event.COMPLETE, onSourceLoaded);
			ambientSource.addEventListener(Event.COMPLETE, onSourceLoaded);
			specularSource.addEventListener(Event.COMPLETE, onSourceLoaded);
			
			bitmapSource.init(File.applicationDirectory.nativePath + "/../res/textures/T_002_Metal_D.png");
			ambientSource.init(File.applicationDirectory.nativePath + "/../res/textures/T_002_Metal_E.png");
			normalSource.init(File.applicationDirectory.nativePath + "/../res/textures/T_002_Metal_N.png");
			specularSource.init(File.applicationDirectory.nativePath + "/../res/textures/T_002_Metal_S.png");
		}
		
		private function onSourceChange(e:Event):void 
		{
			bitmapSource.load();
		}
		
		private var c:Number = 4;
		private var cube:Mesh;
		
		private function onSourceLoaded(e:Event):void 
		{
			trace(e.target);
			c--;
			
			if (c)
				return
			
			if (!texture)
			{
				texture = new BitmapTexture(bitmapSource.output);
				materialController.buildMaterial()
				var material:TextureMaterial = materialController.material;
				
				cube = new Mesh(new CubeGeometry(250, 250, 250, 1, 1, 1, false), material);
				
				scene.addChild(cube);
			}
			else
				texture.bitmapData = bitmapSource.output
		}
		
		private function onFrame(e:Event):void 
		{
			if(cube)
				cube.rotationX++;
			
			view.render();
		}
		
	}

}