package gameui 
{
	import flash.display.BitmapData;
	import ui.Button;
	import ui.style.Style;
	import ui.style.StylesCollector;
	import ui.Text;
	import ui.UIComponent;
	
	public class MachFindView extends UIComponent 
	{
		private var background:ScaleBitmap;
		private var find:Text;
		public var backgroundPattern:BitmapData;
		
		[Inject]
		public var stylesCollector:StylesCollector;
		
		public function MachFindView(style:Style=null) 
		{
			inject(this);
			super(style);
			
		}
		
		public function findStatus(aproximalyFindTime:Number):void
		{
			
		}
			
		override protected function createChildren():void 
		{
			super.createChildren();
			
			background = new ScaleBitmap(backgroundPattern);
			find = new Text(stylesCollector);
		}
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			addChild(background);
			addComponent(find);
		}
	}

}