package demo 
{
	import away3d.entities.Mesh;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.FogMethod;
	import away3d.materials.methods.PhongSpecularMethod;
	import away3d.materials.TextureMaterial;
	import away3d.textures.BitmapTexture;
	import away3d.textures.SpecularBitmapTexture;
	import characters.Actor;
	import characters.model.PlanetModel;
	import characters.view.PlanetViewController;
	import core.fileSystem.FsFile;
	import core.fileSystem.IFS;
	import core.fileSystem.LocalFileSystem;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.geom.Point;

	import flash.display.BlendMode;
	/**
	 * ...
	 * @author Nikro
	 */
	public class PlanetoidFactory 
	{
		[Inject]
		public var fog:FogMethod 
		
		[Inject]
		public var vfs:LocalFileSystem;
		
		[Inject]
		public var lights:StaticLightPicker;
		
		public function PlanetoidFactory() 
		{
			inject(this);
		}
		
		//clouds.jpg diffuse.jpg normal.jpg specular.jpg
		private var planetsPath:String = 'res/textures/planets/';
		private var planetMaterial:TextureMaterial;
		private var cloudMaterial:TextureMaterial;
		private var texturePath:String;

		
		public function build(texturePath:String, rot:Number, radius:Number, orbitRadius:Number, atmosphereSize:Number, isHaveClods:Boolean = false, isHaveAtmosphere:Boolean = true, atmosphereColor:uint = 0x1671cc):Actor
		{
			this.texturePath = texturePath;
			
			buildMaterials();
		
			var planetModel:PlanetModel = new PlanetModel();
			planetModel.rotationSpeed = rot;
			planetModel.radius = radius;
			planetModel.orbitRadius = orbitRadius;
			planetModel.isHaveAtmosphere = isHaveAtmosphere;
			planetModel.atmosphereColor = atmosphereColor;
			planetModel.atmosphereSize = atmosphereSize;
			planetModel.ishaveClouds = isHaveClods;
			
			var planetView:PlanetViewController = new PlanetViewController(planetModel);
			var actor:Actor = new Actor(planetView);
			
			planetView.x = orbitRadius;
			
			planetView.body.material = planetMaterial;
			
			if(planetModel.ishaveClouds)
				planetView.clouds.material = cloudMaterial;
			
			if (planetView.atmosphere)
				planetView.atmosphere.material.lightPicker = lights;
			
			return actor;
		}
		
		private function buildMaterials():void
		{
			var diffuse:BitmapTexture = new BitmapTexture(vfs.getFile(planetsPath + texturePath + '/diffuse.jpg').content);
			
			planetMaterial = new TextureMaterial(diffuse);
			
			planetMaterial.specularMethod = new PhongSpecularMethod();
			
			if (fog)
				planetMaterial.addMethod(fog);
				
			planetMaterial.specular = 0.5
			planetMaterial.gloss = 50;
			planetMaterial.ambient = 1;
			
			var normalFile:FsFile = vfs.getFile(planetsPath + texturePath + '/normal.jpg')
			if(normalFile)
				planetMaterial.normalMap = new BitmapTexture(normalFile.content);
			
			var specularFile:FsFile = vfs.getFile(planetsPath + texturePath + '/specular.jpg')
			if(specularFile)
				planetMaterial.specularMap = new BitmapTexture(specularFile.content);
			else
				planetMaterial.specular = 0;
				
			var cloudFiled:FsFile = vfs.getFile(planetsPath + texturePath + '/clouds.jpg')
			
			var ambientFile:FsFile = vfs.getFile(planetsPath + texturePath + '/ambient.jpg')
			
			if (ambientFile)
				planetMaterial.ambientTexture = new BitmapTexture(ambientFile.content);
			
			if (cloudFiled)
			{
				cloudMaterial = new TextureMaterial(new BitmapTexture(blackToTransparent(cloudFiled.content)));
				cloudMaterial.alphaBlending = true;
				cloudMaterial.specular = 0;
				cloudMaterial.alpha = 0.2;
				cloudMaterial.blendMode = BlendMode.ADD;
			}
				
			planetMaterial.lightPicker = lights;
		}
		
		private function blackToTransparent( original:BitmapData ):BitmapData {
			var bmd:BitmapData = new BitmapData( original.width, original.height, true, 0xFFFFFFFF );
			bmd.copyChannel( original, bmd.rect, new Point(), BitmapDataChannel.RED, BitmapDataChannel.ALPHA );
			return bmd;
		}
		
	}

}