package objectState 
{
	
	public class ObjectFieldChecker 
	{
		private var objToCheck:Object;
		private var valuesList:Vector.<String>;
		
		private var defaultValues:Object = { };
		
		public function ObjectFieldChecker(objToCheck:Object, valuesList:Vector.<String>) 
		{
			this.valuesList = valuesList;
			this.objToCheck = objToCheck;
			
			getDefaultValues();
		}
		
		private function getDefaultValues():void 
		{
			var key:String = ''
			for (var i:int = 0; i < valuesList.length; i++)
			{
				key = valuesList[i];
				defaultValues[key] = objToCheck[key];
			}
		}
		
		public function checkObject():Vector.<String>
		{
			var changeFieldsList:Vector.<String> = new Vector.<String>;
			
			var key:String = ''
			for (var i:int = 0; i < valuesList.length; i++)
			{
				key = valuesList[i];
				
				if (objToCheck[key] != defaultValues[key])
					changeFieldsList.push(key);
			}
			
			return changeFieldsList;
		}
		
	}

}