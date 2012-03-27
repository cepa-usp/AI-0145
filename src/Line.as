package {
	import flash.geom.Point;
	
	public class Line {
		
		public function Line (a:Point, b:Point) {
			if (a) _ptA = new Point(a.x, a.y);
			else throw new Error ("Cannot create a line with a null point.");
			
			if (b) _ptB = new Point(b.x, b.y);
			else throw new Error ("Cannot create a line with a null point.");
			
			ab = Math.sqrt(Math.pow(b.x - a.x, 2) + Math.pow(b.y - a.y, 2));
			//if (ab < EPS) throw new Error ("Points must be different.");
		}
		
		public function get a () : Point {
			return new Point(_ptA.x, _ptA.y);
		}
		
		public function set a (point:Point) : void {
			if (point) {
				var ab:Number = Math.sqrt(Math.pow(_ptB.x - point.x, 2) + Math.pow(_ptB.y - point.y, 2));
				//if (ab < EPS) throw new Error ("Points must be different.");
				
				this.ab = ab;
				_ptA = new Point(point.x, point.y);
			}
			else throw new Error ("Cannot create a line with a null point.");
		}
		
		public function get b () : Point {
			return new Point(_ptB.x, _ptB.y);
		}
		
		public function set b (point:Point) : void {
			if (point) {
				var ab:Number = Math.sqrt(Math.pow(point.x - _ptA.x, 2) + Math.pow(point.y - _ptA.y, 2));
				//if (ab < EPS) throw new Error ("Points must be different.");
				
				this.ab = ab;
				_ptB = new Point(point.x, point.y);
			}
			else throw new Error ("Cannot create a line with a null point.");
		}
		
		public function distance (point:Point) : Number {
			if (ab > EPS) return Math.abs((_ptB.x - _ptA.x) * (point.y - _ptA.y) - (point.x - _ptA.x) * (_ptB.y - _ptA.y)) / ab;
			else return NaN;
			//else throw new Error("Points are too close");
		}
		
		public function dotProduct (point:Point) : Number {
			var ac:Number = Point.distance(point, _ptA);
			if (ab > EPS && ac > EPS) return ((point.x - _ptA.x) * (_ptB.x - _ptA.x) + (point.y - _ptA.y) * (_ptB.y - _ptA.y)) / (ab * ac);
			else return NaN;
		}
		
		public function toString () : String {
			return " -- (" + _ptA.x + "," + _ptA.y + ") -- (" + _ptB.x + "," + _ptB.y + ") -- ";
		}
		
		private var EPS:Number = 1e-6;
		private var _ptA:Point;
		private var _ptB:Point;
		private var ab:Number;
		
	}
}
