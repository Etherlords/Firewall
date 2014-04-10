package ui 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.LineScaleMode;
	import ui.style.Style;
	
	public class LineDrawer extends UIComponent 
	{
		private var _path:LinePath;
		private var closePath:Boolean;
		
		public var anchornPattern:BitmapData;
		public var lineColor:uint// = 0xCCCCCC;
		public var lineWidth:Number = 1;
		
		
		public function LineDrawer(style:Style=null, path:LinePath = null, closePath:Boolean = false) 
		{
			super(style);
			
			this.closePath = closePath;
			
			if (!path)
				_path = new LinePath();
			else
				draw();
		}
		
		override protected function buildStyleSheet():void 
		{
			super.buildStyleSheet();
			
			addStyleSheet("anchorn", "anchornPattern");
			addStyleSheet("lineColor", "lineColor");
			addStyleSheet("lineWidht", "lineWidth");
		}
		
		override public function update():void 
		{
			super.update();
			
			if (path.isModifed)
				draw();
		}
		
		public function draw():void 
		{
			this.graphics.clear();
			
			while (numChildren)
				removeChildAt(0);
				
			if (!_path.length)
				return;
				
			drawAnchorn(_path.getPoint(0));
			
			for (var i:int = 1; i < _path.length; i++)
			{
				drawLine(_path.getPoint(i - 1), _path.getPoint(i));
				drawAnchorn(_path.getPoint(i));
			}
			
			if(closePath)
				drawLine(_path.getPoint(_path.length - 1), _path.getPoint(0));
			
			path.isModifed = false;
		}
		
		private function drawLine(from:LinePathPoint, to:LinePathPoint):void
		{
			graphics.lineStyle(lineWidth, lineColor, 1, true, LineScaleMode.NORMAL, CapsStyle.NONE);
			graphics.moveTo(from.x, from.y);
			graphics.lineTo(to.x, to.y);
		}
		
		private function drawAnchorn(point:LinePathPoint):void
		{
			if (!point.isShow)
				return;
				
			var bmp:Bitmap = new Bitmap(anchornPattern);
			
			addChild(bmp);
			bmp.x = (point.x - anchornPattern.width / 2);
			bmp.y = (point.y - anchornPattern.height / 2);
		}
		
		public function get path():LinePath
		{
			return _path;
		}
		
		public function set path(value:LinePath):void 
		{
			_path = value;
		}
		
	}

}