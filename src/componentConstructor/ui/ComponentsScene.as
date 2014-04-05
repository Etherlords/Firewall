package ui 
{
	import core.fileSystem.Directory;
	import core.fileSystem.FsFile;
	import core.fileSystem.IFile;
	import core.fileSystem.IFS;
	import core.fileSystem.LocalFileSystem;
	import core.fileSystem.VirtualDirectoryScaner;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import ui.scenes.AbstractScene;
	
	public class ComponentsScene extends AbstractScene 
	{
		private var componentsView:ComponentsSceneView;
		
		[Inject]
		public var vfs:IFS;
		
		
		
		
		public function ComponentsScene() 
		{
			super();
			
			
		}
		
		override public function initialize():void 
		{
			super.initialize();
			
			inject(this);
			
			componentsView = new ComponentsSceneView();
			sceneView = componentsView;
			
			componentsView.saveButton.addEventListener(MouseEvent.MOUSE_DOWN, onSave);
		}
		
		private function onSave(e:MouseEvent):void 
		{
			var virtual:VirtualDirectoryScaner = new VirtualDirectoryScaner();
			
			saveFsFile();
		}
		
		public function saveFsFile():void
		{
			
			var file:File = File.documentsDirectory.resolvePath("vfs/fs.fs")
			var fileStream:FileStream = new FileStream();
			
			var ba:ByteArray = new ByteArray();
			var sizes:ByteArray = new ByteArray();
			
			sizes.writeUTF("VFSFILE");
			saveDirs(ba, sizes, vfs.directoriesList.currentItem);
			sizes.writeBytes(ba);
			
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeBytes(sizes);
		}
		
		private function saveDirs(ba:ByteArray, sizes:ByteArray,  dir:Directory):void
		{
			var item:IFile = dir.currentItem;
			
			ba.writeInt(0);
			ba.writeUTF(dir.name);
			ba.writeUTF(dir.path);
			ba.writeUTF(dir.nativePath);
			ba.writeInt(dir.length);
			
			for (var i:int = 0; i < dir.length; i++ )
			{
				if (!item)
					continue;
					
				if (item is Directory)
					saveDirs(ba, sizes, item as Directory)
				else
				{
					ba.writeInt(1);
					ba.writeUTF((item as FsFile).name);
					ba.writeUTF((item as FsFile).path);
					ba.writeUTF((item as FsFile).nativePath);
					ba.writeInt((item as FsFile).nativeContent.length);
					ba.writeBytes((item as FsFile).nativeContent);
				}
					
				item = dir.nextItem;
			}
			
			
		}
		
	}

}