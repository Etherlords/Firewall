package ui.style 
{
	import core.collections.SimpleMap;
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;

	public class StylesCollector 
	{
		private var styles:SimpleMap = new SimpleMap();
		
		public function StylesCollector() 
		{
			defaultStyles();
			
			//describe("vfs", Event.COMPLETE, onVfsComplete);
		}
		
		private function onVfsComplete(e:Event):void 
		{
			currentStyles();
		}
		
		private function defaultStyles():void 
		{
			var preloadProgressStyle:Style = new Style();
			preloadProgressStyle.fillStyle(new < String > ["background=@background", "progress=@progress", "width=522"]);
			
			addStyle('preloadProgress', preloadProgressStyle);
		}
		
		public function currentStyles():void
		{
			var preloadProgressStyle:Style = new Style();
			preloadProgressStyle.fillStyle(new < String > ["frame=@res/textures/ui/frame.png"]);
			
			addStyle('autorisation', preloadProgressStyle);
			
			
			var newsScrolStyle:Style = new Style();
			newsScrolStyle.fillStyle(new <String>[
				"background=@res/textures/ui/newsPanel/scroll/background.png", "slider=@res/textures/ui/newsPanel/scroll/slider.png",
			]);
			
			addStyle("newsScrolStyle", newsScrolStyle);
			
			var mainMenu:Style = new Style();
			mainMenu.fillStyle(new < String > [
													"frame=@res/textures/ui/designframe.png", "anchorn=@res/textures/ui/lineAnchorn.png",
													"lineColor=0x949595", "lineWidht=1"
												]);
			
			addStyle('mainMenu', mainMenu);
			
			var mainMenuButton:Style = new Style();
			mainMenuButton.fillStyle(new < String > [
														"normal=@res/textures/ui/mainmenu/button/normal.png", "selected=@res/textures/ui/mainmenu/button/selected.png",
														"textSize=12", "font=Vrinda", "textColor=0xFFFFFF", "textAlign="+TextFormatAlign.CENTER
													]);
			
			addStyle('mainMenuButton', mainMenuButton);
			
			var newsButton:Style = new Style();
			newsButton.fillStyle(new < String > [
														"normal=@res/textures/ui/newsPanel/button/normal.png", "selected=@res/textures/ui/newsPanel/button/selected.png",
														"textSize=12", "font=Vrinda", "textColor=0xFFFFFF", "textAlign="+TextFormatAlign.CENTER, "width=120", "height=20"
													]);
													
			addStyle('newsButton', newsButton);
			
			
			var menuPanelLogo:Style = new Style();
			menuPanelLogo.fillStyle(new < String > [
														"normal=@res/textures/ui/mainmenu/button/selected.png", "selected=@res/textures/ui/mainmenu/button/selected.png",
														"textSize=12", "font=Vrinda", "textColor=0xFFFFFF", "textAlign="+TextFormatAlign.CENTER
													]);
			
			addStyle('menuPanelLogo', menuPanelLogo);
			
			
			var machFindView:Style = new Style();
			machFindView.fillStyle(new < String > [
														"background=@res/textures/ui/mainmenu/button/selected.png",
														"textSize=12", "font=Vrinda", "textColor=0xFFFFFF", "textAlign="+TextFormatAlign.CENTER
													]);
			
			addStyle('machFindView', machFindView);
			
			
			var playerAvatar:Style = new Style();
			playerAvatar.fillStyle(new < String > [
														"chrome=@res/textures/ui/playerAvatar/chrome.png",
														"width=100", "height=100", "isUseChrome=true"
													]);
			
			addStyle('playerAvatar', playerAvatar);
			
			var expProgress:Style = new Style();
			expProgress.fillStyle(new < String > ["background=@res/textures/ui/exp/background.png", "progress=@res/textures/ui/exp/progress.png", "width=100", "height=15"]);
			
			addStyle('expProgress', expProgress);
			
			
			textStyles();
		}
		
		private function textStyles():void
		{
			var standartText:Style = new Style();
			standartText.fillStyle(new < String >
										[
											"textSize=12", "font=Vrinda", "textColor=0xFFFFFF",
											"shaprness=-400", "gridFitType=" + GridFitType.SUBPIXEL,
											"antiAliasType=" + AntiAliasType.ADVANCED
											
											
										]);
										
										//"textAlign="+TextFormatAlign.CENTER, "background=@res/textures/ui/frame.png"
			
			var playerPanelInfoText:Style = new Style();
			playerPanelInfoText.overrideStyle(standartText);
			playerPanelInfoText.fillStyle(new < String > ["textSize=18", "leading=-5", 
														"autoSize=" + TextFieldAutoSize.LEFT]);
														
			var componentsSceneText:Style = new Style();
			componentsSceneText.overrideStyle(standartText);
			componentsSceneText.fillStyle(new < String > [ 
														//"textAlign="+TextFormatAlign.LEFT,
														"background=@res/textures/ui/frame.png",
														"height=25"
														]);
														
														
			var newsTextFormat:Style = new Style();
			newsTextFormat.fillStyle(new < String >
										[
											"textSize=18", "font=Courier New", "textColor=0xFFFFFF",
											"shaprness=-400", "gridFitType=" + GridFitType.SUBPIXEL,
											"antiAliasType=" + AntiAliasType.ADVANCED,
											"textAlign="+TextFormatAlign.LEFT,
											"background=@res/textures/ui/newsPanel/newbackground.png"
										]);
			
			addStyle('newsTextFormat', newsTextFormat);
			addStyle('standartText', standartText);
			addStyle('playerPanelInfoText', playerPanelInfoText);
			
			addStyle('componentsSceneText', componentsSceneText);
		}
		
		public function addStyle(name:String, style:Style):void
		{
			styles.addItem(name, style);
		}
		
		public function getStyle(name:String):Style
		{
			return styles.getItem(name);
		}
	}

}