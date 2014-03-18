package demo 
{

	import characters.controller.data.RotationData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class RotationViewer extends Sprite 
	{
		
		public var rotationData:RotationData;
		
		public function RotationViewer() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
				
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		private function onFrame(e:Event):void 
		{
			draw();
		}
		
		private function draw():void
		{
			graphics.clear();
			
			graphics.lineStyle(1, 0xFFFFFF);
			
			//drawBase();
			drawMouseLine();
		}
		
		private function drawMouseLine():void 
		{
			
			
			//graphics.lineTo(60, 60);
			
			var baseHeight:Number = 200;
			
			graphics.lineStyle(5, 0xFF0000);
			graphics.moveTo(0, 0);
			graphics.lineTo(baseHeight, 0)
	
			if (rotationData.currentRotationRateX != 0)
			{
				
				var speedUpHeight:Number = baseHeight * (rotationData.currentMaxRotationRateX / rotationData.maxRotationRateX);
				var height:Number = speedUpHeight * (rotationData.currentRotationRateX / rotationData.currentMaxRotationRateX)
				
				
				if (height > speedUpHeight)
					height = speedUpHeight;
					
				if (height < -speedUpHeight)
					height = -speedUpHeight
					
				
				
				graphics.lineStyle(5, 0xFFFFFF);
				graphics.moveTo(0, 0);
				graphics.lineTo(height, 0)
			}
		}
		
		private function drawBase():void
		{
			
			graphics.drawCircle(60, 60, 60);
		}
	}

}