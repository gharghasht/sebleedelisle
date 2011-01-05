﻿package com.sebleedelisle.maths {	import flash.geom.Point;	 	public class Vector2 {				public var x : Number; 		public var y : Number; 				public static var TO_DEGREES : Number = 180 / Math.PI;				public static var TO_RADIANS : Number = Math.PI / 180;				public static var temp : Vector2 = new Vector2(); 				public function Vector2 (x:Number = 0, y:Number = 0)		{			this.x = x; 			this.y = y; 		}				public function toString(decPlaces : int = 3):String		{			var scalar : Number = Math.pow(10,decPlaces); 			return "[" + Math.round (x * scalar) / scalar + ", " + Math.round (y * scalar) / scalar + "]";		}				public function clone():Vector2		{			return new Vector2(x, y);		}				public function copyTo(v:Vector2):void		{			v.x = x;			v.y = y;		}		public function copyFrom(v:Vector2):void		{			x = v.x;			y = v.y;		}					public function magnitude():Number 		{			return Math.sqrt((x*x)+(y*y));		}		public function magnitudeSquared() : Number 		{			return (x*x)+(y*y);		}		public function normalise() : Vector2 		{			var m:Number = magnitude();						//if (m<=tol) m = 1;						x = x/m;			y = y/m;				return this;			}				public function reverse():void 		{			x = -x;			y = -y;		}				public function plusEq(v:Vector2): void 		{			x+=v.x;			y+=v.y;		}				public function plusNew(v:Vector2):Vector2		{			 return new Vector2(x+v.x, y+v.y); 		}				public function minusEq(v:Vector2): void 		{				x-=v.x;				y-=v.y;		}		public function minusNew(v:Vector2):Vector2		{		 	return new Vector2(x-v.x, y-v.y); 		}					public function multiplyEq(value:Number): void		{			x*=value;			y*=value;		}				public function multiplyNew(v:Number):Vector2		{			var returnvec:Vector2 = clone();			returnvec.multiplyEq(v);			return returnvec;		}				public function dividedEq(value:Number): void		{			x/=value;			y/=value;		}				public function divideNew(v:Number):Vector2		{			var returnvec:Vector2 = clone();			returnvec.dividedEq(v);			return returnvec;		}			public function dot(v:Vector2):Number		{			return (x * v.x) + (y * v.y) ;		}				public function angle(useDegrees : Boolean = true):Number		{			if(useDegrees)				return Math.atan2(y,x) * TO_DEGREES;			else				return Math.atan2(y,x) ;					}				public function rotate(angle:Number) :void		{						var cosRY:Number = Math.cos(angle * TO_RADIANS);			var sinRY:Number = Math.sin(angle * TO_RADIANS);						temp.copyFrom(this); 			x= (temp.x*cosRY)-(temp.y*sinRY);			y= (temp.x*sinRY)+(temp.y*cosRY);					}					public function  rotateAroundPoint(point:Vector2, angle:Number):void		{			temp.copyFrom(this); 			//trace("rotate around point "+t+" "+point+" " +angle);			temp.minusEq(point);			//trace("after subtract "+t);			temp.rotate(angle);			//trace("after rotate "+t);			temp.plusEq(point);			//trace("after add "+t);			copyFrom(temp);					}				public function reset(x:Number, y:Number) :void		{						this.x = x;			this.y = y;			}				public function isCloseTo(v:Vector2, distance:Number):Boolean		{						if(this.isEqualTo(v)) return true;						temp.copyFrom(this); 			temp.minusEq(v); 						return(temp.magnitudeSquared() < distance*distance);		}					public function isMagLessThan(distance:Number):Boolean		{			return(magnitudeSquared()<distance*distance);		}				public function isMagGreaterThan(distance:Number):Boolean		{			return(magnitudeSquared()>distance*distance);		}  		public function projectOnto(v:Vector2) : Vector2		{ 			var dp:Number = dot(v); 			var f:Number = dp / ( v.x*v.x + v.y*v.y ); 			return new Vector2( f*v.x , f*v.y); 		}				public function convertToNormal():void		{			var tempx:Number = x; 			x = -y; 			y = tempx; 								}				public function getNormal():Vector2		{						return new Vector2(-y,x); 					}				public function isEqualTo(v:Vector2) : Boolean		{			return((x==v.x)&&(y==v.x));		} 			public function getClosestPointOnLine ( vectorposition : Point, targetpoint : Point ) : Point		{			var m1 : Number = y / x ;			var m2 : Number = x / -y ;						var b1 : Number = vectorposition.y - ( m1 * vectorposition.x ) ;			var b2 : Number = targetpoint.y - ( m2 * targetpoint.x ) ;						var cx : Number = ( b2 - b1 ) / ( m1 - m2 ) ;			var cy : Number = m1 * cx + b1 ;						return new Point ( cx, cy ) ;		}				}			}