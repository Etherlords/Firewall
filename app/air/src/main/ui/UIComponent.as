package ui 
{
	import core.collections.Iterable;
	import core.IDestructable;
	import flash.display.Sprite;
	import ui.effects.OverEffect;
	import ui.style.Style;
	import ui.style.StyleSheet;
	
	public class UIComponent extends Sprite implements IDestructable
	{
		protected var _style:Style;
		protected var styleSheet:StyleSheet = new StyleSheet();
		
		protected var subComponentsList:Vector.<UIComponent> = new Vector.<UIComponent>;
		
		protected var invaildLayout:Boolean = true;
		
		protected var _mouseInteraction:Boolean = true;
		
		public function UIComponent(style:Style = null) 
		{
			_style = style;
			
			preinitialzie();
			buildStyleSheet();
			applyStyle();
			createChildren();
			configureChildren();
			updateDisplayList();
			initialize();
		}
		
		public function get mouseInteraction():Boolean
		{
			return _mouseInteraction;
		}
		
		public function set mouseInteraction(value:Boolean):void
		{
			if (_mouseInteraction == value)
				return;
				
			this.mouseChildren = value;
			this.mouseEnabled = value;
		}
		
		protected function invalidateLayout():void
		{
			invaildLayout = true;
		}
		
		public function removeComponents():void
		{
			for (var i:int = 0; i < subComponentsList.length; i++)
			{
				removeChild(subComponentsList[i])
			}
			
			subComponentsList = new Vector.<UIComponent>;
		}
		
		public function removeComponent(component:UIComponent):void
		{
			for (var i:int = 0; i < subComponentsList.length; i++)
			{
				if (subComponentsList[i] == component)
				{
					subComponentsList.splice(i, 1);
					break;
				}
			}
			
			removeChild(component);
		}
		
		public function addComponent(component:UIComponent):void
		{
			subComponentsList.push(component);
			
			addChild(component);
		}
		
		public function update():void
		{
			for (var i:int = 0; i < subComponentsList.length; i++)
			{
				subComponentsList[i].update();
			}
			
			if(invaildLayout)
				layoutChildren();
		}
		
		public function setEffect(effect:OverEffect):void
		{
			effect.initialize(this);
		}
		
		protected function updateDisplayList():void 
		{
			
		}
		
		protected function preinitialzie():void 
		{
			
		}
		
		protected function initialize():void
		{
			
		}
		
		protected function createChildren():void
		{
			
		}
		
		protected function configureChildren():void
		{
			
		}
		
		protected function layoutChildren():void
		{
			invaildLayout = false;
		}
		
		protected function destroyChildren():void
		{
			for (var i:int = 0; i < subComponentsList.length; i++)
			{
				removeChild(subComponentsList[i]);
			}
		}
		
		public function destroy():void
		{
			destroyChildren();
		}
		
		protected function buildStyleSheet():void
		{
			
		}
		
		public function addStyleSheet(styleKey:String, fieldToBind:String):void
		{
			styleSheet.bindStyle(styleKey, fieldToBind);
		}
		
		public function get style():Style 
		{
			return _style;
		}
		
		public function set style(value:Style):void 
		{
			_style = value;
		}
		
		protected function applyStyle():void
		{
			var stylesList:Iterable = styleSheet.styles;
			
			if (stylesList.length == 0)
				return;
				
			if(!_style)
				return;
				
			var currentItem:Object = stylesList.currentItem; 
			
			for (var i:int = 0; i < stylesList.length; i++)
			{
				_style.applyStyle(this, stylesList.current, currentItem as String);
				
				currentItem = stylesList.nextItem;
			}
		}
		
	}

}