package gameui 
{
	import core.fileSystem.IFS;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import ui.Button;
	import ui.LineDrawer;
	import ui.LinePath;
	import ui.ScrollBar;
	import ui.style.Style;
	import ui.style.StylesCollector;
	import ui.Text;
	import ui.TextWidthBackground;
	import ui.UIComponent;
	
	public class NewsPanel extends UIComponent 
	{
		public var backgroundPattern:BitmapData;
		
		private var borderLine:LineDrawer;
		private var dateBorder:LineDrawer;
		private var titleBorder:LineDrawer;
		
		private var runnerTextBorder1:LineDrawer;
		private var runnerTextBorder2:LineDrawer;
		
		private var newBorder1:LineDrawer;
		private var newBorder2:LineDrawer;
		
		private var background:ScaleBitmap;
		private var newsBackground:ScaleBitmap;
		
		private var dateText:TextWidthBackground;
		private var titleText:TextWidthBackground;
		private var runnerLineText:TextWidthBackground;
		
		private var newButtons:Vector.<Button> = new Vector.<Button>;
		private var scrollBar:ScrollBar;
		
		[Inject]
		public var styles:StylesCollector;
		
		[Inject]
		public var vfs:IFS;
		
		public function NewsPanel(style:Style=null) 
		{
			inject(this);
			super(style);
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			scrollBar = new ScrollBar(100, 0, 200, styles.getStyle("newsScrolStyle"));
			
			background = new ScaleBitmap(vfs.getFile("res/textures/ui/newsPanel/background.png").content);
			newsBackground = new ScaleBitmap(vfs.getFile("res/textures/ui/newsPanel/newbackground.png").content);
			
			dateText = new TextWidthBackground(styles.getStyle("newsTextFormat"))
			titleText = new TextWidthBackground(styles.getStyle("newsTextFormat"))
			runnerLineText = new TextWidthBackground(styles.getStyle("newsTextFormat"))
			
			borderLine = new LineDrawer(null, true, styles.getStyle("mainMenu"));
			dateBorder = new LineDrawer(null, true, styles.getStyle("mainMenu"));
			titleBorder = new LineDrawer(null, true, styles.getStyle("mainMenu"));
			runnerTextBorder1 = new LineDrawer(null, true, styles.getStyle("mainMenu"));
			runnerTextBorder2 = new LineDrawer(null, true, styles.getStyle("mainMenu"));
			newBorder1 = new LineDrawer(null, false, styles.getStyle("mainMenu"));
			newBorder2 = new LineDrawer(null, false, styles.getStyle("mainMenu"));
			
			for (var i:int = 0; i < 6; i++)
			{
				newButtons.push(new Button(styles.getStyle("newsButton")));
				newButtons[i].width = 120;
				newButtons[i].height = 20;
			}
		}
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			addChild(background);
			addChild(newsBackground);
			
			addComponent(dateText);
			addComponent(titleText);
			addComponent(runnerLineText);
			
			addComponent(borderLine);
			addComponent(dateBorder);
			addComponent(titleBorder);
			
			addComponent(runnerTextBorder1);
			addComponent(runnerTextBorder2);
			
			addComponent(newBorder1);
			addComponent(newBorder2);
			
			addComponent(scrollBar);
			
			for (var i:int = 0; i < newButtons.length; i++)
			{
				addComponent(newButtons[i]);
			}
		}
		
		override protected function configureChildren():void 
		{
			super.configureChildren();
			
			background.scale9Grid = new Rectangle(1, 1, 1, 1);
			background.setSize(518, 310); 
			
			fillBorder(0, 0, 560, 350, borderLine.path);
			
			newsBackground.setSize(300, 200);
			scrollBar.size = 200;
			scrollBar.pageSize = 1000;
			
			dateText.width = 100;
			dateText.height = 20;
			
			titleText.width = 200;
			titleText.height = 20;
			
			runnerLineText.width = 500;
			runnerLineText.height = 20;
			
			fillBorder(0, 0, dateText.width, dateText.height, dateBorder.path);
			fillBorder(0, 0, titleText.width, titleText.height, titleBorder.path);
			
			dateText.text = getDate();
			titleText.text = "Default";
			
			newBorder1.path.push(0, newsBackground.height / 1.8);
			newBorder1.path.push(0, newsBackground.height);
			newBorder1.path.push(newsBackground.width / 3, newsBackground.height);
			
			newBorder2.path.push(newsBackground.width / 3 * 2, 0);
			newBorder2.path.push(newsBackground.width, 0)
			newBorder2.path.push(newsBackground.width, newsBackground.height / 1.8);
			
			runnerTextBorder1.path.push(0, 0);
			runnerTextBorder1.path.push(0, runnerLineText.height);
			
			runnerTextBorder2.path.push(runnerLineText.width, 0);
			runnerTextBorder2.path.push(runnerLineText.width, runnerLineText.height);
		}
		
		private function getDate():String
		{
			var d:Date = new Date();
			
			return d.getMonth() + 1 + '.' + d.getDate() + '.' + d.getUTCFullYear();
		}
		
		override protected function layoutChildren():void 
		{
			super.layoutChildren();
			
			background.x = 20;
			background.y = 20;
			
			dateText.x = background.x + 10;
			dateText.y = background.y + 10;
			
			titleText.x = background.x + 10;
			titleText.y = dateText.y + dateText.height + 10;
			
			newsBackground.x = background.x + 10;
			newsBackground.y = titleText.height + titleText.y + 10;
			
			runnerLineText.x = background.x + 10;
			runnerLineText.y = newsBackground.height + newsBackground.y + 10;
			
			runnerTextBorder1.x = runnerLineText.x;
			runnerTextBorder1.y = runnerLineText.y;
			
			runnerTextBorder2.x = runnerLineText.x;
			runnerTextBorder2.y = runnerLineText.y;
			
			newBorder1.x = newsBackground.x;
			newBorder1.y = newsBackground.y;
			
			newBorder2.x = newsBackground.x;
			newBorder2.y = newsBackground.y;
			
			dateBorder.x = dateText.x;
			dateBorder.y = dateText.y;
			
			titleBorder.x = titleText.x;
			titleBorder.y = titleText.y;
			
			scrollBar.x = newsBackground.width + newsBackground.x + 15;
			scrollBar.y = newsBackground.y;
			
			for (var i:int = 0; i < newButtons.length; i++)
			{
				newButtons[i].x = background.x + background.width - newButtons[i].width - 10;
				newButtons[i].y = background.y + 10 + (newButtons[i].height + 10) * i;
			}
		}
		
		private function fillBorder(x:Number, y:Number, w:Number, h:Number, path:LinePath):void
		{
			path.clear();
			path.push(x, y);
			path.push(w, y);
			path.push(w, h);
			path.push(x, h);
		}
		
	}

}