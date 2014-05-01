package demo 
{

	import characters.controller.data.RotationData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class SimpleUI extends Sprite 
	{
		
		private var _isSpeedBoost:Boolean;
		private var speedField:TextField;
		private var statusField:TextField;
		private var rotationViewer:RotationViewer;
		
		public function SimpleUI() 
		{
			super();
			
			initialzie();
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		private function onFrame(e:Event):void 
		{
			align();
		}
		
		public function align():void
		{
			speedField.x = 10;
			statusField.x = 10;
			speedField.y = stage.stageHeight - speedField.height - 10;
			statusField.y = speedField.y - speedField.height - 10;
			
			rotationViewer.y = statusField.y - rotationViewer.height;
			//rotationViewer.x = (stage.stageWidth - rotationViewer.width) / 2;
			//rotationViewer.y = (stage.stageHeight - rotationViewer.height) / 2;
		}
		
		private function initialzie():void 
		{
			speedField = new TextField();
			speedField.autoSize = TextFieldAutoSize.LEFT;
			
			speedField.defaultTextFormat = new TextFormat('FixedSys', 20, 0xFFFFFF);
			
			addChild(speedField);
			
			statusField = new TextField();
			statusField.autoSize = TextFieldAutoSize.LEFT;
			
			statusField.defaultTextFormat = new TextFormat('FixedSys', 20, 0xFFFFFF);
			
			addChild(statusField);
			
			rotationViewer = new RotationViewer();
			
			addChild(rotationViewer);


		}
		
		public function setSpeed(toFixed:String, percent:Number):void
		{
			speedField.text = "Скорость: " + toFixed + "\t" + percent + '%';
		}
		
		public function get isSpeedBoost():Boolean 
		{
			return _isSpeedBoost;
		}
		
		public function set isSpeedBoost(value:Boolean):void 
		{
			if (value)
				statusField.text = 'Форсаж: ON';
			else
				statusField.text = 'Форсаж: OFF';
				
			_isSpeedBoost = value;
		}
		
		public function set rotationData(value:RotationData):void 
		{
			rotationViewer.rotationData = value;
		}
		
	}

}