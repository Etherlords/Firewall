package  
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Nikro
	 */
	public class ObjectController 
	{
		private var stage:Stage;
		
		public var lastPanAngle:Number = 0
		public var lastTiltAngle:Number = 0;
		private var lastMouseX:Number = 0;
		private var lastMouseY:Number = 0;
		private var _isCameraMovie:Boolean;
		
		public function ObjectController(stage:Stage) 
		{
			this.stage = stage;
			
			initialize();
		}
		
		private function initialize():void 
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		public function render():void
		{
			if (_isCameraMovie)
			{
				var halfStageWidth:Number = stage.stageWidth / 2;
				var halfStageHeight:Number = stage.stageHeight / 2;

				lastPanAngle = -(halfStageWidth - stage.mouseX) / halfStageWidth;
				lastTiltAngle = -(halfStageHeight - stage.mouseY) / halfStageHeight;
			}
			else
			{
				lastPanAngle = 0;
				lastTiltAngle = 0;
			}
			
			if (lastPanAngle > 1)
				lastPanAngle = 1;
				
			if (lastTiltAngle > 1)
				lastTiltAngle = 1;
				
			if (lastPanAngle < -1)
				lastPanAngle = -1;
				
			if (lastTiltAngle < -1)
				lastTiltAngle = -1;
			
			//lastMouseX = stage.mouseX;
			//lastMouseY = stage.mouseY;
		}
		
		private function onMouseWheel(e:MouseEvent):void 
		{
			
		}
		
		private function onMouseDown(event:MouseEvent):void
		{
			lastMouseX = 0
			lastMouseY = 0
			
			_isCameraMovie = true;
			stage.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		private function onStageMouseLeave(event:Event):void
		{
			_isCameraMovie = false;
			stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			_isCameraMovie = false;
			lastMouseX = 0;
			lastMouseY = 0;
			stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
	}

}