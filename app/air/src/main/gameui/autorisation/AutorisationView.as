package gameui.autorisation 
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import ui.style.StylesCollector;
	import ui.UIComponent;
	
	public class AutorisationView extends UIComponent 
	{
		private var background:ScaleBitmap;
		private var textField:TextField;
		
		[Inject]
		public var styleCollector:StylesCollector;
		
		public var backgroundPattern:BitmapData;
		
		public function AutorisationView() 
		{
			inject(this);
			super(styleCollector.getStyle("autorisation"));
		}
		
		public function get text():String
		{
			return textField.text;
		}
		
		public function set text(value:String):void
		{
			textField.text = value;
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.x = (stage.stageWidth - this.width) / 2;
			this.y = (stage.stageHeight - this.height) / 2;
		}
		
		override protected function buildStyleSheet():void 
		{
			super.buildStyleSheet();
			
			addStyleSheet("frame", "backgroundPattern");
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			textField = new TextField();
			background = new ScaleBitmap(backgroundPattern)
		}
		
		override protected function configureChildren():void 
		{
			super.configureChildren();
			
			background.scale9Grid = new Rectangle(1, 1, 1, 1);
			background.width = 300;
			background.height = 150;
			
			textField.autoSize = TextFieldAutoSize.LEFT;
			
			textField.defaultTextFormat = new TextFormat('Vrinda', 14, 0xFFFFFF, true);
			textField.text = "Обождите идет авторизация";
		}
		
		override protected function layoutChildren():void 
		{
			super.layoutChildren();
			
			textField.x = (background.width - textField.width) / 2;
			textField.y = (background.height - textField.height) / 2;
		}
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			addChild(background);
			addChild(textField);
		}
		
	}

}