package objectState 
{
	import avmplus.DescribeTypeJSON;
	import core.external.io.IDeserializer;
	import core.external.io.IntOperator;
	import core.external.io.ISerializer;
	import core.external.io.IStreamOperator;
	import core.external.io.StreamOperator;
	import core.external.io.UTFStringOperator;
	import flash.utils.ByteArray;
	
	public class ObjectState 
	{
		public static const describer:DescribeTypeJSON = new DescribeTypeJSON();
		
		private var streamOperator:StreamOperator = new StreamOperator();
		
		private var operatorsMap:Object = { };
		
		public function ObjectState() 
		{
			initialize();
		}
		
		private function initialize():void 
		{
			operatorsMap['Number'] = new IntOperator();
			operatorsMap['String'] = new UTFStringOperator();
		}
		
		public function readObject(stream:ByteArray, obj:Object):void
		{
			var i:int;
			var intOperator:IntOperator = new IntOperator();
			var strOperator:UTFStringOperator = new UTFStringOperator();
			
			var accessorsMap:Object = getAccessorsMap(obj);
			
			intOperator.serialize(stream);
			var fieldsCount:int = intOperator.value as int;
			
			var fieldsList:Vector.<String> = new Vector.<String>;
			var values:Vector.<Object> = new Vector.<Object>;
			
			for (i = 0; i < fieldsCount; i++)
			{
				strOperator.serialize(stream)
				fieldsList.push(strOperator.value);
			}
			
			for (i = 0; i < fieldsCount; i++)
			{
				var operator:ISerializer = operatorsMap[accessorsMap[fieldsList[i]]];
				operator.serialize(stream);
				values.push(operator.value);
			}
			
			trace('fieldList', fieldsList, 'values', values);
		}
		
		public function writeObject(obj:Object, fieldsList:Vector.<String>):ByteArray
		{
			var i:int;
			var fieldsCount:int = fieldsList.length;
			var values:Array = [fieldsCount];
			
			var accessorsMap:Object = getAccessorsMap(obj);
			
			streamOperator.addDeserializer(new IntOperator());
			
			for (i = 0; i < fieldsCount; i++)
			{
				streamOperator.addDeserializer(new UTFStringOperator());
				values.push(fieldsList[i]);
			}
			
			var key:String;
			for (i = 0; i < fieldsCount; i++)
			{
				key = fieldsList[i];
				streamOperator.addDeserializer(operatorsMap[accessorsMap[key]]);
				values.push(obj[key]);
			}
			
			var byteArray:ByteArray = new ByteArray();
			streamOperator.input = values;
			streamOperator.deserialize(byteArray)
			
			return byteArray;
		}
		
		private function getAccessorsMap(obj:Object):Object
		{
			var accessorsMap:Object = { };
			var accessors:Array = describer.getInstanceDescription(obj.constructor).traits.accessors;
			
			for (var i:int = 0; i < accessors.length; i++)
			{
				accessorsMap[accessors[i].name] = accessors[i].type;
			}
			
			return accessorsMap;
		}
		
	}

}