package gameui 
{
	import core.fileSystem.IFS;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import ui.Button;
	import ui.LineDrawer;
	import ui.style.Style;
	import ui.style.StylesCollector;
	import ui.UIComponent;
	
	public class MenuPanel extends UIComponent 
	{
		private var icons:Vector.<DisplayObject> = new Vector.<DisplayObject>;
		private var logo:Button;
		
		private var designLine12:LineDrawer;
		private var designLine11:LineDrawer;
		
		[Inject]
		public var styles:StylesCollector;
		
		[Inject]
		public var vfs:IFS;
		
		[Inject]
		public var scenesController:ScenesController
		
		public function MenuPanel(style:Style=null) 
		{
			inject(this);
			super(style);
			
		}
		
		override protected function createChildren():void 
		{
			var icon:ScaleBitmap;
			var i:int;
			super.createChildren();
			
			for (i = 4; i > -1; i--)
			{
				icon = new ScaleBitmap(vfs.getFile("res/textures/ui/menuPanel/icon" + i + ".png").content);
				icon.scale9Grid = new Rectangle(1, 1, 1, 1);
				icon.setSize(38, 38);
				
				icons.push(icon);
			}
				
			logo = new Button(styles.getStyle("menuPanelLogo"), "НАЙТИ ИГРУ");
			logo.width = 160;
			logo.height = 58;
			
			icons.push(logo);
			
			for (i = 0; i < 5; i++)
			{
				icon = new ScaleBitmap(vfs.getFile("res/textures/ui/menuPanel/icon" + i + ".png").content);
				icon.scale9Grid = new Rectangle(1, 1, 1, 1);
				icon.setSize(38, 38);
				
				icons.push(icon);
			}
			
			designLine11 = new LineDrawer(styles.getStyle("mainMenu"), null, false);
			designLine12 = new LineDrawer(styles.getStyle("mainMenu"), null, false);
		
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			logo.addEventListener(MouseEvent.MOUSE_DOWN, onFindClicked);
		}
		
		private function onFindClicked(e:MouseEvent):void 
		{
			//logo.label = "ищем мач";
			
			scenesController.showGame();
		}
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			addComponent(designLine11);
			addComponent(designLine12);
			
			for (var i:int = 0; i < icons.length; i++)
			{
				addChild(icons[i]);
			}
			 
			addComponent(logo)
		}
		
		override protected function layoutChildren():void 
		{
			super.layoutChildren();
			
			var x:Number = 40;
			for (var i:int = 0; i < icons.length; i++)
			{
				icons[i].x = x;
				icons[i].y = 20;
				x += (icons[i].width + 2);
			}
			
			designLine11.path.push( 0, 0, false);
			designLine11.path.push( 0, 40);
			designLine11.path.push( 640, 40);
			designLine11.path.push( 640, 0, false);
			
			designLine12.path.push( logo.x - 20, 0, false);
			designLine12.path.push( logo.x - 20, logo.y + logo.height + 15);
			designLine12.path.push( logo.x + logo.width + 20, logo.y + logo.height + 15);
			designLine12.path.push( logo.x + logo.width + 20, 0, false);
			
			
		}
		
	}

}