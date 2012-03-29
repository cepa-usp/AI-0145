package  
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
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
		
		private var ptCentral:Point;
		private var raio:Number;
		private var posicionamento:Function;
		public var angulo:Number;
		
		public function Letra(letra:String, posCentral:Point, raio:Number, angulo:Number, funcaoPosicionamento:Function) 
		{
			ptCentral = posCentral;
			this.raio = raio;
			posicionamento = funcaoPosicionamento;
			this.angulo = angulo;
			
			txt = new TextField();
			txt.defaultTextFormat = normalFormat;
			txt.selectable = false;
			txt.background = true;
			txt.backgroundColor = 0xFFFFFF;
			txt.text = letra;
			txt.width = txt.textWidth + 4;
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
		
		public function posiciona():void
		{
			var posicao:Point = posicionamento(raio, angulo);
			
			this.x = posicao.x + ptCentral.x;
			this.y = posicao.y + ptCentral.y;
		}
		
	}

}