package gameui 
{
	import core.fileSystem.IFS;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import ui.ImageViewer;
	import ui.LineDrawer;
	import ui.ProgressFilled;
	import ui.style.StylesCollector;
	import ui.Text;
	import ui.UIComponent;
	
	public class PlayerPanel extends UIComponent 
	{
		private var avatarView:ImageViewer;
		private var expProgress:ProgressFilled;
		private var infoText:Text;
		
		private var icons:Vector.<ScaleBitmap> = new Vector.<ScaleBitmap>;
		
		private var designLine11:LineDrawer;
		private var designLine12:LineDrawer;
		private var designLine13:LineDrawer;
		private var time:TimeView;
		
		[Inject]
		public var styles:StylesCollector;
		
		[Inject]
		public var vfs:IFS;
		
		public function PlayerPanel() 
		{
			inject(this);	
			super(null);
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			infoText = new Text(styles.getStyle('playerPanelInfoText'));
			time = new TimeView();
			
			avatarView = new ImageViewer(vfs.getFile("res/avatar.jpg").content, 100, 100, styles.getStyle("playerAvatar"));
			expProgress = new ProgressFilled(styles.getStyle("expProgress"));
			
			for (var i:int = 0; i < 5; i++)
			{
				var icon:ScaleBitmap = new ScaleBitmap(vfs.getFile("res/textures/ui/mainmenu/icon" + i + ".png").content);
				icon.scale9Grid = new Rectangle(1, 1, 1, 1);
				icon.setSize(50, 50);
				
				icons.push(icon);
			}
			
			designLine11 = new LineDrawer(styles.getStyle("mainMenu"));
			designLine12 = new LineDrawer(styles.getStyle("mainMenu"));
			designLine13 = new LineDrawer(styles.getStyle("mainMenu"));
		}
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
		
			addComponent(designLine11);
			addComponent(designLine12);
			addComponent(designLine13);
			
			addComponent(avatarView);
			addComponent(expProgress);
			addComponent(infoText);
			addComponent(time);
			
			for (var i:int = 0; i < icons.length; i++)
			{
				addChild(icons[i]);
			}
		}
		
		override protected function configureChildren():void 
		{
			super.configureChildren();
			
			infoText.text = "Asfel\n15 level"
		}
		
		override protected function layoutChildren():void 
		{
			super.layoutChildren();
			
			avatarView.y = 60;
			expProgress.y = avatarView.y + avatarView.height + 2;
			
			expProgress.x = avatarView.x = 20;
			
			for (var i:int = 0; i < icons.length; i++)
			{
				icons[i].x = 20;
				icons[i].y = expProgress.y + expProgress.height + 2 + (icons[i].height + 2) * i
			}
			
			designLine11.path.clear();
			designLine12.path.clear();
			designLine13.path.clear();
			
			designLine11.path.push(0, avatarView.y + 40, false);
			designLine11.path.push(240, avatarView.y + 40);
			designLine11.path.push(240, 0, false);
			
			designLine12.path.push(180, 0, false);
			designLine12.path.push(180, 240);
			designLine12.path.push(0, 240, false);
			
			designLine13.path.push(0, avatarView.y + avatarView.height - 20, false);
			designLine13.path.push(100, avatarView.y + avatarView.height - 20, false);
			designLine13.path.push(100, icons[icons.length-1].y + icons[icons.length-1].height + 20);
			designLine13.path.push(0, icons[icons.length - 1].y + icons[icons.length - 1].height + 20, false);
			
			infoText.x = avatarView.x + avatarView.width;
			infoText.y = avatarView.y + 40 - infoText.height;
			
			time.x = 20;
			time.y = 20;
		}
		
	}

}