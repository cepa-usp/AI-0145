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
		//private var normalFormat:TextFormat = new TextFormat("arial", 18, 0x000000);
		private var overFormat:TextFormat = new TextFormat("arial", 18, 0x000000);
		
		private var ptCentral:Point;
		private var raio:Number;
		private var posicionamento:Function;
		private var funcaoOffSet:Function;
		private var invertFuncao:Number;
		public var angulo:Number;
		private var raioLetra:Number = 14;
		
		public function Letra(letra:String, posCentral:Point, raio:Number, angulo:Number, funcaoPosicionamento:Function, funcaoOffSet:Function = null, invertFuncao:Boolean = false) 
		{
			ptCentral = posCentral;
			this.raio = raio;
			posicionamento = funcaoPosicionamento;
			this.angulo = angulo;
			this.funcaoOffSet = funcaoOffSet;
			
			if (invertFuncao) this.invertFuncao = -1;
			else this.invertFuncao = 1;
			
			txt = new TextField();
			txt.defaultTextFormat = normalFormat;
			txt.selectable = false;
			//txt.background = true;
			//txt.backgroundColor = 0xFFFFFF;
			txt.text = letra;
			txt.width = txt.textWidth + 4;
			txt.height = txt.textHeight + 4;
			txt.x = -txt.width / 2;
			txt.y = - txt.height / 2;
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
			var offSetPoint:Point = new Point();
			
			if (funcaoOffSet != null) offSetPoint = funcaoOffSet(txt.text);
			
			this.x = posicao.x + ptCentral.x + offSetPoint.x * raioLetra;
			this.y = posicao.y + ptCentral.y + offSetPoint.y * raioLetra;
		}
		
	}

}