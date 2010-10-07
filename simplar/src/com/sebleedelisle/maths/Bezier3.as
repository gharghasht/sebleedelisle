package com.sebleedelisle.maths
{
	import flash.display.Graphics;

	public class Bezier3
	{
		
		public var p1		: Vector3;
		public var c1		: Vector3;
		public var p2		: Vector3;
		public var c2		: Vector3;
		private var _magnitude : Number ; 
		
		public function Bezier3( p1 : Vector3, c1 : Vector3, p2 : Vector3, c2 : Vector3 )
		{
			this.p1 = p1;
			this.c1 = c1;
			this.p2 = p2;
			this.c2 = c2;
			updateMagnitude(); 
			
		}
		
		public function toString() : String
		{
			return(p1+" "+c1+" "+c2+" "+p2+" ");
			
		}
		public function getVector3AtT( t : Number, targetV : Vector3 = null ) : Vector3
		{
			if(!targetV) targetV = new Vector3; 
			targetV.x = p1.x * B1(t) + c1.x*B2(t) + c2.x*B3(t) + p2.x*B4(t);
			targetV.y = p1.y * B1(t) + c1.y*B2(t) + c2.y*B3(t) + p2.y*B4(t);
			targetV.z = p1.z * B1(t) + c1.z*B2(t) + c2.z*B3(t) + p2.z*B4(t);
			
			return targetV; 					
		}
		
		public function get magnitude() : Number 
		{
			if(!_magnitude) updateMagnitude(); 
			return _magnitude;

		}
	
		public function updateMagnitude(iterations : int = 100) : Number
		{
			var lastp : Vector3 = p1.clone(); 
			var tp1 : Vector3 = p1.clone(); 
			var tp2 : Vector3 = p1.clone(); 
			var l : Number = 0; 
			
			for(var i : int = 0; i<=iterations ; i++)
			{
				var t : Number = i/iterations;
				
				tp2 = getVector3AtT(t, tp2); 
				tp1.copyFrom(tp2); 
				tp1.minusEq(lastp);
				l+=tp1.magnitude(); 
				lastp.copyFrom(tp2); 
					
			}
			
			_magnitude = l; 
			return _magnitude; 
		}
	
		public function renderXZ(g : Graphics, iterations : int = 10) : void
		{
			g.moveTo(p1.x, p2.z); 
			for (var t : Number = 0; t<=1; t+=(1/iterations))
			{
				var p : Vector3 = getVector3AtT(t); 
				g.lineTo(p.x, p.z); 
				
			}
			
		}
	
		// These are all calculations for the quadratic bezier functions
		protected static function B4 (t:Number):Number {
			return (t*t*t);
		}
		protected static function B3 (t:Number):Number {
			return (3 * t * t * (1 - t));
		}
		protected static function B2 (t:Number):Number {
			return (3 * t * (1 - t) * (1 - t));
		}
		
		protected static function B1 (t:Number):Number {
			return ((1 - t) * (1 - t) * (1 - t));
		}
		//
	
	
	}
}