package ui 
{
	
	public class LinePathPoint 
	{
		public var isShow:Boolean;
		public var x:Number;
		public var y:Number;
		
		public function LinePathPoint(x:Number = 0, y:Number = 0, isShow:Boolean = false) 
		{
			this.isShow = isShow;
			this.y = y;
			this.x = x;
		}
		
	}

}