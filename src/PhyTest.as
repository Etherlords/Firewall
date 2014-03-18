package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class PhyTest extends Sprite 
	{
		private var startTime:Number;
		
		private static var A:Number = 5
		private static var V0:Number = 0;
		private static var V1:Number = 15;
		
		private static var DV:Number = V1 - V0;
		private static var DT:Number = DV * A * -1000;
		
		
		private var v:Number = 0;
		private var a:Number = 5;
		
		public function PhyTest() 
		{
			super();
			
			startTime = 0;
			
			stage.addEventListener(Event.ENTER_FRAME, onFrame);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			applyForce();
		}
		
		private function applyForce():void 
		{
			var force:Vector3D = new Vector3D(stage.mouseX, stage.mouseY);
			force.normalize();
			force.scaleBy(5);
			
			forces.push(force);
		}
		
		private var time:Number = 0;
		private var vel:Vector3D = new Vector3D(0, 0);
		private var pos:Vector3D = new Vector3D(stage.stageWidth / 2, stage.stageHeight / 2);
		private var force:Vector3D = new Vector3D();
		
		private var linearDamping:Number = 0;
		private var mass:Number = 10;
		private var invMass:Number = 1.0 / mass;
		
		private var forces:Vector.<Vector3D> = new Vector.<Vector3D>;
			
		private function onFrame(e:Event):void 
		{
			if (startTime == 0)
				startTime = new Date().getTime();
				
			var dt:Number = new Date().getTime() - startTime;
			
			startTime = new Date().getTime();
			
			time += dt;
			
			var timePart:Number = time / 1000;
			
			for (var i:int = 0; i < forces.length; i++)
			{
				force = forces[i];
				vel.x = timePart * (invMass * force.x);
				vel.y = timePart * (invMass * force.y);
			}
			
			var translationX:Number = pos.x + timePart * vel.x;
			var translationY:Number = pos.y + timePart * vel.y;
			
			graphics.clear();
			
			graphics.beginFill(0xFFFFFF)
			graphics.drawCircle(translationX * 1, translationY * 1, 15);
			
		}
		
	}

}