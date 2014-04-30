package  
{
	import core.utils.Cast;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	/**
	 * ...
	 * @author Nikro
	 */
	public class CastTest 
	{
		[Test]
		public function testCastInt():void
		{
			var s:String = '1234567'
			var s2:String = '-1234567';
			
			var o:Object = Cast.cast(s);
			var o2:Object = Cast.cast(s2);
			
			assertThat('check int type', o is int);
			assertThat('check int type', o2 is int);
			
			assertThat('check positive int', o, equalTo(1234567));
			assertThat('check negative int', o2, equalTo(-1234567));
		}
		
		[Test]
		public function testCastNumber():void
		{
			var s:String = '1234567.1234567'
			var s2:String = '-1234567.1234567';
			var s3:String = '-1s234567-1234d567';
			
			var o:Object = Cast.cast(s);
			var o2:Object = Cast.cast(s2);
			var o3:Object = Cast.cast(s3);
			
			assertThat('check number type', o is Number);
			assertThat('check number2 type', o2 is Number);
			//assertThat('check number3 type', !(o3 is Number));
			
			assertThat('check positive Number', o, equalTo(1234567.1234567));
			assertThat('check negative Number', o2, equalTo(-1234567.1234567));
			assertThat('check negative Number', o3, not(equalTo(-1234567.1234567)));
		}
		
	}

}