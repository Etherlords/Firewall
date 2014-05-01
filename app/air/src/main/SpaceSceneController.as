package  
{
	import away3d.containers.View3D;
	import characters.Actor;
	import display.SceneController;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class SpaceSceneController extends SceneController 
	{
		
		private var _planets:Vector.<Actor> = new Vector.<Actor>
		private var _ships:Vector.<Actor> = new Vector.<Actor>
		public var sun:Actor;
		
		public function SpaceSceneController(view:View3D) 
		{
			super(view);
			
		}
		
		public function addPlanet(actor:Actor):void
		{
			_planets.push(actor);
			addDisplayObject(actor);
		}
		
		public function addSpaceShip(actor:Actor):void
		{
			_ships.push(actor);
			addDisplayObject(actor);
		}
		
		public function addSun(actor:Actor):void
		{
			sun = actor
			addDisplayObject(actor);
		}
		
		public function get ships():Vector.<Actor> 
		{
			return _ships;
		}
		
		public function get planets():Vector.<Actor> 
		{
			return _planets;
		}
		
	}

}