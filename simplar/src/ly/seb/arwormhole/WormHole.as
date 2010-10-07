// Augmented Reality wormhole
// Author : Seb Lee-Delisle
// Blog : www.sebleedelisle.com
//
// This work is licenced under a Creative Commons Attribution-Noncommercial-Share Alike 2.0 UK: England & Wales License. 
// 
// Full details of the license are here : http://creativecommons.org/licenses/by-nc-sa/2.0/uk/
// mail me : seb@sebleedelisle.com
package ly.seb.arwormhole
{
	import flash.display.BitmapData;
	import flash.text.engine.EastAsianJustifier;
	
	import org.papervision3d.core.geom.renderables.Triangle3D;
	import org.papervision3d.core.geom.renderables.Vertex3D;
	import org.papervision3d.core.math.Number3D;
	import org.papervision3d.core.render.data.RenderSessionData;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Cylinder;
	
	public class WormHole extends Cylinder
	{
		
		public var vDistances : Array; 
		public var vPositions : Array; 
		
		public var referenceDisc : Cylinder; 
		
		public var bitmap : BitmapData; 
		
		
		public function WormHole(bitmap : BitmapData, scalex : Number, scaley : Number, radius:Number=100)
		{
			this.bitmap = bitmap; 
			var mat : BitmapMaterial = new BitmapMaterial(bitmap); 
			mat.smooth = true; 
//			mat.lineColor = 0xffffff; 
//			mat.lineThickness = 0; 
//			mat.lineAlpha = 1; 
			mat.doubleSided = true; 
			super(mat, radius, 0.01, 16, 12, 0, false, false);
			
			referenceDisc = new Cylinder(new ColorMaterial(0xff0000,0.1), radius, 0.01, 16, 12,0,false,false);
			addChild(referenceDisc); 
			
			calcDistances(radius); 
		}
		
		
		public function calcDistances(radius : Number) : void
		{
			var vertices : Array = geometry.vertices; 
			var num : Number3D ; 
			vDistances = new Array();
			vPositions = new Array(); 
			
			
			for(var i : int = 0; i< vertices.length; i++)
			{
				var v : Vertex3D = vertices[i]; 
				num = new Number3D (v.x,v.y,v.z); 
				vDistances.push((radius - num.modulo)/radius); 
				vPositions.push(num); 
				
			}
			
		}
		
		public function twist(deg : Number, depth : Number) : void
		{
			
			var vertices : Array = geometry.vertices; 
			
			var vertexcount : int = vertices.length; 
			var pos : Number3D = new Number3D; 
			
			for(var i:int = 0; i<vertexcount ; i++)
			{
				var distance : Number = vDistances[i];
				pos.copyFrom(vPositions[i]); 
				var rotation : Number = (distance)*deg; 
				if (rotation<0) rotation = 0; 
				
				pos.rotateY(rotation); 
				pos.y =  easeIn(distance, 0, depth, 4); 
				
				var v : Vertex3D = vertices[i]; 
				v.x = pos.x; 
				v.y = pos.y; 
				v.z = pos.z; 
				
			}
			
		}
		

		override public function project(parent:DisplayObject3D, renderSessionData : RenderSessionData) : Number
		{
			
			var num : Number = super.project(parent, renderSessionData); 
			updateUVs(renderSessionData);
			BitmapMaterial(material).resetUVS();
			
			return num; 
		}
		
		public function updateUVs(renderSessionData : RenderSessionData) : void 
		{
			var triangles : Array = geometry.faces; 
			var origTriangles : Array = referenceDisc.geometry.faces; 
			var bmWidth : Number = renderSessionData.viewPort.viewportWidth ; 
			var bmHeight : Number = renderSessionData.viewPort.viewportHeight; 
			var halfWidth : Number = bmWidth/2; 
			var halfHeight : Number = bmHeight/2; 
			
			
			var trianglecount : Number = triangles.length; 
			for (var i : int = 0; i<trianglecount; i++) 
			{
				var triangle : Triangle3D = triangles[i]; 
				var origTri : Triangle3D = origTriangles[i]
				
				triangle.uv0.u = (halfWidth + origTri.v0.vertex3DInstance.x-4) / bmWidth; 
				triangle.uv0.v = 1-(halfHeight + origTri.v0.vertex3DInstance.y) / bmHeight; 	
				
				
				triangle.uv1.u = (halfWidth + origTri.v1.vertex3DInstance.x-4) / bmWidth; 
				triangle.uv1.v = 1-(halfHeight + origTri.v1.vertex3DInstance.y) / bmHeight; 	
				triangle.uv2.u = (halfWidth + origTri.v2.vertex3DInstance.x-4) / bmWidth; 
				triangle.uv2.v = 1-(halfHeight + origTri.v2.vertex3DInstance.y) / bmHeight; 
					
				//trace(triangle.uv0, triangle.uv1, triangle.uv2);
				
							
			}
			
			
		}
		

		public function easeIn (t:Number, b:Number, c:Number, pow:int = 2, d:Number = 1):Number {
			return c*(t/=d)*t + b;
		} 
		
		
		
	}
}