package com.sebleedelisle.maths 
{
	import flash.display.Graphics;

	/**
	 * 
	 * @author Seb Lee-Delisle
	 */
	public class Spline3 
	{
		public var firstPoint : Vector3; 
		public var beziers : Array;
		public var lengths : Array;
		public var totalLength : Number; 

		public function Spline3() 
		{
			beziers = new Array(); 
			lengths = new Array(); 
			totalLength = 0; 
		}

		public function addPoint(p : Vector3) : void
		{
			// the last point in the chain, so to speak
			var lastPoint : Vector3;
			 
			if(!firstPoint) 
			{
				firstPoint = p; 
				return;
			}
			else if(beziers.length ==0)
			{
				lastPoint = firstPoint; 
			}
			else
			{
				var lastBezier : Bezier3 = beziers[beziers.length-1];
				lastPoint = lastBezier.p2; 
			}
			
			var bezier : Bezier3 = new Bezier3(lastPoint, lastPoint.clone(), p, p.clone());
			beziers.push(bezier); 	
			lengths.push(bezier.magnitude); 
			totalLength += bezier.magnitude; 
			trace(beziers); 
			
		}
		
		public function createLoop() : void
		{
			//var lastBezier : Bezier3 = beziers[beziers.length-1];
			var firstBezier : Bezier3 = beziers[0];
			//lastBezier.p2 = firstBezier.p1; 
			addPoint(firstBezier.p1); 
		}
		
		public function smooth(smoothAmount : Number = 4) : void
		{
			var lastBezier : Bezier3 = beziers[0]; 
			var firstBezier : Bezier3 = lastBezier; 
			var bezier :Bezier3;
			
			for (var i : int = 1; i<= beziers.length ; i++) 
			{
				
				if(i==beziers.length)
				{
					if(bezier.p2==firstBezier.p1)
					{
						bezier = firstBezier; 
					}
					else
					{
						break; 
					}
				}
				else
				{
					bezier = beziers[i]; 
				}
				//trace("bezier smoothing", bezier); 
				var v1 : Vector3 = lastBezier.p2.minusNew(lastBezier.p1); 
				var v2 : Vector3 = bezier.p2.minusNew(bezier.p1); 
				
				/*g.lineStyle(0,0xff0000); 
				g.moveTo(lastBezier.p1.x, lastBezier.p1.z); 
				g.lineTo(lastBezier.p1.x + v1.x, lastBezier.p1.z +v1.z); 
				*/
				var v1mag : Number = v1.magnitude(); 
				var v2mag : Number = v2.magnitude(); 
				v1.multiplyEq(1/v1mag); 
				v2.multiplyEq(1/v2mag); 
				
				v1.multiplyEq(0.5); 
				v2.multiplyEq(0.5); 
				v1.plusEq(v2); 
				//trace(v1.magnitude());
				v1.normalise(); 
				
					
				/*
				g.lineStyle(1,0x00ff00); 
				g.moveTo(lastBezier.p2.x, lastBezier.p2.z );
				g.lineTo(lastBezier.p2.x - (v1.x*20), lastBezier.p2.z - (v1.z*20));
				g.lineStyle(1,0x000ff); 
				g.moveTo(bezier.p1.x, bezier.p1.z );
				g.lineTo(bezier.p1.x + (v1.x*20), bezier.p1.z + (v1.z*20));
				*/
				
				lastBezier.c2.copyFrom(v1); 
				lastBezier.c2.multiplyEq(-v1mag/smoothAmount);
				lastBezier.c2.plusEq(lastBezier.p2); 
				
				bezier.c1.copyFrom(v1); 
				bezier.c1.multiplyEq(v2mag/smoothAmount);
				bezier.c1.plusEq(bezier.p1); 
				bezier.updateMagnitude(); 
				/*
				g.lineStyle(1,0x00ff00); 
				g.moveTo(lastBezier.p2.x, lastBezier.p2.z );
				g.lineTo(lastBezier.p2.x - (v1.x*20), lastBezier.p2.z - (v1.z*20));
				g.lineStyle(1,0x000ff); 
				g.moveTo(bezier.p1.x, bezier.p1.z );
				g.lineTo(bezier.p1.x + (v1.x*20), bezier.p1.z + (v1.z*20));
				*/
				lastBezier = bezier; 
			
				
				
			}
		}
		
		
		
		public function getPointAt(t : Number, targetV : Vector3 = null) : Vector3
		{
			if(!targetV) targetV = new Vector3(); 
			var bezierNum : int = 0; 
			var bezier : Bezier3 = beziers[0];
			var l : Number = bezier.magnitude; 
			var lastmag : Number = l; 
			 
			while((l/totalLength)<t)
			{
				bezierNum++; 
				bezier = beziers[bezierNum];
				lastmag = bezier.magnitude; 
				//trace("bezier ", bezier, lastmag); 
				l+=lastmag;
			}
			l-=lastmag; 
			var relativet : Number = (t-(l/totalLength)) / (lastmag/totalLength);
			
			targetV = bezier.getVector3AtT(relativet, targetV); 
			
			return (targetV);
			
				
		}
		public function renderXZ(g : Graphics, iterations : int = 100) : void
		{
			//g.lineStyle(1,0xffffff); 
			var bez : Bezier3 = beziers[0]; 
			g.moveTo(bez.p1.x, bez.p1.z);
			for(var i : Number = 0; i<=iterations; i+=1)
			{
				var pos : Vector3 = getPointAt(i/iterations);
				g.lineTo(pos.x, pos.z); 
				
			}
			bez = beziers[beziers.length-1];
			g.lineTo(bez.p2.x, bez.p2.z);
	
			
			/*
			for each(var b : Bezier3 in beziers)
			{
				g.lineStyle(1,0xff0000);
				g.moveTo(b.p1.x, b.p1.z);
				g.lineTo(b.c1.x, b.c1.z); 				
				g.lineStyle(1,0x00ff00);
				g.moveTo(b.p2.x, b.p2.z);
				g.lineTo(b.c2.x, b.c2.z); 				

			}*/
		}
		
		public function getClosestPoint(sourceVector : Vector3, iterations : int = 100) : Vector3
		{
			//trace("getClosestPoint");
			var point : Vector3 = new Vector3(); 
			var distance : Number = Number.MAX_VALUE; 
			var closestPoint : Vector3 = new Vector3(); 
			for(var i : int = 0; i< iterations; i++)
			{
				var t : Number = i/iterations; 
				point = getPointAt(t,point);
				var distanceFromSource : Number = point.getDistanceFromSquared(sourceVector);
				if(distance>distanceFromSource)
				{
					
					distance = distanceFromSource; 
					closestPoint.copyFrom(point); 
					//trace(i,sourceVector, point, closestPoint, distanceFromSource); 

				}
				
				
				
			}
			//trace("");
			return closestPoint; 
		}

		
	}
}
