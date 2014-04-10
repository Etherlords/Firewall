
package  {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;	

	public class ScaleBitmap extends Bitmap {

		// ------------------------------------------------
		//
		// ---o properties
		//
		// ------------------------------------------------

		protected var _originalBitmap : BitmapData;
		protected var _scale9Grid : Rectangle = null;

		// ------------------------------------------------
		//
		// ---o constructor
		//
		// ------------------------------------------------

		
		function ScaleBitmap(bmpData : BitmapData = null, pixelSnapping : String = "auto", smoothing : Boolean = false) {
			
			_originalBitmap = bmpData.clone();
			super(_originalBitmap.clone(), pixelSnapping, smoothing);
		}

		// ------------------------------------------------
		//
		// ---o public methods
		//
		// ------------------------------------------------
		
		/**
		 * setter bitmapData
		 */
		override public function set bitmapData(bmpData : BitmapData) : void 
		{
			if (_originalBitmap)
				_originalBitmap.dispose();
				
			_originalBitmap = bmpData.clone();
			
			if (_scale9Grid != null) {
				if (!validGrid(_scale9Grid)) {
					_scale9Grid = null;
				}
				setSize(bmpData.width, bmpData.height);
			} else {
				assignBitmapData(_originalBitmap.clone());
			}
		} 

		/**
		 * setter width
		 */
		override public function set width(w : Number) : void {
			if (w != width) {
				setSize(w, height);
			}
		}

		/**
		 * setter height
		 */
		override public function set height(h : Number) : void {
			if (h != height) {
				setSize(width, h);
			}
		}

		/**
		 * set scale9Grid
		 */
		override public function set scale9Grid(r : Rectangle) : void {
			// Check if the given grid is different from the current one
			if ((_scale9Grid == null && r != null) || (_scale9Grid != null && !_scale9Grid.equals(r))) {
				if (r == null) {
					// If deleting scalee9Grid, restore the original bitmap
					// then resize it (streched) to the previously set dimensions
					var currentWidth : Number = width;
					var currentHeight : Number = height;
					_scale9Grid = null;
					assignBitmapData(_originalBitmap.clone());
					setSize(currentWidth, currentHeight);
				} else {
					if (!validGrid(r)) {
						throw (new Error("#001 - The _scale9Grid does not match the original BitmapData"));
						return;
					}
					
					_scale9Grid = r.clone();
					resizeBitmap(width, height);
					scaleX = 1;
					scaleY = 1;
				}
			}
		}

		/**
		 * assignBitmapData
		 * Update the effective bitmapData
		 */
		private function assignBitmapData(bmp : BitmapData) : void {
			super.bitmapData.dispose();
			super.bitmapData = bmp;
		}

		private function validGrid(r : Rectangle) : Boolean {
			return r.right <= _originalBitmap.width && r.bottom <= _originalBitmap.height;
		}

		/**
		 * get scale9Grid
		 */
		override public function get scale9Grid() : Rectangle {
			return _scale9Grid;
		}

		
		/**
		 * setSize
		 */
		public function setSize(w : Number, h : Number) : void {
			
			if (width == w && height == h)
				return;
			
			if (_scale9Grid == null) {
				super.width = w;
				super.height = h;
			} else {
				w = Math.max(w, _originalBitmap.width - _scale9Grid.width);
				h = Math.max(h, _originalBitmap.height - _scale9Grid.height);
				resizeBitmap(w, h);
			}
		}

		/**
		 * get original bitmap
		 */
		public function getOriginalBitmapData() : BitmapData {
			return _originalBitmap;
		}

		// ------------------------------------------------
		//
		// ---o protected methods
		//
		// ------------------------------------------------
		
		private static var rows:Array = [0, 0, 0, 0];
		private static var cols:Array = [0, 0, 0, 0];
		private static var dRows:Array = [0, 0, 0, 0];
		private static var dCols:Array = [0, 0, 0, 0];
		
		private static var origin:Rectangle = new Rectangle();
		private static var draw:Rectangle = new Rectangle();
		private static var mat:Matrix = new Matrix();
		
		protected function resizeBitmap(w : Number, h : Number) : void {
			
			var bmpData : BitmapData = new BitmapData(w, h, true, 0x00000000);
			
			rows[0] = 0;
			rows[1] = _scale9Grid.top
			rows[2] = _scale9Grid.bottom
			rows[3] = _originalBitmap.height
			
			cols[0] = 0;
			cols[1] = _scale9Grid.left
			cols[2] = _scale9Grid.right
			cols[3] = _originalBitmap.width
			
			dRows[0] = 0;
			dRows[1] = _scale9Grid.top
			dRows[2] = h - (_originalBitmap.height - _scale9Grid.bottom);
			dRows[3] = h
			
			dCols[0] = 0;
			dCols[1] = _scale9Grid.left
			dCols[2] = w - (_originalBitmap.width - _scale9Grid.right)
			dCols[3] = w
			
			
			for (var cx : int = 0; cx < 3; cx++) 
			{
				for (var cy : int = 0 ; cy < 3; cy++) 
				{
					origin.setTo(cols[cx], rows[cy], cols[cx + 1] - cols[cx], rows[cy + 1] - rows[cy]);
					draw.setTo(dCols[cx], dRows[cy], dCols[cx + 1] - dCols[cx], dRows[cy + 1] - dRows[cy]);
					
					mat.identity();
					
					mat.a = draw.width / origin.width;
					mat.d = draw.height / origin.height;
					mat.tx = draw.x - origin.x * mat.a;
					mat.ty = draw.y - origin.y * mat.d;
					
					bmpData.draw(_originalBitmap, mat, null, null, draw, smoothing);
				}
			}
			
			assignBitmapData(bmpData);
		}
	}
}