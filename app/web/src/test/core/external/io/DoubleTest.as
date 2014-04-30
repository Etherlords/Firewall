package core.external.io 
{
	import flash.utils.ByteArray;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	/**
	 * ...
	 * @author Nikro
	 */
	public class DoubleTest 
	{
		private var input:ByteArray;
		private var output:ByteArray;
		private var processor:DoubleOperator;
		
		public function DoubleTest() 
		{
			
		}
		
		[Before]
		public function before():void
		{
			input = new ByteArray();
			output = new ByteArray();
			
			processor = new DoubleOperator();
		}
		
		[Test]
		public function testSerialize():void
		{
			input.writeDouble(1234.1234);
			input.position = 0;
			
			assertThat('check buffer size', processor.serialize(input), equalTo(TypesSize.DOUBLE_SIZE));
			assertThat('check serialization value', processor.value, equalTo(1234.1234));
		}
		
		[Test]
		public function testDeserialize():void
		{
			processor.value = 4321.4321;
			var readedSize:int = processor.deserialize(output);
			output.position = 0;
			
			assertThat('check buffer size', readedSize, equalTo(TypesSize.DOUBLE_SIZE));
			assertThat('check desirialization value', output.readDouble(), equalTo(4321.4321));
		}
		
	}

}