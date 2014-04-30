package sample 
{
	import org.hamcrest.assertThat;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	/**
	 * ...
	 * @author Nikro
	 */
	public class SampleTest 
	{
		
		public function SampleTest() 
		{
			
		}
		
		[Before]
		public function before():void
		{
			
		}
		
		[Test]
		public function test():void
		{
			var test1:int = 1;
			var test2:int = 2;
			
			assertThat("just check", test1, not(equalTo(test2)));
			assertThat("check 2", test1, equalTo(1));
		}
		
		
		
	}

}