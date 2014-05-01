package core.external.io 
{
	import flash.utils.ByteArray;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	/**
	 * ...
	 * @author Nikro
	 */
	public class StreamOperatorTest 
	{
		private var input:ByteArray;
		private var output:ByteArray;
		
		private var processor:StreamOperator;
		
		public function StreamOperatorTest() 
		{
			
		}
		
		[Before]
		public function before():void
		{
			input = new ByteArray();
			output = new ByteArray();
			craeteTestByteArray(input);
			
			processor = new StreamOperator();
		}
		
		private function craeteTestByteArray(input:ByteArray):void
		{
			//--header
			//packet full size
			input.writeInt(32);
			//packet type
			input.writeInt(12);
			//server time
			input.writeDouble(1234567890.123);
			
			input.position = 0;
			var size:int = input.length
			input.writeInt(size);
		}
		
		[Test]
		public function testHeaderSerialize():void
		{
			var size:int = input.length
			
			processor.addSerializer(new IntOperator());
			processor.addSerializer(new IntOperator());
			processor.addSerializer(new DoubleOperator());
			
			input.position = 0;
			assertThat('check buffer size', processor.serialize(input), equalTo(size));
			assertThat('check processor size', processor.readSize, equalTo(size));
			
			assertThat('check serialization value[0]', processor.value[0], equalTo(size));
			assertThat('check serialization value[1]', processor.value[1], equalTo(12));
			assertThat('check serialization value[2]', processor.value[2], equalTo(1234567890.123));
			//assertThat('check serialization value', processor.value, equalTo(1234));
		}
		
	
		[Test]
		public function testHeaderDeserialize():void
		{
			processor.addDeserializer(new IntOperator(16));
			processor.addDeserializer(new IntOperator(12));
			processor.addDeserializer(new DoubleOperator(1234567890.123));
			
			processor.input = [16, 12, 1234567890.123];
			
			assertThat('check buffer size', processor.deserialize(output), equalTo(16));
			assertThat('check processor size', processor.writeSize, equalTo(16));
			
			for (var i:int = 0; i < input.length; i++)
			{
				assertThat('check desirealization value', input[i], equalTo(output[i]));
			}
			
		}
		
	}

}