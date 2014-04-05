package gameui.gamescene 
{
	import ui.scenes.AbstractScene;
	
	public class GameScene extends AbstractScene 
	{
		private var gameSceneView:GameSceneView;
		
		public function GameScene() 
		{
			super();
		}
		
		override public function initialize():void 
		{
			super.initialize();
			
			gameSceneView = new GameSceneView();
			sceneView = gameSceneView
			
			
		}
		
	}

}