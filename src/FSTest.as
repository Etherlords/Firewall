package  
{
	import core.fileSystem.Directory;
	import core.fileSystem.DirectoryScaner;
	import core.fileSystem.LocalFyleSystem;
	import flash.display.Sprite;
	import flash.filesystem.File;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class FSTest extends Sprite 
	{
		
		public function FSTest() 
		{
			super();
			
			
			//var dirScaner:DirectoryScaner = new DirectoryScaner();
			
			//var root:Directory = new Directory();
			//var f:File = new File("C:/git/Firewall/res/");
			//dirScaner.nativePath = "C:/git/Firewall/res/"
			//dirScaner.scan(f, root);
			
			var fs:LocalFyleSystem = new LocalFyleSystem("C:/git/Firewall/res/");
			var file:* = fs.getFile("textures/T_010_Metal_N.png");
			
			trace(file);
			//testDir(root);
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
		
	}

}