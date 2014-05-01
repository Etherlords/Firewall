package core.external.io 
{
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	/**
	 * ...
	 * @author Nikro
	 */
	public class PointTest 
	{
		private var input:ByteArray;
		private var output:ByteArray;
		private var processor:PointOperator;
		
		public function PointTest() 
		{
			
		}
		
		[Before]
		public function before():void
		{
			input = new ByteArray();
			output = new ByteArray();
			
			processor = new PointOperator();
		}
		
		[Test]
		public function testSerialize():void
		{
			input.writeDouble(1234.1234);
			input.writeDouble(4321.4321);
			input.position = 0;
			
			var testPoint:Point = new Point();
			processor.value = testPoint;
			
			assertThat('check buffer size', processor.serialize(input), equalTo(TypesSize.POINT_SIZE));
			assertThat('check serialization value.x', testPoint.x, equalTo(1234.1234));
			assertThat('check serialization value.y', testPoint.y, equalTo(4321.4321));
			
		}
		
		[Test]
		public function testDeserialize():void
		{
			processor.value = new Point(4321.4321, 1234.1234);
			
			assertThat('check buffer size', processor.deserialize(output), equalTo(TypesSize.POINT_SIZE));
			output.position = 0;
			
			assertThat('check serialization value.x', output.readDouble(), equalTo(4321.4321));
			assertThat('check serialization value.y', output.readDouble(), equalTo(1234.1234));
		}
		
	}

}