package  
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Alexandre
	 */
	public class Letra extends Sprite 
	{
		private var txt:TextField;
		private var normalFormat:TextFormat = new TextFormat("arial", 18, 0xD6D6D6);
		private var overFormat:TextFormat = new TextFormat("arial", 18, 0x000000);
		
		public function Letra(letra:String) 
		{
			txt = new TextField();
			txt.defaultTextFormat = normalFormat;
			txt.selectable = false;
			txt.text = letra;
			txt.width = txt.textWidth;
			txt.height = txt.textHeight;
			txt.y = - txt.height;
			addChild(txt);
			
			this.mouseChildren = false;
			
			addEventListener(MouseEvent.MOUSE_OVER, over);
			addEventListener(MouseEvent.MOUSE_OUT, out);
		}
		
		private function over(e:MouseEvent):void 
		{
			txt.defaultTextFormat = overFormat;
			txt.text = txt.text;
		}
		
		private function out(e:MouseEvent):void 
		{
			txt.defaultTextFormat = normalFormat;
			txt.text = txt.text;
		}
		
	}

}