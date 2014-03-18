package  
{
	import core.fileSystem.Directory;
	import core.fileSystem.DirectoryScaner;
	import core.fileSystem.LocalFileSystem;
	import core.services.FileLoadingService;
	import display.ui.DisplayManager;
	
	import geom.PathMathematic;
	public class ClassReference 
	{
		public static var textContext:TestContext;
		
		public static var _Directory:Directory;
		public static var _DirectoryScaner:DirectoryScaner;
		public static var _LocalFyleSystem:LocalFileSystem;
		
		public static var _FileLoadingService:FileLoadingService;
			
		public static var _DisplayManager:DisplayManager;
		
		public static var _GameScene:GameScene;
		
		public static var _WorlTime:WorldTimeController
		public static var _PathMath:PathMathematic;
	}

}