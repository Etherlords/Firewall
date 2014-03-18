package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PNGEncoderOptions;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class TTTTt extends Sprite 
	{
		[Embed(source = "../bin/flah.png")]
		private var cls:Class;
		private var bmp:Bitmap = new cls();
		private var fa:File;
		private var ba:ByteArray;
		
		public function TTTTt() 
		{
			addChild(bmp);
			
			var bitmap:BitmapData = bmp.bitmapData;
			
			for (var i:int = 0; i < bitmap.width; i++)
			{
				for (var j:int = 0; j < bitmap.height; j++)
				{
					var px:uint = bitmap.getPixel(i, j);
					//trace(px.toString(16));
					if (px > 0xCCCCCC)
						bitmap.setPixel32(i, j, 0x0);
				}
			}
			
			ba = new ByteArray();
			bitmap.encode(bitmap.rect, new PNGEncoderOptions(false), ba);
			
			fa = new File();
			fa.browseForSave('save' );
			fa.addEventListener(Event.SELECT, onSelect);
			
			
		}
		
		private function onSelect(e:Event):void 
		{
			var stream:FileStream = new FileStream();
			stream.open(fa, FileMode.WRITE);
			
			ba.position = 0;
			stream.writeBytes(ba, 0, ba.length);
		}
		
	
		
	}

}