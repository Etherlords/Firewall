package core.external.io  
{
	import core.external.io.DoubleOperator;
	import core.external.io.IntOperator;
	import core.external.io.StreamOperator;
	import core.external.io.UTFStringOperator;
	import flash.utils.ByteArray;
	import core.net.packets.BytePacket;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class DataReaderTest 
	{
		private var input:ByteArray;
		private var header:StreamOperator;
		private var body:StreamOperator;
		private var intOp:IntOperator;
		private var doubleOp:DoubleOperator;
		private var utfStringOp:UTFStringOperator;
		
		[Before]
		public function setUp():void
		{
			input = new ByteArray();
			
			intOp = new IntOperator();
			doubleOp = new DoubleOperator();
			utfStringOp = new UTFStringOperator();
			
			initilizeHeader();
			initilizeBody();
		}
		
		private function initilizeBody():void
		{
			body = new StreamOperator();
			body.addSerializer(intOp);
			body.addSerializer(utfStringOp);
			
			body.addDeserializer(intOp);
			body.addDeserializer(utfStringOp);
		}
		
		private function initilizeHeader():void
		{
			header = new StreamOperator();
			header.addSerializer(intOp);
			header.addSerializer(intOp);
			header.addSerializer(doubleOp);
			
			header.addDeserializer(intOp);
			header.addDeserializer(intOp);
			header.addDeserializer(doubleOp);
		}
		
		[Test]
		public function testReadData():void
		{
			var packet:BytePacket = new BytePacket();
			packet.type = 1;
			packet.headerOperator = header;
			packet.streamOperator = body;
			
			packet.input = [123, 'is it test? yes just test'];
			
			packet.source = input;
			
			//test multiple packets read/write
			packet.write();
			packet.write();
			
			var size:int = 4 + utfSizeOf(packet.input[1]);
			
			//var dataReader:DataReader = new DataReader();
			//dataReader.addPacket(packet);
			
			//input.position = 0;
			//dataReader.read(input);
			
			//assertThat('check data reader output', packet.input.concat(packet.input), equalTo(packet.output));
		}
		
	}

}