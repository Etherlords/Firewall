package  
{
	import core.codec.FileDecoderFactory;
	import core.external.io.DesktopFileLoader;
	import core.fileSystem.DirectoryScaner;
	import core.fileSystem.LocalFileSystem;
	import core.fileSystem.VirtualDirectoryScaner;
	import core.services.FileLoadingService;
	import display.ui.DisplayManager;
	import gameui.preloadScreen.PreloaderScene;
	import geom.PathMathematic;
	import ui.ComponentsScene;
	import ui.CompSceneController;

	public class ComponentsClassesRef 
	{
		
		public static var displayManager:DisplayManager;
		public static var pathMathematic:PathMathematic;
		public static var localFileSystem:LocalFileSystem;
		
		public static var fileDecoderFactory:FileDecoderFactory;
		public static var fileLoadingService :FileLoadingService;
		public static var desktopFileLoader  :DesktopFileLoader;
		
		public static var scenesController:CompSceneController;
		public static var componentsScene:ComponentsScene;
		public static var preloaderScene:PreloaderScene;
		
		public static var virtdirscan:VirtualDirectoryScaner;
		public static var dir:DirectoryScaner;
		
	}

}