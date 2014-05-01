package core.external
{
import core.fileSystem.*;
	import core.services.IFileService;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	public class LocalFileSystem implements IFS
	{
		private var _directoriesList:Directory;
		
		public var loadingService:IFileService;
		
		public function LocalFileSystem() 
		{
			
		}
		
		private function initialize():void 
		{
			
		}
		
		public function onScanComplete(e:Event):void
		{
			loadingService.addEventListener(Event.COMPLETE, onLoadComplete);
			loadingService.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			loadingService.loadFiles(directoriesList);
		}
		
		private function onLoadProgress(e:ProgressEvent):void 
		{
			broadcast('vfs', e);
		}
		
		private function onLoadComplete(e:Event):void 
		{
			trace('vfs ready');
			broadcast('vfs', e);
		}
		
		public function test():void
		{
			//testDir(directoriesList);
		}
		
		private function testDir(dir:Directory):void
		{
			trace(dir.name, dir.length)
			
			var item:* = dir.currentItem;
			for (var i:int = 0; i < dir.length; i++ )
			{
				if (item is Directory)
					testDir(item)
				else
					trace("\t" + dir.name+"/"+item);
					
				item = dir.nextItem;
			}
		}
		
		public function getFile(path:String):*
		{
			var subPath:Array = path.split('/');
			
			var file:* = directoriesList.getItem(subPath[0]);
			for (var i:int = 1; i < subPath.length; i++)
			{
				if (subPath[i].length == 0)
					continue;
					
				file = file.getItem(subPath[i]);
			}
			
			return file;
		}
		
		public function get directoriesList():Directory 
		{
			return _directoriesList;
		}
		
		public function set directoriesList(value:Directory):void 
		{
			_directoriesList = value;
		}
		
	}

}