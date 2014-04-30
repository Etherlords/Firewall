package ui 
{
	
	public class LinePath
	{
		private var points:Vector.<LinePathPoint> = new Vector.<LinePathPoint>;
		
		public var isModifed:Boolean = false;
		
		
		public function LinePath() 
		{
			
		}
		
		public function clear():void
		{
			points = new Vector.<LinePathPoint>;
			isModifed = true;
		}
		
		public function push(x:Number, y:Number, isShow:Boolean = true):void
		{
			pushPoint(new LinePathPoint(x, y, isShow));
			isModifed = true;
		}
		
		public function pushPoint(linePathPoint:LinePathPoint):void 
		{
			points.push(linePathPoint);
			isModifed = true;
		}
		
		public function getPoint(i:int):LinePathPoint
		{
			return points[i];
		}
		
		public function get length():int
		{
			return points.length;
		}
		
	}

}