package com.sebleedelisle.maths 
{
	import flash.display.LineScaleMode;
	import flash.display.Graphics;

	/**
	 * 
	 * @author Seb Lee-Delisle
	 */
	public class Spline3 
	{
		public var firstPoint : Vector3; 
		public var beziers : Array;
		public var points : Array; 
		public var controlPoints1 : Array; 
		public var controlPoints2 : Array; 
		
		public var lengths : Array;
		public var totalLength : Number; 

		public function Spline3() 
		{
			beziers = new Array(); 
			lengths = new Array(); 
			points = new Array(); 
			controlPoints1 = new Array(); 
			controlPoints2 = new Array(); 
			
			totalLength = 0; 
		}

		public function addPoint(p : Vector3, c1 : Vector3 = null, c2 : Vector3 = null) : void
		{
			if(!c1) c1 = p.clone(); 
			if(!c2) c2 = p.clone(); 
			
			points.push(p); 
			controlPoints1.push(c1); 
			controlPoints2.push(c2); 
			
			if(points.length>1)
			{
				//var lastPoint : Bezier3 = beziers[beziers.length-1];
				var bezier : Bezier3 = new Bezier3(points[points.length-2], controlPoints2[points.length-2], p, c1); 
				lengths.push(bezier.magnitude); 
				totalLength+=bezier.magnitude; 
				beziers.push(bezier); 
			}
			
			/*
			if(points.length)
			
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
			*/
		}
		
		public function createLoop() : void
		{
			//var lastBezier : Bezier3 = beziers[beziers.length-1];
			//var firstBezier : Bezier3 = beziers[0];
			//lastBezier.p2 = firstBezier.p1; 
			//addPoint(firstBezier.p1); 
			
			beziers.push(new Bezier3(points[points.length-1], controlPoints2[points.length-1], points[0], controlPoints1[0]));
		
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
		public function renderXZ(g : Graphics, iterations : int = 100, lineColour : int = 0xffffff, lineWeight : Number = 1, drawControlPoints : Boolean = false) : void
		{
			g.lineStyle(lineWeight, lineColour,1, false, LineScaleMode.NONE); 
			var bez : Bezier3 = beziers[0]; 
			g.moveTo(bez.p1.x, bez.p1.z);
			for(var i : Number = 0; i<=iterations; i+=1)
			{
				var pos : Vector3 = getPointAt(i/iterations);
				g.lineTo(pos.x, pos.z); 
				
			}
			bez = beziers[beziers.length-1];
			g.lineTo(bez.p2.x, bez.p2.z);
	
			
			if(drawControlPoints)
			{
				for (i =0 ; i< points.length; i++)
				{
					var p1 : Vector3 = points[i];
					var c1 : Vector3 = controlPoints1[i];
					 
					
					g.beginFill(0xffffff); 
					g.drawCircle(p1.x, p1.z, 4);
					
					g.lineStyle(0,0xff0000,0.5);
					g.moveTo(p1.x, p1.z);
					g.lineTo(c1.x, c1.z); 
					g.drawCircle(c1.x, c1.z, 2);			
					
					if(i>0)
					{
						var c2 : Vector3 = controlPoints2[i-1]; 
					
						g.lineStyle(0,0x00ff00, 0.5);
						g.moveTo(p1.x, p1.z);
						g.lineTo(c2.x, c2.z); 
						g.drawCircle(c2.x, c2.z, 2);			
					}			
	
				}
			}
		}
		
		/*
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
		*/

		public function multiplyEq(v : Number) : void
		{
			for(var i : int = 0; i< points.length; i++)
			{
				var p1 : Vector3 = points[i];
				var c1 : Vector3 = controlPoints1[i];
				var c2 : Vector3 = controlPoints2[i];
				p1.multiplyEq(v); 
				c1.multiplyEq(v); 
				c2.multiplyEq(v); 
				
			}
			
		}
		
	}
}
