package core.external
{
import core.fileSystem.*;

	public class FileSystem implements IFS 
	{
		
		public function FileSystem() 
		{
			
		}


        public function getFile(path:String):* {
            return null;
        }

        public function get directoriesList():Directory {
            return null;
        }

        public function set directoriesList(value:Directory):void {
        }
    }

}