package ui.floderViewer 
{
	import core.fileSystem.Directory;
	import core.fileSystem.FsFile;
	import core.fileSystem.IFS;
	import flash.display.BitmapData;

	public class IconsFactory 
	{
		[Inject]
		public var vfs:IFS;
		
		public function IconsFactory() 
		{
			inject(this);
		}
		
		public function getIcon(file:*):BitmapData
		{
			if (file is Directory)
				return vfs.getFile('res/textures/ui/floders/standart.png').content;
			else if (file is FsFile && ((file as FsFile).extension == 'png' || (file as FsFile).extension == 'jpg'))
			{
				return (file as FsFile).content;
			}
			else
			{
				return vfs.getFile('res/textures/ui/floders/png.png').content;
			}
		}
		
	}

}