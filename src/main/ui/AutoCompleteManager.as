package ui 
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;

	public class AutoCompleteManager 
	{
		public var completionMap:Vector.<String> = new Vector.<String>;
		
		private var textField:TextField;
		private var originalText:String = ''
		
		public function AutoCompleteManager(textField:TextField) 
		{
			this.textField = textField;
			initialize();
		}
		
		private function initialize():void 
		{
			textField.addEventListener(TextEvent.TEXT_INPUT, onInputText);
			textField.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			textField.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			textField.addEventListener(FocusEvent.FOCUS_IN, onFocusIn, false, -1);
			//textField.selectable = false
			
			textField.addEventListener(Event.CHANGE, onTextChange);
			
			textField.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			
			if (textField.caretIndex > originalText.length)
				textField.setSelection(originalText.length, originalText.length);
				
			onTextChange();
		}
		
		private function onFocusIn(e:FocusEvent):void 
		{
			onTextChange();
			
		}
		
		private function onFocusOut(e:FocusEvent):void 
		{
			this.textField.text = originalText;
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			
			var caretIndex:int = textField.caretIndex;
			
			if (e.keyCode == Keyboard.LEFT)
			{
				e.preventDefault();
				
				if(caretIndex != 0)
					textField.setSelection(caretIndex - 1, caretIndex - 1)
				else
					return;
			}
			
			if (e.keyCode == Keyboard.RIGHT)
			{
				e.preventDefault();
				
				if (caretIndex + 1 > originalText.length)
					return;
				else
					textField.setSelection(caretIndex + 1, caretIndex + 1);
			}
			
			if (e.keyCode == Keyboard.BACKSPACE)
			{
				originalText = originalText.substr(0, caretIndex - 1) + originalText.substr(caretIndex);
				textField.setSelection(caretIndex - 1, caretIndex - 1);
				e.preventDefault();
			}
			else if (e.keyCode == Keyboard.DELETE)
			{
				originalText = originalText.substr(0, caretIndex) + originalText.substr(caretIndex + 1);
				//textField.caretIndex -= 1;
				e.preventDefault();
			}
			
			onTextChange();
		}
		
		private function onInputText(e:TextEvent):void 
		{
			if (textField.caretIndex == originalText.length)
				originalText += e.text;
			else
			{
				originalText = originalText.substr(0, textField.caretIndex) + e.text + originalText.substr(textField.caretIndex);
			}
			
			onTextChange();
		}
		
		private function onTextChange(e:Event = null):void 
		{
			var i:int;
			var currentCompletion:Vector.<String> = new Vector.<String>;
			
			var text:String = originalText;
			var caretIndex:int = textField.caretIndex - 1;
			var wordEndIndex:int = text.indexOf(' ', textField.caretIndex);
			var wordStartIndex:int = 0;
			
			if (wordEndIndex == -1)
				wordEndIndex = text.length;
				
			
			if (caretIndex != -1)
			{
				for (i = caretIndex; i != 0; i--)
				{
					if (text.charAt(i) == ' ')
					{
						wordStartIndex = i + 1;
						break;
					}
				}
			}
			else
				wordEndIndex = 0;
			
			text = text.substring(wordStartIndex, wordEndIndex);
			
			var len:int = text.length;
			var currentWord:String;
			
			for (i = 0; i < completionMap.length; i++)
			{
				currentWord = completionMap[i];
				
				if (currentWord.length > text.length && text == currentWord.substr(0, len))
				{
					currentCompletion.push(currentWord);
				}
			}
			
			if (currentCompletion.length)
			{
				trace('set complete');
				currentCompletion.sort(onLen);
				textField.htmlText = originalText.substring(0, wordEndIndex) + "<font color='#888888'>" + currentCompletion[0].substr(len) + "</font>" + originalText.substring(wordEndIndex)
			}
			else
				textField.htmlText = originalText;
		}
		
		private function onLen(a:String, b:String):Number
		{
			if (a.length > b.length)
				return 1;
			else
				return -1;
		}
		
	}

}