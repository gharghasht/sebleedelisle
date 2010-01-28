package  
com.sebleedelisle.physics3d
{
	import org.papervision3d.core.math.Number3D;

	import flash.utils.getTimer;

	/**
	 * @author Seb Lee-Delisle
	 */
	public class CollisionTests 
	{
		static public var cor : Number = 0.7; 
		
		static public function getCircleCircleCollisionTime(x1 : Number, y1 : Number, dx1 : Number, dy1 : Number, x2 : Number, y2 : Number, dx2 : Number, dy2 : Number, r1 : Number, r2 : Number) : Number
		{
			var a : Number, b : Number, c : Number, dist : Number, t : Number;
			
			dist = r1+r2;
			
			a = sqrd(dx2-dx1)+sqrd(dy2-dy1);
			b = 2*(x1*(dx1-dx2)+x2*(dx2-dx1)+y1*(dy1-dy2)+y2*(dy2-dy1));
			c = sqrd(x2-x1)+sqrd(y2-y1)-sqrd(dist);
			t = (-b-Math.sqrt((sqrd(b))-(4*a*c)))/(2*a);
			
			if (t && t>0 && t<1) 
			{
				return t;
			}
			return NaN;
		}
		
		
		static public function getSphereSphereCollisionTime(sphere1 : PhysicsSphereBase, sphere2 : PhysicsSphereBase) : Number
		{
			var x1 : Number = sphere1.x; 
			var y1 : Number = sphere1.y; 
			var z1 : Number = sphere1.z; 
			var dx1 : Number = sphere1.vel.x; 
			var dy1 : Number = sphere1.vel.y; 
			var dz1 : Number = sphere1.vel.z;
			var x2 : Number = sphere2.x; 
			var y2 : Number = sphere2.y; 
			var z2 : Number = sphere2.z; 
			var dx2 : Number = sphere2.vel.x; 
			var dy2 : Number = sphere2.vel.y; 
			var dz2 : Number = sphere2.vel.z;
			var r1 : Number = sphere1.radius; 
			var r2 : Number = sphere2.radius; 
			
			var a : Number, b : Number, c : Number, dist : Number, t : Number;
			
			dist = r1+r2;
			
			a = sqrd(dx2-dx1) + sqrd(dy2-dy1) + sqrd(dz2-dz1);
			b = 2*(x1*(dx1-dx2)+x2*(dx2-dx1)+y1*(dy1-dy2)+y2*(dy2-dy1) + z1*(dz1-dz2)+z2*(dz2-dz1));
			c = sqrd(x2-x1) + sqrd(y2-y1) + sqrd(z2-z1) - sqrd(dist);
			t = (-b-Math.sqrt((sqrd(b))-(4*a*c)))/(2*a);
			
			if (t && t>=0 && t<=1) 
			{
				return t;
			}
			return NaN;
		}
	
		static public function sqrd(value : Number ) : Number
		{
			return value * value; 
		}
	
		static public function sphereSphereReaction(t : Number, sphere1 : PhysicsSphereBase, sphere2 : PhysicsSphereBase) : void
		{
				
			sphere1.updateNewPosToTime(t); 
			sphere2.updateNewPosToTime(t); 
			
			var collisionNormal : Number3D = sphere2.newPosition.clone(); 
			collisionNormal.minusEq(sphere1.newPosition); 
			collisionNormal.normalize(); 
			
			var vel : Number3D = sphere1.vel.clone();
			vel.minusEq(sphere2.vel); 
			
			var vn : Number = Number3D.dot(vel, collisionNormal); 
			// if spheres collided but are already moving away from each other 
			// (poss not needed for predictive method)
			//if(vn>0) then we should break out... 
			
			
			// this is the strength of the collision
			var i : Number = -(1 + cor) * vn;
			
			if((!sphere1.immovable) && (!sphere2.immovable)) i /= (sphere1.radius + sphere2.radius);
			
			var collisionImpulse : Number3D = collisionNormal.clone(); 
			collisionImpulse.multiplyEq(i);
			
			if(!sphere1.immovable)
			{
				var impulse1 : Number3D = collisionImpulse.clone(); 
				if(!sphere2.immovable) impulse1.multiplyEq(sphere2.radius); 
				sphere1.vel.plusEq(impulse1); 
			}
			if(!sphere2.immovable)
			{
				var impulse2 : Number3D = collisionImpulse.clone(); 
				if(!sphere1.immovable) impulse2.multiplyEq(-sphere1.radius); 
				sphere2.vel.plusEq(impulse2); 
			}
		}
		
		
		static public function getSpherePlaneCollisionTime(sphere : PhysicsSphereBase, plane : PhysicsPlane) : Number
		{
			
			// the signed distance between the sphere and the plane now
			var d0 : Number = plane.distanceToPoint(sphere.position);
			
			// the signed distance between the sphere and the plane in the next frame 
			var d1 : Number = plane.distanceToPoint(sphere.newPosition); 
			
			if((Math.abs(d0)<sphere.radius) || (d0==d1))
			{
				//plane is already intersecting!
				//do something!!!
				//trace(getTimer(), "ALREADY INTERSECTING", d0, sphere.radius);
				
				if(pointInTriangle(sphere.position, plane.topLeft, plane.topRight, plane.botLeft) || pointInTriangle(sphere.position, plane.topRight, plane.botRight, plane.botLeft))
				{
					
				
					// move it back 
					var correction : Number3D = plane.normal.clone(); 
					correction.multiplyEq((sphere.radius - d0 ));
				//	trace(sphere.radius, d0, correction); 
					correction.plusEq(sphere.position); 
					//sphere.position = correction; 
					sphere.position.copyFrom(correction); 
					//sphere.newPosition.copyFrom(correction); 
					
					correction.copyFrom(plane.normal); 
					var impulse : Number = Number3D.dot(sphere.vel, plane.normal); 
					correction.multiplyEq(impulse * (-1-cor));
					sphere.vel.plusEq(correction); 
					sphere.updateNewPosToTime(1);
					//trace("FIXED", correction, plane.distanceToPoint(sphere.position));
			
				}
				return NaN; //(d0-sphere.radius)/ (d0-d1); 
				
			}
			
			if((d0>sphere.radius) && (d1<sphere.radius))
			{
				// get the point that the sphere is at when it collides. 
				var t : Number = (d0-sphere.radius)/ (d0-d1); 
				var collisionpoint : Number3D = sphere.vel.clone(); 
				collisionpoint.multiplyEq(t);
				collisionpoint.plusEq(sphere.position);

				// now move along the normal to the actual collision point
				var intersectionpoint : Number3D = plane.normal.clone(); 
				intersectionpoint.multiplyEq(sphere.radius);
				intersectionpoint.plusEq(collisionpoint); 
				
				// now check intersection point is within the plane bounds
				if(pointInTriangle(intersectionpoint, plane.topLeft, plane.topRight, plane.botLeft) || pointInTriangle(intersectionpoint, plane.topRight, plane.botRight, plane.botLeft))
				{
					return t; 
				} 
				
				
				
				return NaN; 	
			}
			return NaN; 
		}
		
		
		static public function sameSide(p1 : Number3D, p2 : Number3D , a : Number3D, b : Number3D) : Boolean
		{
			var bMinusA : Number3D = Number3D.sub(b,a); 
		    var cp1 : Number3D = Number3D.cross(bMinusA, Number3D.sub(p1, a));
		    var cp2 : Number3D = Number3D.cross(bMinusA, Number3D.sub(p2, a));
		    
		    if (Number3D.dot(cp1, cp2) >= 0) return true;
		    else return false;
		}
		
		static public function pointInTriangle(p : Number3D, a : Number3D, b : Number3D, c : Number3D) : Boolean
	    {
	    	if (sameSide(p,a, b,c) && sameSide(p,b, a,c) && sameSide(p,c, a,b))  
	    		return true;
	    	else 
	    		return false;
	    }
		
		static public function spherePlaneReaction(t : Number, sphere : PhysicsSphereBase, plane : PhysicsPlane) : void
		{
			
			sphere.updateNewPosToTime(t);


			// this is the power of the collision : 
			
			var impulse : Number = Number3D.dot(sphere.vel, plane.normal); 
			//if(impulse>=-2) trace("IMPULSE", impulse); 
			var collisionResponse : Number3D = plane.normal.clone(); 
			collisionResponse.multiplyEq(impulse *(-1 - cor)); 
			
			sphere.vel.plusEq(collisionResponse); 			
			
			
		}
		
	}
}
