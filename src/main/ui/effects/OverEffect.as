package ui.effects 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;

	public class OverEffect 
	{
		private var target:Sprite;

		public function OverEffect() 
		{

		}
		
		public function initialize(target:Sprite):void 
		{
			this.target = target;
			
			target.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			target.addEventListener(MouseEvent.MOUSE_OUT, onOut);
		}
		
		private function onOver(e:MouseEvent):void 
		{
			var matrix:Array = new Array();
			matrix = matrix.concat([1, 0, 0, 0, 55]); // red
			matrix = matrix.concat([0, 1, 0, 0, 55]); // green
			matrix = matrix.concat([0, 0, 1, 0, 55]); // blue
			matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha
		 
			target.filters = [new ColorMatrixFilter(matrix)]
		}
		
		private function onOut(e:MouseEvent):void 
		{
			target.filters = [];
		}
		

	}

}