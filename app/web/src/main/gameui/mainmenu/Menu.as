package gameui.mainmenu 
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import ui.Button;
	import ui.style.Style;
	import ui.style.StylesCollector;
	import ui.UIComponent;
	
	public class Menu extends UIComponent 
	{
		public var framePattern:BitmapData
		
		public var hangar:Button;
		public var shop:Button;
		public var cabinsCompany:Button;
		public var researchCetner:Button;
		public var commandCenter:Button;
		
		[Inject]
		public var styles:StylesCollector;
		
		public var selectedButton:Button;
		private var buttons:Vector.<Button>;
		
		public function Menu(style:Style=null) 
		{
			inject(this);
			super(style);
		}
		
		override protected function buildStyleSheet():void 
		{
			super.buildStyleSheet();
			
			addStyleSheet('frame', "framePattern");
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			hangar = createButton("HANGAR");
			shop = createButton("SHOP");
			cabinsCompany = createButton("CABINS\nCOMPANY");
			researchCetner = createButton("RESEARCH\nCENTER");
			commandCenter = createButton("COMMAND\nCENTER");
			
			buttons = new <Button>[hangar, shop, cabinsCompany, researchCetner, commandCenter];
		}
		
		private function createButton(buttonName:String):Button
		{
			var button:Button = new Button(styles.getStyle("mainMenuButton"), buttonName);
			
			button.addEventListener(MouseEvent.MOUSE_DOWN, selectButton);
			return button;
		}
		
		override protected function configureChildren():void 
		{
			super.configureChildren();
		}
		
		private function selectButton(e:MouseEvent):void 
		{
			var button:Button = e.currentTarget as Button;
			
			if (selectedButton)
				selectedButton.selected = false;
			
			selectedButton = button;
			selectedButton.selected = true;
			
			layoutChildren();
			
			var yy:Number = this.y;
			
			dispatchEvent(new Event(Event.SELECT));
		}
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			addChild(hangar);			addChild(shop);				addChild(cabinsCompany);
			addChild(researchCetner);	addChild(commandCenter);
		}
		
		override protected function layoutChildren():void 
		{
			super.layoutChildren();
			
			var y:Number = 0;
			for (var i:int = 0; i < buttons.length; i++)
			{
				if (buttons[i].selected && i != 0)
					y += 6;
					
				buttons[i].y = y;
				
				if (buttons[i].selected)
					y += 6;
				
				y += buttons[i].height + 5;
			}
			
		}
		
	}

}