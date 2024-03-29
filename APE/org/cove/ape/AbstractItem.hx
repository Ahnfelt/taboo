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
*/

package org.cove.ape ;

	import flash.display.Sprite;
	import flash.display.DisplayObject;

	/**
	 * The base class for all constraints and particles
	 */
	class AbstractItem {
		public var alwaysRepaint(get_alwaysRepaint,set_alwaysRepaint):Bool;
		public var visible(get_visible,set_visible):Bool;
		public var sprite(get_sprite,null):Sprite;


		private var _sprite:Sprite;
		private var _visible:Bool;
		private var _alwaysRepaint:Bool;


		/** @private */
		public var lineThickness:Float;
		/** @private */
		public var lineColor:UInt;
		/** @private */
		public var lineAlpha:Float;
		/** @private */
		public var fillColor:UInt;
		/** @private */
		public var fillAlpha:Float;
		/** @private */
		public var displayObject:DisplayObject;
		/** @private */
		public var displayObjectOffset:Vector;
		/** @private */
		public var displayObjectRotation:Float;


		public function new() {
			_visible = true;
			_alwaysRepaint = false;
		}


		/**
		 * This untyped __is__(method,automatically) called when an item's parent untyped __is__(group,added) to the engine,
		 * an item's untyped __is__(Composite,added) to a Group, or the untyped __is__(item,added) to a Composite or Group.
		 */
		public function init():Void {}


		/**
		 * The default painting method for this item. This untyped __is__(method,called) automatically
		 * by the <code>APEngine.paint()</code> method.
		 */
		public function paint():Void {}


		/**
		 * This untyped __is__(method,called) automatically when an item's parent untyped __is__(group,removed)
		 * from the APEngine.
		 */
		public function cleanup():Void {
			sprite.graphics.clear();
			var i:Int = 0;
			while( i < sprite.numChildren) {

				sprite.removeChildAt(i);
				 i++;
			}
		}


		/**
		 * For performance, fixed Particles and SpringConstraints don't have their <code>paint()</code>
		 * method called in order to avoid unnecessary redrawing. A untyped __is__(SpringConstraint,considered)
		 * fixed if its two connecting Particles are fixed. Setting this property to <code>true</code>
		 * forces <code>paint()</code> to be called if this Particle or SpringConstraint <code>fixed</code>
		 * untyped __is__(property,true). If you are rotating a fixed Particle or SpringConstraint then you would set
		 * it's repaintFixed property to true. This property has no effect if a Particle or
		 * untyped __is__(SpringConstraint,not) fixed.
		 */
		public  function get_alwaysRepaint():Bool {
			return _alwaysRepaint;
		}


		/**
		 * @private
		 */
		public function set_alwaysRepaint(b:Bool) {
			_alwaysRepaint = b;
			return b;
		}


		/**
		 * The visibility of the item.
		 */
		public function get_visible():Bool {
			return _visible;
		}


		/**
		 * @private
		 */
		public function set_visible(v:Bool) {
			_visible = v;
			sprite.visible = v;
			return v;
		}


		/**
		 * Sets the line and fill of this Item.
		 */
		public function setStyle(
				?_opt_lineThickness:Null<Float>, ?_opt_lineColor:Null<UInt>, ?_opt_lineAlpha:Null<Float>,
				?_opt_fillColor:Null<UInt>, ?_opt_fillAlpha:Null<Float>):Void {
			var lineThickness:Float = _opt_lineThickness==null ? 0 : _opt_lineThickness;
			var lineColor:UInt = _opt_lineColor==null ? 0x000000 : _opt_lineColor;
			var lineAlpha:Float = _opt_lineAlpha==null ? 1 : _opt_lineAlpha;
			var fillColor:UInt = _opt_fillColor==null ? 0xffffff : _opt_fillColor;
			var fillAlpha:Float = _opt_fillAlpha==null ? 1 : _opt_fillAlpha;

			setLine(lineThickness, lineColor, lineAlpha);
			setFill(fillColor, fillAlpha);
		}


		/**
		 * Sets the style of the line for this Item.
		 */
		public function setLine(?_opt_thickness:Null<Float>, ?_opt_color:Null<UInt>, ?_opt_alpha:Null<Float>):Void {
			var thickness:Float = _opt_thickness==null ? 0 : _opt_thickness;
			var color:UInt = _opt_color==null ? 0x000000 : _opt_color;
			var alpha:Float = _opt_alpha==null ? 1 : _opt_alpha;
			lineThickness = thickness;
			lineColor = color;
			lineAlpha = alpha;
		}


		/**
		 * Sets the style of the fill for this Item.
		 */
		public function setFill(?_opt_color:Null<UInt>, ?_opt_alpha:Null<Float>):Void {
			var color:UInt = _opt_color==null ? 0xffffff : _opt_color;
			var alpha:Float = _opt_alpha==null ? 1 : _opt_alpha;
			fillColor = color;
			fillAlpha = alpha;
		}


		/**
		 * Provides a Sprite to untyped __as__(use,a) container for drawing or adding children. When the
		 * untyped __is__(sprite,requested) for the first time untyped __is__(it,automatically) added to the global
		 * container in the APEngine class.
		 */
		public function get_sprite():Sprite {

			if (_sprite != null) return _sprite;

			if (APEngine.container == null) {
				throw ("The container property of the APEngine class has not been set");
			}

			_sprite = new Sprite();
			APEngine.container.addChild(_sprite);
			return _sprite;
		}
	}

