package  
{

	import core.external.io.DesktopFileLoader;
	import core.fileSystem.Directory;
	import core.fileSystem.external.DirectoryScaner;
	import core.fileSystem.external.LocalFileSystem;
	import core.fileSystem.external.VirtualDirectoryScaner;
	import core.services.FileDecodeService;
	import core.services.FileLoadingService;
	import display.ui.DisplayManager;
	import gameui.autorisation.AutorisationScene;
	import gameui.gamescene.GameScene;
	import gameui.hangar.HangarScene;
	import gameui.mainmenu.MainMenuScene;
	import gameui.preloadScreen.PreloaderScene;
	import gameui.ScenesController;

import geom.PathMathematic;

public class ClassesRef
	{
		public static var textContext:TestContext;
		
		public static var directory:Directory;
		public static var directoryScaner:DirectoryScaner;
		public static var virtualDirectoryScaner:VirtualDirectoryScaner;
		public static var localFileSystem:LocalFileSystem;
		
		public static var desktopFileLoader:DesktopFileLoader;
		
		public static var _FileLoadingService:FileLoadingService;
		public static var _FileDecodingService:FileDecodeService;
			
		public static var _DisplayManager:DisplayManager;
		
		public static var _GameScene:GameScene;
		
		public static var _WorlTime:WorldTimeController;
		public static var pathMathematic:PathMathematic;

		public static var preloaderScene:PreloaderScene;
		public static var autorisationScene:AutorisationScene;
		public static var mainMenuScene:MainMenuScene;
		public static var hangarScene:HangarScene;
		
		public static var scenesController:ScenesController;
	}

}