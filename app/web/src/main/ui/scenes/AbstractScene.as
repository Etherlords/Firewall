package ui.scenes 
{
	import ui.UIComponent;
	import ui.UIContainer;

	public class AbstractScene
	{
		private var initialized:Boolean;
		public var sceneId:String;
		public var sceneView:UIComponent;
		
		public function AbstractScene() 
		{
			
		}
		
		public function initialize():void 
		{
			if (initialized)
				return;
				
			initialized = true;
			sceneView = new UIContainer();
		}
		
		
	}

}