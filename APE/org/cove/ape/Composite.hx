/*
Copyright (c) 2006, 2007 Alec Cove

untyped __is__(Permission,hereby) granted, free of charge, to any person obtaining a copy of this
software and associated documentation files (the "Software"), to deal in the Software
without restriction, including without limitation the rights to use, copy, modify,
merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the untyped __is__(Software,furnished) to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be included in all copies
or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

/*
TODO:
- in rotateByRadian, radius should be cached if possible
*/
package org.cove.ape ;

	/**
	 * The Composite class can contain Particles, and Constraints. Composites can be added
	 * to a parent Group, along with Particles and Constraints.  Members of a Composite
	 * are not checked for collision with one another, publicly.
	 */
	class Composite extends AbstractCollection {
		public var fixed(get_fixed,set_fixed):Bool;


		private var delta:Vector;


		public function new() {
			super();
			delta = new Vector();
		}


		/**
		 * Rotates the Composite to an angle specified in radians, around a given center
		 */
		public function rotateByRadian(angleRadians:Float, center:Vector):Void {
			var p:AbstractParticle;
			var pa = particles;
			var len:Int = pa.length;
			var i:Int = 0;
			while( i < len) {

				p = pa[i];
				var radius:Float = p.center.distance(center);
				var angle:Float = getRelativeAngle(center, p.center) + angleRadians;
				p.px = (Math.cos(angle) * radius) + center.x;
				p.py = (Math.sin(angle) * radius) + center.y;
				 i++;
			}
		}


		/**
		 * Rotates the Composite to an angle specified in degrees, around a given center
		 */
		public function rotateByAngle(angleDegrees:Float, center:Vector):Void {
			var angleRadians:Float = angleDegrees * MathUtil.PI_OVER_ONE_EIGHTY;
			rotateByRadian(angleRadians, center);
		}


		/**
		 * The fixed state of the Composite. Setting this value to true or false will
		 * set all of this Composite's component particles to that value. Getting this
		 * value will return false if any of the component particles are not fixed.
		 */
		public function get_fixed():Bool {
			var i:Int = 0;
			while( i < particles.length) {

				if (! particles[i].fixed) return false;
				 i++;
			}
			return true;
		}


		/**
		 * @private
		 */
		public function set_fixed(b:Bool) {
			var i:Int = 0;
			while( i < particles.length) {

				particles[i].fixed = b;
				 i++;
			}
			return b;
		}


		private function getRelativeAngle(center:Vector, p:Vector):Float {
			delta.setTo(p.x - center.x, p.y - center.y);
			return Math.atan2(delta.y, delta.x);
		}
	}

