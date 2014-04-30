package demo 
{
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.SphereGeometry;
	import flash.geom.Vector3D;
	
	public class Planet extends ObjectContainer3D
	{
		private var cloudsMesh:Mesh;
		private var planetMesh:Mesh;
		
		public var cloudRotationRate:Number = 0.1;
		public var planetRotationRate:Number = 0.1;
		
		public var planetRotationNormal:Vector3D = new Vector3D(0, 1, 0);
		public var cloudRotationNormal:Vector3D = new Vector3D(0, -1, 0);
		
		public function Planet() 
		{
			//initialize();
		}
		
		public function createClouds(clouds:TextureMaterial):void
		{
			cloudsMesh = new Mesh(new SphereGeometry(50, 24, 24), clouds);
			
			addChild(cloudsMesh);
		}
		
		public function createBody(planetMaterial:TextureMaterial):void
		{
			planetMesh = new Mesh(new SphereGeometry(49, 36, 36), planetMaterial);
			
			addChild(planetMesh);
		}
		
		public function update():void
		{
			if (cloudsMesh)
				cloudsMesh.rotate(cloudRotationNormal, cloudRotationRate);
				
			planetMesh.rotate(planetRotationNormal, planetRotationRate);
		}
		
	}

}