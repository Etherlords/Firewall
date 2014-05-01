package
{
	import cameracontrollers.GameCamera;
	import core.ioc.Context;
	import display.builders.MD5ModelBuilder;
	import flash.display.Stage;
	import geom.PathMathematic;
	import net.ConnectionManager;
	import resources.VFSManager;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class ApplicationBootstrap
	{
		
		public function ApplicationBootstrap()
		{
		
		}
		
		
		public function launch(stage:Stage):void
		{
			var context:Context = Context.instance;
			context.init();
			
			
			addToContext(new WorldTimeController());
			addToContext(new GameCamera(stage));
			addToContext(new PathMathematic());
			addToContext(new VFSManager());
			
			netConfig();
			awayConfig();
		}
		
		public function netConfig():void
		{
			//addToContext(new PacketsBuilder());
			//addToContext(new ConnectionManager());
		}
		
		public function awayConfig():void
		{
			addToContext(new MD5ModelBuilder());
		}
	
	}

}