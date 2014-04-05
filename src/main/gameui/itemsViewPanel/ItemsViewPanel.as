package gameui.itemsViewPanel 
{
	import ui.ScrollBar;
	import ui.style.Style;
	import ui.UIComponent;
	
	public class ItemsViewPanel extends UIComponent 
	{
		private var columns:int;
		private var rows:int;
		
		public var itemClass:Class;
		
		public function ItemsViewPanel(style:Style=null, rows:int, columns:int) 
		{
			this.rows = rows;
			this.columns = columns;
			super(style);
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			var scroll:ScrollBar = new ScrollBar()
			
			
			for (var i:int = 0; i < rows; i++)
			{
				for (var j:int = 0; j < columns; j++)
				{
					
				}
			}
		}
		
	}

}