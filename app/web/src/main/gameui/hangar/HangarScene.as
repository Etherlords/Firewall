package gameui.hangar 
{
	import ui.scenes.AbstractScene;
	
	public class HangarScene extends AbstractScene 
	{
		private var hangarView:HangarView;
		
		public function HangarScene() 
		{
			super();
		}
		
		override public function initialize():void 
		{
			super.initialize();
			
			hangarView = new HangarView();
			sceneView = hangarView
		}
		
	}

}