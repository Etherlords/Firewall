package ui.style 
{
	import core.fileSystem.IFS;

	public class Style 
	{
		[Inject]
		public var vfs:IFS;
		
		protected var styles:Object = { };
		
		public function Style() 
		{
			inject(this);
		}
		
		public function overrideStyle(style:Style):void
		{
			for (var fieldName:String in style.styles)
				this.styles[fieldName] = style.styles[fieldName];
		}
		
		public function fillStyle(styles:Vector.<String>):void
		{
			var styleValueString:String
			var styleKey:String;
			var styleString:String;
			var stylesParts:Array;
			
			for (var i:int = 0; i < styles.length; i++)
			{
				styleString = styles[i];
				
				var splitterIndex:int = styleString.indexOf('=');
				
				styleKey = styleString.substr(0, splitterIndex);
				styleValueString = styleString.substr(splitterIndex + 1);
				
				this.styles[styleKey] = processStyleValue(styleValueString)
			}
		}
		
		public function applyStyle(objToApply:Object, styleKey:String, fieldName:String):void
		{
			if(fieldName in objToApply && styleKey in styles)
				objToApply[fieldName] = styles[styleKey];
		}
		
		private function processStyleValue(styleValueString:String):* 
		{
			var isLink:Boolean = styleValueString.charAt(0) == '@';
			
			if (isLink)
				return vfs.getFile(styleValueString.substr(1)).content;
			else
				return styleValueString;
		}
		
		public function getStyleElement(key:String):*
		{
			return styles[key];
		}
		
	}

}