package  
{
	import away3d.core.base.Object3D;
	import core.utils.dump.dumpByteArray;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import objectState.ObjectState;
	
	public class StartUp extends Sprite 
	{
		private static const classRef:ClassReference = new ClassReference();
		
		public function StartUp() 
		{
			super();
			
			var objState:ObjectState = new ObjectState();
			var o:Object3D = new Object3D();
			o.name = 'test';
			var ba:ByteArray = objState.writeObject(o, new < String > ["rotationX", "rotationY", "rotationZ", 'name']);
			
			ba.position = 0;
			objState.readObject(ba, o);
		
			
			return;
			
			if (stage)
				initialize();
			else
				addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		/*private function test():void
		{
			calc();
			calc();
			calc();
			calc();
			
			rotationNormal.x = 0.79
			
			calc();
			calc();
			calc();
			calc();
			calc();
			calc();
			calc();
		}
		
		private var rotationNormal:Vector3D = new Vector3D(-0.69);
		private var rotationData:RotationData = new RotationData();
		
		private function calc():void
		{
			var partOfIteration:Number = 33 / 1000;
			
			var rotationDeltaX:Number = Math.abs(rotationNormal.x - rotationData.currentRotationX);
			var xIteration:Number = rotationData.rotationRate * partOfIteration
				
			trace(rotationDeltaX, xIteration, rotationDeltaX > xIteration, rotationNormal.x, rotationData.currentRotationX)
			if (rotationDeltaX > xIteration)
			{
				if (rotationData.currentRotationX > rotationNormal.x)
					rotationData.currentRotationX -= xIteration
				else
					rotationData.currentRotationX += xIteration
			}
			else
				rotationData.currentRotationX = rotationNormal.x;
		}*/
		
		private function initialize(e:Event = null):void 
		{
			//test();
			//return
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			stage.align = 'TL';
			stage.scaleMode = 'noScale';
			
			addToContext(stage);
			
			var XMLBootsTrap:XMLBootstrap = new XMLBootstrap();
			XMLBootsTrap.loadConfig('/config/test/main.xml');
		}
		
	}

}