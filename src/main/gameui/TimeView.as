package gameui 
{
	import ui.style.Style;
	import ui.style.StylesCollector;
	import ui.Text;
	import ui.UIComponent;
	
	public class TimeView extends UIComponent 
	{
		[Inject]
		public var styles:StylesCollector;
		private var text:Text;
		
		private var blick:Boolean = true;
		private var count:int = 0;
		
		public function TimeView(style:Style=null) 
		{
			inject(this);
			super(style);
		}
			
		override protected function createChildren():void 
		{
			super.createChildren();
			
			text = new Text(styles.getStyle('playerPanelInfoText'));
			text.font = 'FixedSys';
			text.leading = 0;
		}
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			addComponent(text);
		}
		
		override public function update():void 
		{
			super.update();
			
			count++;
			
			if (count == 30)
			{
				count = 0;
				blick = !blick;
			}
			
			var date:Date = new Date();
			text.text = date.getHours() + (blick? ':':' ') + date.getMinutes();
		}
	}

}