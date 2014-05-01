package  geom
{
	import characters.controller.data.MoveData;
	import flash.geom.Vector3D;
	
	public class PathMathematic 
	{
		//[Inject]
		public var worldTimeController:WorldTimeController
		
		public function PathMathematic() 
		{
			
		}
		
		public function calculateCurrentPosition(data:MoveData, position:Vector3D):void
		{
			if (data.startTime + data.travelTime <= currentTime)
			{
				position.setTo(data.endPoint.x, data.endPoint.y, position.z);
				return;
			}
			
			var timeDelta:int = currentTime - data.startTime;
			if (timeDelta <= 0)
			{
				position.setTo(data.startPoint.x, data.startPoint.y, position.z);
				return;
			}
			var partOfPath:Number = data.travelTime / timeDelta;
			
			var startPoint:Vector3D = data.startPoint;
			position.x = (data.endPoint.x - startPoint.x) / partOfPath + startPoint.x;
			position.y = (data.endPoint.y - startPoint.y) / partOfPath + startPoint.y;
		}
		
		public function get currentTime():Number 
		{
			return worldTimeController.currentTime;
		}
		
	}

}