package io
{
	import core.external.io.FileChangeChecker;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	/**
	 * ...
	 * @author Nikro
	 */
	public class FileChangeCheckerTest 
	{
		private var file:File = File.createTempFile();// .resolvePath('testFile.txt');
		public function FileChangeCheckerTest() 
		{
			
		}
		
		[Test(async)]
		public function test():void
		{
			var checker:FileChangeChecker = new FileChangeChecker();
			checker.path = file.nativePath
			
			var asyncTestHandler:Function = Async.asyncHandler( this, handleVerifyProperty, 1000, checker, handleEventNeverOccurred );
			checker.addEventListener(Event.CHANGE, asyncTestHandler);
			
			updateFile();
			checker.check();
		}
		
		protected function handleEventNeverOccurred( passThroughData:Object ):void 
		{
			fail('Checker never answer');
		}
		
		private function handleVerifyProperty( event:Event, passThroughData:Object ):void
		{
			var checker:FileChangeChecker = passThroughData as FileChangeChecker;
		}
		
		private function updateFile():void
		{
			var stream:FileStream = new FileStream();
			
			stream.open(file, FileMode.WRITE);
			stream.writeUTF("this is common utf line");
			stream.close();
		}
		
	}

}