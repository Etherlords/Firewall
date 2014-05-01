package core.external
{
import core.fileSystem.*;
	import core.broadcasting.AbstractEventBroadcaster;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	/**
	 * @eventType	core.fileSystem.events.DirectoryEvent.DIRECTOEY_ADDED
	 */
	[Event(name = "directoryAdded", type = "core.fileSystem.events.DirectoryEvent")] 
	
	/**
	 * @eventType	core.fileSystem.events.FileEvent.FILE_ADDED
	 */
	[Event(name = "fileAdded", type = "core.fileSystem.events.FileEvent")] 
	
	/**
	 * @eventType	flash.events.Event.COMPLETE
	 */
	[Event(name = "complete", type = "flash.events.Event")] 
	
	
	public class VirtualDirectoryScaner extends AbstractEventBroadcaster
	{
		
		
		public var path:String;
		public var directoryRoot:Directory
		
		private var entry:int = 0;
		private var urlLoader:URLLoader;
		
		public function VirtualDirectoryScaner() 
		{
			
		}
		
		public function scan():void
		{
			urlLoader = new URLLoader(new URLRequest(path));
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			urlLoader.addEventListener(Event.COMPLETE, onLoaded);
			
			urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
		}
		
		private function onProgress(e:ProgressEvent):void 
		{
			broadcast(e);
		}
		
		private function onLoaded(e:Event):void 
		{
			var ba:ByteArray = urlLoader.data as ByteArray;
			_scan(ba, directoryRoot);
			directoryRoot = directoryRoot.currentItem;
			
			
			broadcast(new Event(Event.COMPLETE));
		}
		
		public function _scan(file:ByteArray, output:Directory):void
		{
			var type:int = file.readInt();
			var fsFile:IFile;
			
			if (type == 0)
				fsFile = scanDir(file)
			else
				fsFile = scanFile(file);
				
			
				
			output.addItem(fsFile.name, fsFile);
		}
		
		private function scanFile(file:ByteArray):IFile 
		{
			var name:String = file.readUTF();
			var path:String = file.readUTF();
			var nativePath:String = file.readUTF();
			var size:int = file.readInt();
			var nativeContent:ByteArray = new ByteArray();
			
			file.readBytes(nativeContent, 0, size);
			
			var fsFile:FsFile = new FsFile();
			fsFile.name = name;
			fsFile.path = path;
			fsFile.extension = fsFile.name.substr(fsFile.name.length - 3);
			fsFile.nativePath = nativePath;
			fsFile.nativeContent = nativeContent;
			
			return fsFile;
		}
		
		private function scanDir(file:ByteArray):IFile 
		{
			var name:String = file.readUTF();
			var path:String = file.readUTF();
			var nativePath:String = file.readUTF();
			var length:int = file.readInt();
			
			var dir:Directory = new Directory();
			dir.path = path;
			dir.nativePath = nativePath;
			dir.name = name;
			
			for (var i:int = 0; i < length; i++)
				_scan(file, dir);
			
			return dir;
			
		}
		
	}

}