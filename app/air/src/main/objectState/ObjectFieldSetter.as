package objectState 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class ObjectFieldSetter 
	{
		private var field:String;
		private var recipient:Object;
		private var donor:Object;
		
		public function ObjectFieldSetter(donor:Object, recipient:Object, field:String) 
		{
			this.donor = donor;
			this.recipient = recipient;
			this.field = field;
		}
		
		public function execute():void
		{
			recipient[field] = donor[field];
		}
		
	}

}