package 
{
	import BaseAssets.BaseMain;
	import cepa.utils.Angle;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Alexandre
	 */
	public class Main extends BaseMain 
	{
		private var seno:Sprite;
		private var cosseno:Sprite;
		private var tangente:Sprite;
		private var secante:Sprite;
		private var cossecante:Sprite;
		private var cotangente:Sprite;
		
		private var circle:Sprite;
		private var eixoX:Sprite;
		private var eixoY:Sprite;
		private var pt:Sprite;
		
		private var raio:Number = 150;
		private var angulo:Number = -45 * Math.PI / 180;
		private var sprAngulo:Sprite;
		
		private var thickInvisible:Number = 10;
		private var alphaInvisible:Number = 0;
		private var tickNormal:Number = 2;
		
		private var bordaOpcoes:Number = 10;
		private var opcoes:MenuTrigonometrico;
		private var glow:GlowFilter = new GlowFilter(0x800000, 1, 10, 10);
		private var selected:MovieClip;
		
		private var linhaPontilhada:LinhaPontilhada;
		private var linhaPontilhadaTangente:LinhaPontilhada;
		
		private var barraTexto:TextoExplicativo;
		private var pontoCentral:Point = new Point(320, 285);
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			this.scrollRect = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			
			coresUint = [senoCor, cossenoCor, tangenteCor, secanteCor, cossecanteCor, cotangenteCor];
			
			createTextBar();
			createEixos();
			createCircle();
			createSprites();
			criaPt();
			pt.x = Math.cos(angulo) * raio + circle.x;
			pt.y = Math.sin(angulo) * raio + circle.y;
			linhaPontilhadaTangente.x = pt.x;
			linhaPontilhadaTangente.y = pt.y;
			drawTrigonometrics();
			criaOpcoes();
			addListeners();
			setTextForState();
			
			setChildIndex(barraTexto, numChildren - 1);
			setChildIndex(opcoes, numChildren - 1);
			setChildIndex(botoes, numChildren - 1);
			setChildIndex(bordaAtividade, numChildren - 1);
			iniciaTutorial();
		}
		
		private function createTextBar():void 
		{
			barraTexto = new TextoExplicativo();
			barraTexto.x = 5;
			barraTexto.y = stage.stageHeight - barraTexto.height - 5;
			addChild(barraTexto);
			setChildIndex(barraTexto, 0);
		}
		
		private function createEixos():void 
		{
			var sobraEixos:Number = 100;
			
			eixoX = new Sprite();
			eixoX.buttonMode = true;
			eixoX.mouseChildren = false;
			eixoX.x = pontoCentral.x;
			eixoX.y = pontoCentral.y;
			
			eixoX.graphics.lineStyle(1, 0x000000);
			eixoX.graphics.moveTo(- 30, 0);
			eixoX.graphics.lineTo(raio + sobraEixos, 0);
			drawRightArrow(eixoX, raio + sobraEixos, 0);
			
			eixoX.graphics.lineStyle(10, 0x000000, 0);
			eixoX.graphics.moveTo(- 30, 0);
			eixoX.graphics.lineTo(raio + sobraEixos, 0);
			drawRightArrow(eixoX, raio + sobraEixos, 0);
			
			var rotulox:RotuloX = new RotuloX();
			rotulox.x = raio + sobraEixos;
			rotulox.y = 10;
			eixoX.addChild(rotulox);
			
			eixoY = new Sprite();
			eixoY.buttonMode = true;
			eixoY.mouseChildren = false;
			eixoY.x = pontoCentral.x;
			eixoY.y = pontoCentral.y;
			
			eixoY.graphics.lineStyle(1, 0x000000);
			eixoY.graphics.moveTo(0, 30);
			eixoY.graphics.lineTo(0, - raio - sobraEixos);
			drawUpArrow(eixoY, 0, - raio - sobraEixos);
			
			eixoY.graphics.lineStyle(10, 0x000000, 0);
			eixoY.graphics.moveTo(0, 30);
			eixoY.graphics.lineTo(0, - raio - sobraEixos);
			drawUpArrow(eixoY, 0, - raio - sobraEixos);
			
			var rotuloy:RotuloY = new RotuloY();
			rotuloy.x = -8;
			rotuloy.y = - raio - sobraEixos;
			eixoY.addChild(rotuloy);
			
			addChild(eixoX);
			addChild(eixoY);
		}
		
		private var widthArrow:Number = 10;
		private var heightArrow:Number = 10;
		private function drawUpArrow(spr:Sprite, ptX:Number, ptY:Number):void
		{
			spr.graphics.curveTo(ptX, ptY + heightArrow / 2, ptX - widthArrow / 2, ptY + heightArrow);
			spr.graphics.moveTo(ptX, ptY);
			spr.graphics.curveTo(ptX, ptY + heightArrow / 2, ptX + widthArrow / 2, ptY + heightArrow);
			spr.graphics.moveTo(ptX, ptY);
		}
		
		private function drawRightArrow(spr:Sprite, ptX:Number, ptY:Number):void
		{
			spr.graphics.curveTo(ptX - heightArrow / 2, ptY, ptX - heightArrow, ptY - widthArrow / 2);
			spr.graphics.moveTo(ptX, ptY);
			spr.graphics.curveTo(ptX - heightArrow / 2, ptY, ptX - heightArrow, ptY + widthArrow / 2);
			spr.graphics.moveTo(ptX, ptY);
		}
		
		private function createCircle():void 
		{
			circle = new Sprite();
			circle.x = pontoCentral.x;
			circle.y = pontoCentral.y;
			addChild(circle);
				
			circle.graphics.lineStyle(1, 0xC0C0C0);
			circle.graphics.moveTo( -circle.x, -raio);
			circle.graphics.lineTo(stage.stageWidth - circle.x, -raio);
			circle.graphics.moveTo(raio, -circle.y);
			circle.graphics.lineTo(raio, stage.stageWidth - circle.y);
			
			circle.graphics.lineStyle(1, 0x000000);
			circle.graphics.drawCircle(0, 0, raio);
		}
		
		private function createSprites():void 
		{
			seno = new Sprite();
			cosseno = new Sprite();
			tangente = new Sprite();
			secante = new Sprite();
			cossecante = new Sprite();
			cotangente = new Sprite();
			sprAngulo = new Sprite();
			
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
			sprAngulo.x = circle.x;
			sprAngulo.y = circle.y;
			
			seno.buttonMode = true;
			cosseno.buttonMode = true;
			tangente.buttonMode = true;
			secante.buttonMode = true;
			cossecante.buttonMode = true;
			cotangente.buttonMode = true;
			sprAngulo.buttonMode = true;
			
			seno.name = "seno";
			cosseno.name = "cosseno";
			tangente.name = "tangente";
			secante.name = "secante";
			cossecante.name = "cossecante";
			cotangente.name = "cotangente";
			sprAngulo.name = "angulo";
			
			addChild(seno);
			addChild(cosseno);
			addChild(tangente);
			addChild(secante);
			addChild(cossecante);
			addChild(cotangente);
			addChild(sprAngulo);
			
			linhaPontilhada = new LinhaPontilhada();
			addChild(linhaPontilhada);
			linhaPontilhada.x = circle.x;
			linhaPontilhada.y = circle.y;
			
			linhaPontilhadaTangente = new LinhaPontilhada();
			addChild(linhaPontilhadaTangente);
			
			setChildIndex(linhaPontilhada, 0);
			setChildIndex(linhaPontilhadaTangente, 0);
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
			pt.graphics.drawCircle(0, 0, 3);
			
			pt.buttonMode = true;
		}
		
		private function criaOpcoes():void 
		{
			opcoes = new MenuTrigonometrico();
			opcoes.x = bordaOpcoes;
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
		
		private function addListeners():void 
		{
			pt.addEventListener(MouseEvent.MOUSE_DOWN, initDragPt);
			
			stage.addEventListener(MouseEvent.MOUSE_OVER, stageOver);
			stage.addEventListener(MouseEvent.MOUSE_OUT, stageOut);
		}
		
		private var names:Array = ["seno", "cosseno", "tangente", "secante", "cossecante", "cotangente"];
		private var cores:Array = ["vermelho", "verde", "amarelo", "azul", "rosa", "roxo"];
		private var coresUint:Array;
		private var angleColor:uint = 0xFF0000;
		private var angulosEspeciais:Array = [0, 30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315, 330];
		private var notacaoAngulosEspeciais:Array = ["0","π/6", "π/4", "π/3", "π/2", "2π/3", "3π/4", "5π/6", "π", "7π/6", "5π/4", "4π/3", "3π/2", "5π/3", "7π/4", "11π/6"];
		private var useGlow:Boolean = true;
		
		private function stageOver(e:MouseEvent):void 
		{
			if(e.target is Sprite){
				var obj:Sprite = Sprite(e.target);
				var indexObj:Number = names.indexOf(obj.name);
				
				if (indexObj > -1) {
					selected = opcoes[obj.name];
					selected.gotoAndStop(2);
					if (useGlow) {
						glow.color = coresUint[names.indexOf(obj.name)];
						this[obj.name].filters = [glow];
					}
					else {
						this[obj.name + "Alpha"] = 0.3;
						drawTrigonometrics();
					}
					if (indexObj == 0 || indexObj == 1) barraTexto.texto.text = "O " + obj.name + " é definido como a medida do comprimento do segmento " + cores[indexObj] + ".";
					else barraTexto.texto.text = "A " + obj.name + " é definida como a medida do comprimento do segmento " + cores[indexObj] + ".";
				}else {
					if (obj == pt) {
						barraTexto.texto.text = "Arraste o ponto para modificar os segmentos.";
					}else if (obj == sprAngulo) {
						//glow.color = angleColor;
						//sprAngulo.filters = [glow];
						
						var a:Angle = new Angle();
						a.radians = -angulo;
						a.domain = Angle.ZERO_TO_PLUS_2PI;
						
						var indiceAngulo:Number = angulosEspeciais.indexOf(Math.round(a.degrees));
						
						if(indiceAngulo > -1) barraTexto.texto.text = "Ângulo entre o eixo x e o segmento que liga (0,0) ao ponto P = " + notacaoAngulosEspeciais[indiceAngulo] + " rad.";
						else barraTexto.texto.text = "Ângulo entre o eixo x e o segmento que liga (0,0) ao ponto P = " + a.radians.toFixed(2) + " rad.";
					}else if (obj == eixoX) {
						barraTexto.texto.text = "Eixo x.";
					}else if (obj == eixoY) {
						barraTexto.texto.text = "Eixo y.";
					}
				}
			}else {
				switch(e.target.name) {
					case botoes.tutorialBtn.name:
						barraTexto.texto.text = "Reinicia o tutorial (balões).";
						break;
					case botoes.resetButton.name:
						barraTexto.texto.text = "Reinicia a atividade interativa (retoma a situação inicial).";
						break;
					case botoes.orientacoesBtn.name:
						barraTexto.texto.text = "Orientações e objetivos pedagógicos.";
						break;
					case botoes.creditos.name:
						barraTexto.texto.text = "Licença e créditos desta atividade interativa.";
						break;
					
				}
				
			}
		}
		
		private function stageOut(e:MouseEvent):void 
		{
			if(e.target is Sprite){
				var obj:Sprite = Sprite(e.target);
				
				if (names.indexOf(obj.name) > -1) {
					if(selected != null){
						selected.gotoAndStop(1);
						if(useGlow) this[obj.name].filters = [];
						else {
							this[obj.name + "Alpha"] = 0;
							drawTrigonometrics();
						}
						selected = null;
					}
				}
			}
			
			setTextForState();
		}
		
		private function setTextForState():void
		{
			barraTexto.texto.text = "";
		}
		
		private function initDragPt(e:MouseEvent):void 
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, movingPt);
			stage.addEventListener(MouseEvent.MOUSE_UP, stopMovingPt);
		}
		
		private function movingPt(e:MouseEvent):void 
		{
			angulo = Math.atan2(stage.mouseY - circle.y, stage.mouseX - circle.x);
			
			var a:Angle = new Angle();
			a.radians = -angulo;
			a.domain = Angle.ZERO_TO_PLUS_2PI;
			
			lookAngle: for each (var item:Number in angulosEspeciais) 
			{
				if (Math.abs(item - a.degrees) < 3) {
					angulo = -item * Math.PI / 180;
					break lookAngle;
				}
			}
			
			pt.x = Math.cos(angulo) * raio + circle.x;
			pt.y = Math.sin(angulo) * raio + circle.y;
			linhaPontilhadaTangente.x = pt.x;
			linhaPontilhadaTangente.y = pt.y;
			
			drawTrigonometrics();
		}
		
		private function stopMovingPt(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, movingPt);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopMovingPt);
		}
		
		private function drawTrigonometrics():void 
		{
			linhaPontilhadaTangente.rotation = angulo * 180 / Math.PI + 90;
			linhaPontilhada.rotation = angulo * 180 / Math.PI;
			
			drawAngle();
			drawSeno();
			drawCosseno();
			drawTangente();
			drawSecante();
			drawCossecante();
			drawCotangente();
		}
		
		private var raioAngle:Number = 20;
		private function drawAngle():void 
		{
			var angleGraus:Number;
			var a:Angle = new Angle();
			a.radians = -angulo;
			a.domain = Angle.ZERO_TO_PLUS_2PI;
			angleGraus = a.degrees;
			
			sprAngulo.graphics.clear();
			sprAngulo.graphics.beginFill(angleColor, 0.5);
			sprAngulo.graphics.moveTo(0, 0);
			sprAngulo.graphics.lineTo(raioAngle, 0);
			for (var i:int = 0; i <= angleGraus; i++)
			{
				sprAngulo.graphics.lineTo(raioAngle * Math.cos(-i * Math.PI / 180), raioAngle * Math.sin(-i * Math.PI / 180));
			}
			sprAngulo.graphics.lineTo(0, 0);
			sprAngulo.graphics.endFill();
			
			sprAngulo.graphics.lineStyle(2, angleColor);
			sprAngulo.graphics.moveTo(raioAngle, 0);
			for (i = 0; i <= angleGraus; i++)
			{
				sprAngulo.graphics.lineTo(raioAngle * Math.cos(-i * Math.PI / 180), raioAngle * Math.sin(-i * Math.PI / 180));
			}
		}
		
		private var senoAlpha:Number = 0;
		private var cossenoAlpha:Number = 0;
		private var tangenteAlpha:Number = 0;
		private var secanteAlpha:Number = 0;
		private var cossecanteAlpha:Number = 0;
		private var cotangenteAlpha:Number = 0;
		
		private var senoCor:uint = 0x800000;
		private var cossenoCor:uint = 0x008000;
		private var tangenteCor:uint = 0x808000;
		private var secanteCor:uint = 0x0000FF;
		private var cossecanteCor:uint = 0xFF0080;
		private var cotangenteCor:uint = 0x400080;
		
		private function drawSeno():void 
		{
			//var posSeno:Point = new Point(0, raio * Math.sin(angulo));
			var posSeno:Point = new Point(pt.x - circle.x, raio * Math.sin(angulo));
			
			seno.graphics.clear();
			
			seno.graphics.lineStyle(thickInvisible, senoCor, senoAlpha);
			seno.graphics.moveTo(posSeno.x, 0);
			seno.graphics.lineTo(posSeno.x, posSeno.y);
			
			seno.graphics.lineStyle(tickNormal, senoCor);
			seno.graphics.moveTo(posSeno.x, 0);
			seno.graphics.lineTo(posSeno.x, posSeno.y);
		}
		
		private function drawCosseno():void 
		{
			//var posCosseno:Point = new Point(raio * Math.cos(angulo), 0);
			var posCosseno:Point = new Point(raio * Math.cos(angulo), pt.y - circle.y);
			
			cosseno.graphics.clear();
			
			cosseno.graphics.lineStyle(thickInvisible, cossenoCor, cossenoAlpha);
			cosseno.graphics.moveTo(0, posCosseno.y);
			cosseno.graphics.lineTo(posCosseno.x, posCosseno.y);
			
			cosseno.graphics.lineStyle(tickNormal, cossenoCor);
			cosseno.graphics.moveTo(0, posCosseno.y);
			cosseno.graphics.lineTo(posCosseno.x, posCosseno.y);
		}
		
		private function drawTangente():void 
		{
			var posTangente:Point = new Point(raio, Math.max(-1000, Math.min(raio * Math.tan(angulo), 1000)));
			
			tangente.graphics.clear();
			
			tangente.graphics.lineStyle(thickInvisible, tangenteCor, tangenteAlpha);
			tangente.graphics.moveTo(posTangente.x, 0);
			tangente.graphics.lineTo(posTangente.x, posTangente.y);
			
			tangente.graphics.lineStyle(tickNormal, tangenteCor);
			tangente.graphics.moveTo(posTangente.x, 0);
			tangente.graphics.lineTo(posTangente.x, posTangente.y);
		}
		
		private function drawSecante():void 
		{
			var posSecante:Point = new Point(Math.max(-1000, Math.min(raio / Math.cos(angulo), 1000)), 0);
			
			secante.graphics.clear();
			
			secante.graphics.lineStyle(thickInvisible, secanteCor, secanteAlpha);
			secante.graphics.moveTo(0, 0);
			secante.graphics.lineTo(posSecante.x, posSecante.y);
			
			secante.graphics.lineStyle(tickNormal, secanteCor);
			secante.graphics.moveTo(0, 0);
			secante.graphics.lineTo(posSecante.x, posSecante.y);
		}
		
		private function drawCossecante():void 
		{
			var posCossecante:Point = new Point(0, Math.max(-1000, Math.min(raio / Math.sin(angulo), 1000)));
			
			cossecante.graphics.clear();
			
			cossecante.graphics.lineStyle(thickInvisible, cossecanteCor, cossecanteAlpha);
			cossecante.graphics.moveTo(0, 0);
			cossecante.graphics.lineTo(posCossecante.x, posCossecante.y);
			
			cossecante.graphics.lineStyle(tickNormal, cossecanteCor);
			cossecante.graphics.moveTo(0, 0);
			cossecante.graphics.lineTo(posCossecante.x, posCossecante.y);
		}
		
		private function drawCotangente():void 
		{
			var posCotangente:Point = new Point(Math.max(-1000, Math.min(-raio / Math.tan(angulo), 1000)), -raio);
			
			cotangente.graphics.clear();
			
			cotangente.graphics.lineStyle(thickInvisible, cotangenteCor, cotangenteAlpha);
			cotangente.graphics.moveTo(0, -raio);
			cotangente.graphics.lineTo(posCotangente.x, posCotangente.y);
			
			cotangente.graphics.lineStyle(tickNormal, cotangenteCor);
			cotangente.graphics.moveTo(0, -raio);
			cotangente.graphics.lineTo(posCotangente.x, posCotangente.y);
		}
		
		override public function reset(e:MouseEvent = null):void
		{
			angulo = -45 * Math.PI / 180;
			pt.x = Math.cos(angulo) * raio + circle.x;
			pt.y = Math.sin(angulo) * raio + circle.y;
			linhaPontilhadaTangente.x = pt.x;
			linhaPontilhadaTangente.y = pt.y;
			drawTrigonometrics();
		}
		
		
		//Tutorial
		private var balao:CaixaTexto;
		private var pointsTuto:Array;
		private var tutoBaloonPos:Array;
		private var tutoPos:int;
		//private var tutoPhaseFinal:Boolean;
		private var tutoSequence:Array = ["Arraste o ponto sobre a circunferência.",
										  "Passe o mouse sobre um segmento colorido para ver qual função trigonométrica ele define.",
										  "Você também pode passar o mouse sobre os itens desta lista.",
										  "Passe o mouse sobre o ângulo...",
										  "... e veja sua medida aqui."];
										  
		override public function iniciaTutorial(e:MouseEvent = null):void 
		{
			tutoPos = 0;
			//tutoPhaseFinal = false;
			if(balao == null){
				balao = new CaixaTexto(true);
				addChild(balao);
				balao.visible = false;
				
				pointsTuto = 	[pointPosition,
								cossenoPosition,
								new Point(opcoes.x, opcoes.y + opcoes.height / 2),
								new Point(pontoCentral.x + raioAngle, pontoCentral.y),
								new Point(barraTexto.x + 100, barraTexto.y)];
								
				tutoBaloonPos = [[CaixaTexto.LEFT, CaixaTexto.FIRST],
								[CaixaTexto.TOP, CaixaTexto.CENTER],
								[CaixaTexto.RIGHT, CaixaTexto.CENTER],
								[CaixaTexto.LEFT, CaixaTexto.FIRST],
								[CaixaTexto.BOTTON, CaixaTexto.FIRST]];
			}
			refreshPointPosition();
			balao.removeEventListener(Event.CLOSE, closeBalao);
			//feedBackScreen.removeEventListener(Event.CLOSE, iniciaTutorialSegundaFase);
			
			balao.setText(tutoSequence[tutoPos], tutoBaloonPos[tutoPos][0], tutoBaloonPos[tutoPos][1]);
			balao.setPosition(pointsTuto[tutoPos].x, pointsTuto[tutoPos].y);
			balao.addEventListener(Event.CLOSE, closeBalao);
			balao.visible = true;
		}
		
		private var pointPosition:Point = new Point();
		private var cossenoPosition:Point = new Point();
		private function refreshPointPosition():void
		{
			pointPosition.x = pt.x;
			pointPosition.y = pt.y;
			
			if (pt.x > stage.stageWidth / 2) {
				tutoBaloonPos[0] = [CaixaTexto.RIGHT, CaixaTexto.FIRST];
			}else {
				tutoBaloonPos[0] = [CaixaTexto.LEFT, CaixaTexto.FIRST];
			}
		}
		
		private function refreshCossenoPosition():void
		{
			var bdsCosseno:Rectangle = cosseno.getBounds(cosseno);
			cossenoPosition.y = cosseno.y + bdsCosseno.y;
			if (pt.x > pontoCentral.x) {
				cossenoPosition.x = cosseno.x + cosseno.width / 2 - 5;
			}else {
				cossenoPosition.x = cosseno.x - cosseno.width / 2 + 5;
			}
			
			if (pt.y > pontoCentral.x) {
				tutoBaloonPos[1][0] = CaixaTexto.BOTTON;
			}else {
				tutoBaloonPos[1][0] = CaixaTexto.TOP;
			}
		}
		
		private function closeBalao(e:Event):void 
		{
			refreshCossenoPosition();
			/*if (tutoPhaseFinal) {
				balao.removeEventListener(Event.CLOSE, closeBalao);
				balao.visible = false;
				feedBackScreen.removeEventListener(Event.CLOSE, iniciaTutorialSegundaFase);
			}else{*/
				tutoPos++;
				if (tutoPos >= tutoSequence.length) {
					balao.removeEventListener(Event.CLOSE, closeBalao);
					balao.visible = false;
					//feedBackScreen.addEventListener(Event.CLOSE, iniciaTutorialSegundaFase);
					//tutoPhaseFinal = true;
				}else {
					balao.setText(tutoSequence[tutoPos], tutoBaloonPos[tutoPos][0], tutoBaloonPos[tutoPos][1]);
					balao.setPosition(pointsTuto[tutoPos].x, pointsTuto[tutoPos].y);
				}
			//}
		}
		
		/*private function iniciaTutorialSegundaFase(e:Event):void 
		{
			if(tutoPhaseFinal){
				balao.setText("Você pode começar um novo exercício clicando aqui.", tutoBaloonPos[2][0], tutoBaloonPos[2][1]);
				balao.setPosition(160, pointsTuto[2].y);
				tutoPhaseFinal = false;
			}
		}*/
	}
	
}