package core.external.io 
{
	import flash.utils.ByteArray;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	/**
	 * ...
	 * @author Nikro
	 */
	public class UTFStringOperatorTest 
	{
		private var input:ByteArray;
		private var output:ByteArray;
		private var processor:UTFStringOperator;
		
		public function UTFStringOperatorTest() 
		{
			
		}
		
		[Before]
		public function before():void
		{
			input = new ByteArray();
			output = new ByteArray();
			
			processor = new UTFStringOperator();
		}
		
		[Test]
		public function testSerialize():void
		{
			var str:String = 'blah bloh blah, then blah blah blah';
			input.writeUTF(str);
			input.position = 0;
			
			assertThat('check buffer size', processor.serialize(input), equalTo(processor.calculateReadSize()));
			assertThat('check serialization value', processor.value, equalTo(str));
		}
		
		[Test]
		public function testDeserialize():void
		{
			var str:String = 'blah bloh blah, then blah blah blah';
			processor.value = str;
			var readedSize:int = processor.deserialize(output);
			output.position = 0;
			
			assertThat('check buffer size', readedSize, equalTo(processor.calculateReadSize()));
			assertThat('check desirialization value', output.readUTF(), equalTo(str));
		}
		
	}

}