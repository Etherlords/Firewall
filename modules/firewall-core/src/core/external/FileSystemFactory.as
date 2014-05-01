package core.external
{
import core.fileSystem.*;
	import core.fileSystem.events.DirectoryEvent;
	import core.fileSystem.events.FileEvent;
	import flash.filesystem.File;
	/**
	 * ...
	 * @author Nikro
	 */
	public class FileSystemFactory 
	{
		private var directoryInfo:Directory = new Directory();
		private var directoryScaner:DirectoryScaner = new DirectoryScaner();
		
		public function FileSystemFactory() 
		{
			initialize();
		}
		
		private function initialize():void 
		{
			directoryScaner.addEventListener(DirectoryEvent.DIRECTOEY_ADDED, trace);
			directoryScaner.addEventListener(FileEvent.FILE_ADDED, trace);
			
		}
		
		private function scan():void 
		{
			directoryScaner.nativePath = path;
			var rootDir:File = new File(path);
			directoryScaner.scan(rootDir, directoryInfo);
			
			directoryInfo = directoryInfo.nextItem;
		}
		
	}

}