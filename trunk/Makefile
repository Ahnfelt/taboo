all: *.hx test.svg
	haxe -swf Game.swf -swf-version 9 -swf-header 800:600:60:000000 -resource test.svg@test.svg -cp APE -main Example.hx

pointzero: pointzeroLib
	haxe -swf Game.swf -swf-version 9 -swf-header 800:600:60:000000 -main PointZeroTest.hx

pointzeroLib:
	haxe pointzero/util/List.hx
	haxe pointzero/util/ListItem.hx
	haxe pointzero/util/ListIterator.hx
	haxe pointzero/contact/Contact.hx
	haxe pointzero/contact/ContactGenerator.hx
	haxe pointzero/contact/ContactResolver.hx
	haxe pointzero/RigidBody.hx
	haxe pointzero/PointZeroEngine.hx

pointzerorun: pointzero
	firefox --new-window index.htm &

run: all index.htm
	firefox --new-window index.htm &

clean:
	rm -f Game.swf

