package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Alexandre
	 */
	public class Main extends Sprite 
	{
		private var seno:Sprite;
		private var cosseno:Sprite;
		private var tangente:Sprite;
		private var secante:Sprite;
		private var cossecante:Sprite;
		private var cotangente:Sprite;
		
		private var circle:Sprite;
		private var eixos:Sprite;
		private var pt:Sprite;
		
		private var raio:Number = 150;
		private var angulo:Number = -45 * Math.PI / 180;
		
		private var thickInvisible:Number = 10;
		private var alphaInvisible:Number = 0;
		private var tickNormal:Number = 3;
		
		private var bordaOpcoes:Number = 15;
		private var opcoes:MenuTrigonometrico;
		private var glow:GlowFilter = new GlowFilter(0x800000);
		private var selected:MovieClip;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			createEixos();
			createCircle();
			createSprites();
			criaPt();
			pt.x = Math.cos(angulo) * raio + circle.x;
			pt.y = Math.sin(angulo) * raio + circle.y;
			drawTrigonometrics();
			criaOpcoes();
			addListeners();
		}
		
		private function criaOpcoes():void 
		{
			opcoes = new MenuTrigonometrico();
			opcoes.x = stage.stageWidth - opcoes.width - bordaOpcoes;
			opcoes.y = bordaOpcoes;
			addChild(opcoes);
			
			opcoes.seno.gotoAndStop(1);
			opcoes.cosseno.gotoAndStop(1);
			opcoes.tangente.gotoAndStop(1);
			opcoes.secante.gotoAndStop(1);
			opcoes.cossecante.gotoAndStop(1);
			opcoes.cotangente.gotoAndStop(1);
			
			opcoes.seno.buttonMode = true;
			opcoes.cosseno.buttonMode = true;
			opcoes.tangente.buttonMode = true;
			opcoes.secante.buttonMode = true;
			opcoes.cossecante.buttonMode = true;
			opcoes.cotangente.buttonMode = true;
		}
		
		private function createCircle():void 
		{
			if(circle == null){
				circle = new Sprite();
				circle.x = stage.stageWidth / 2;
				circle.y = stage.stageHeight / 2;
				addChild(circle);
			}
			circle.graphics.clear();
			circle.graphics.lineStyle(1, 0x000000);
			circle.graphics.drawCircle(0, 0, raio);
		}
		
		private function createEixos():void 
		{
			var sobraEixos:Number = 100;
			eixos = new Sprite();
			eixos.x = stage.stageWidth / 2;
			eixos.y = stage.stageHeight / 2;
			
			eixos.graphics.lineStyle(1, 0x808080, 0.5);
			eixos.graphics.moveTo( - raio - sobraEixos, 0);
			eixos.graphics.lineTo(raio + sobraEixos, 0);
			eixos.graphics.moveTo(0, - raio - sobraEixos);
			eixos.graphics.lineTo(0, raio + sobraEixos);
			
			addChild(eixos);
		}
		
		private function createSprites():void 
		{
			seno = new Sprite();
			cosseno = new Sprite();
			tangente = new Sprite();
			secante = new Sprite();
			cossecante = new Sprite();
			cotangente = new Sprite();
			
			seno.x = circle.x;
			seno.y = circle.y;
			cosseno.x = circle.x;
			cosseno.y = circle.y;
			tangente.x = circle.x;
			tangente.y = circle.y;
			secante.x = circle.x;
			secante.y = circle.y;
			cossecante.x = circle.x;
			cossecante.y = circle.y;
			cotangente.x = circle.x;
			cotangente.y = circle.y;
			
			seno.buttonMode = true;
			cosseno.buttonMode = true;
			tangente.buttonMode = true;
			secante.buttonMode = true;
			cossecante.buttonMode = true;
			cotangente.buttonMode = true;
			
			seno.name = "seno";
			cosseno.name = "cosseno";
			tangente.name = "tangente";
			secante.name = "secante";
			cossecante.name = "cossecante";
			cotangente.name = "cotangente";
			
			addChild(seno);
			addChild(cosseno);
			addChild(tangente);
			addChild(secante);
			addChild(cossecante);
			addChild(cotangente);
		}
		
		private function criaPt():void 
		{
			pt = new Sprite();
			addChild(pt);
			
			pt.graphics.beginFill(0x800000, 0);
			pt.graphics.drawCircle(0, 0, 10);
			pt.graphics.endFill();
			pt.graphics.lineStyle(1, 0x000000);
			pt.graphics.beginFill(0x000040);
			pt.graphics.drawCircle(0, 0, 5);
			
			pt.buttonMode = true;
		}
		
		private function addListeners():void 
		{
			pt.addEventListener(MouseEvent.MOUSE_DOWN, initDragPt);
			
			stage.addEventListener(MouseEvent.MOUSE_OVER, stageOver);
			stage.addEventListener(MouseEvent.MOUSE_OUT, stageOut);
		}
		
		private function stageOver(e:MouseEvent):void 
		{
			if(e.target is Sprite){
				var obj:Sprite = Sprite(e.target);
				
				if (obj != circle && obj != pt && obj != eixos && obj != opcoes) {
					selected = opcoes[obj.name];
					selected.gotoAndStop(2);
					//this[obj.name].filters = [glow];
					this[obj.name + "Alpha"] = 0.3;
					drawTrigonometrics();
				}
			}
		}
		
		private function stageOut(e:MouseEvent):void 
		{
			if(e.target is Sprite){
				var obj:Sprite = Sprite(e.target);
				
				if (obj != circle && obj != pt && obj != eixos && obj != opcoes) {
					if(selected != null){
						selected.gotoAndStop(1);
						//this[obj.name].filters = [];
						this[obj.name + "Alpha"] = 0;
						selected = null;
						drawTrigonometrics();
					}
				}
			}
		}
		
		private function initDragPt(e:MouseEvent):void 
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, movingPt);
			stage.addEventListener(MouseEvent.MOUSE_UP, stopMovingPt);
		}
		
		private function movingPt(e:MouseEvent):void 
		{
			angulo = Math.atan2(stage.mouseY - circle.y, stage.mouseX - circle.x);
			
			pt.x = Math.cos(angulo) * raio + circle.x;
			pt.y = Math.sin(angulo) * raio + circle.y;
			
			drawTrigonometrics();
		}
		
		private function stopMovingPt(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, movingPt);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopMovingPt);
		}
		
		private function drawTrigonometrics():void 
		{
			drawSeno();
			drawCosseno();
			drawTangente();
			drawSecante();
			drawCossecante();
			drawCotangente();
		}
		
		private var senoAlpha:Number = 0;
		private var cossenoAlpha:Number = 0;
		private var tangenteAlpha:Number = 0;
		private var secanteAlpha:Number = 0;
		private var cossecanteAlpha:Number = 0;
		private var cotangenteAlpha:Number = 0;
		
		private function drawSeno():void 
		{
			//var posSeno:Point = new Point(0, raio * Math.sin(angulo));
			var posSeno:Point = new Point(pt.x - circle.x, raio * Math.sin(angulo));
			
			seno.graphics.clear();
			
			seno.graphics.lineStyle(thickInvisible, 0x800000, senoAlpha);
			seno.graphics.moveTo(posSeno.x, 0);
			seno.graphics.lineTo(posSeno.x, posSeno.y);
			
			seno.graphics.lineStyle(tickNormal, 0x800000);
			seno.graphics.moveTo(posSeno.x, 0);
			seno.graphics.lineTo(posSeno.x, posSeno.y);
		}
		
		private function drawCosseno():void 
		{
			//var posCosseno:Point = new Point(raio * Math.cos(angulo), 0);
			var posCosseno:Point = new Point(raio * Math.cos(angulo), pt.y - circle.y);
			
			cosseno.graphics.clear();
			
			cosseno.graphics.lineStyle(thickInvisible, 0x008000, cossenoAlpha);
			cosseno.graphics.moveTo(0, posCosseno.y);
			cosseno.graphics.lineTo(posCosseno.x, posCosseno.y);
			
			cosseno.graphics.lineStyle(tickNormal, 0x008000);
			cosseno.graphics.moveTo(0, posCosseno.y);
			cosseno.graphics.lineTo(posCosseno.x, posCosseno.y);
		}
		
		private function drawTangente():void 
		{
			var posTangente:Point = new Point(raio, raio * Math.tan(angulo));;
			
			tangente.graphics.clear();
			
			tangente.graphics.lineStyle(thickInvisible, 0x808000, tangenteAlpha);
			tangente.graphics.moveTo(posTangente.x, 0);
			tangente.graphics.lineTo(posTangente.x, posTangente.y);
			
			tangente.graphics.lineStyle(tickNormal, 0x808000);
			tangente.graphics.moveTo(posTangente.x, 0);
			tangente.graphics.lineTo(posTangente.x, posTangente.y);
		}
		
		private function drawSecante():void 
		{
			var posSecante:Point = new Point(raio / Math.cos(angulo), 0);
			
			secante.graphics.clear();
			
			secante.graphics.lineStyle(thickInvisible, 0x0000FF, secanteAlpha);
			secante.graphics.moveTo(0, 0);
			secante.graphics.lineTo(posSecante.x, posSecante.y);
			
			secante.graphics.lineStyle(tickNormal, 0x0000FF);
			secante.graphics.moveTo(0, 0);
			secante.graphics.lineTo(posSecante.x, posSecante.y);
		}
		
		private function drawCossecante():void 
		{
			var posCossecante:Point = new Point(0, raio / Math.sin(angulo));
			
			cossecante.graphics.clear();
			
			cossecante.graphics.lineStyle(thickInvisible, 0xFF0080, cossecanteAlpha);
			cossecante.graphics.moveTo(0, 0);
			cossecante.graphics.lineTo(posCossecante.x, posCossecante.y);
			
			cossecante.graphics.lineStyle(tickNormal, 0xFF0080);
			cossecante.graphics.moveTo(0, 0);
			cossecante.graphics.lineTo(posCossecante.x, posCossecante.y);
		}
		
		private function drawCotangente():void 
		{
			var posCotangente:Point = new Point(-raio / Math.tan(angulo), -raio);
			
			cotangente.graphics.clear();
			
			cotangente.graphics.lineStyle(thickInvisible, 0x400080, cotangenteAlpha);
			cotangente.graphics.moveTo(0, -raio);
			cotangente.graphics.lineTo(posCotangente.x, posCotangente.y);
			
			cotangente.graphics.lineStyle(tickNormal, 0x400080);
			cotangente.graphics.moveTo(0, -raio);
			cotangente.graphics.lineTo(posCotangente.x, posCotangente.y);
		}
		
	}
	
}