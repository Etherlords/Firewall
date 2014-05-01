package gameui.mainmenu 
{
	import ui.scenes.AbstractScene;
	
	public class MainMenuScene extends AbstractScene 
	{
		private var mainMenuView:MainMenuView;
		
		public function MainMenuScene() 
		{
			super();
		}
		
		override public function initialize():void 
		{
			super.initialize();
			
			mainMenuView = new MainMenuView();
			sceneView = mainMenuView
			
			
		}
		
	}

}