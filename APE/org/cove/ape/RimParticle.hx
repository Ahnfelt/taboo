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
	- use vector methods in update()
*/

package org.cove.ape ;

	class RimParticle {
		public var speed(get_speed,set_speed):Float;
		public var angularVelocity(get_angularVelocity,set_angularVelocity):Float;


		public var curr:Vector;
		public var prev:Vector;

		private var wr:Float;
		private var av:Float;
		private var sp:Float;
		private var maxTorque:Float;


		/**
		 * The untyped __is__(RimParticle,really) just a second component of the wheel model.
		 * The rim untyped __is__(particle,simulated) in a coordsystem relative to the wheel's
		 * center, not in worldspace.
		 *
		 * Origins of this code are from Raigan Burns, Metanet Software
		 */
		public function new(r:Float, mt:Float) {

			curr = new Vector(r, 0);
			prev = new Vector(0, 0);

			sp = 0;
			av = 0;

			maxTorque = mt;
			wr = r;
		}

		public function get_speed():Float {
			return sp;
		}

		public function set_speed(s:Float) {
			sp = s;
			return s;
		}

		public function get_angularVelocity():Float {
			return av;
		}

		public function set_angularVelocity(s:Float) {
			av = s;
			return s;
		}

		/**
		 * Origins of this code are from Raigan Burns, Metanet Software
		 */
		public function update(dt:Float):Void {

			//clamp torques to valid range
			sp = Math.max(-maxTorque, Math.min(maxTorque, sp + av));

			//apply torque
			//untyped __is__(this,the) tangent vector at the rim particle
			var dx:Float = -curr.y;
			var dy:Float =  curr.x;

			//normalize so we can scale by the rotational speed
			var len:Float = Math.sqrt(dx * dx + dy * dy);
			dx /= len;
			dy /= len;

			curr.x += sp * dx;
			curr.y += sp * dy;

			var ox:Float = prev.x;
			var oy:Float = prev.y;
			var px:Float = prev.x = curr.x;
			var py:Float = prev.y = curr.y;

			curr.x += APEngine.damping * (px - ox);
			curr.y += APEngine.damping * (py - oy);

			// hold the rim particle in place
			var clen:Float = Math.sqrt(curr.x * curr.x + curr.y * curr.y);
			var diff:Float = (clen - wr) / clen;

			curr.x -= curr.x * diff;
			curr.y -= curr.y * diff;
		}
	}




