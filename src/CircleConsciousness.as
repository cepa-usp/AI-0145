package {
	import flash.geom.Point;
	public class CircleConsciousness {
		
		private var lines:Vector.<Line>;
		private const COS:int = 0;
		private const SIN:int = 1;
		private const TAN:int = 2;
		private const COT:int = 3;
		private const SEC:int = 4;
		private const CSC:int = 5;
		private var r:Number = 100;
		private var d:Number = 5;
		
		public function CircleConsciousness () {
			lines = new Vector.<Line>(6, true);
			for (var i:int = 0; i < 6; i++) lines[i] = new Point();
			angle = 0;
		}
		
		public function set angle (rad:Number) : void {
		
			//lines[COS].a = (0,0);
			lines[COS].b = new Point(r * Math.cos(rad), 0);
			//lines[SIN].a = (0,0);
			lines[SIN].b = new Point(0, r * Math.sin(rad));
			lines[TAN].a = new Point(r, 0);
			lines[TAN].b = new Point(r, r * Math.tan(rad));
			lines[COT].a = new Point(0, r);
			lines[COT].b = new Point(r / Math.tan(rad), r);
			//lines[SEC].a = (0,0);
			lines[SEC].b = new Point(r / Math.cos(rad), 0);
			//lines[CSC].a = (0,0);
			lines[CSC].b = new Point(0, r / Math.sin(rad));
		}
		
		public function getSegments (point:Point) : Array {
			var ans:Array = new Array();
			
			for (var i:int = 0; i < 6; i++) {
				var dotProduct:Number = lines[i].dotProduct(point);
				var distance:Number = lines[i].distance(point);
				if (distance < d && dotProduct >= 0 - d && dotProduct <= 1 + d) ans.push(i);
			}
			
			return ans;
		}
	}
}