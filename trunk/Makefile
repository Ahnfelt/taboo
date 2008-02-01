all: Main.hx Player.hx Key.hx
	haxe -swf Game.swf -swf-version 9 -swf-header 800:600:60:000000 -cp APE -main Main.hx

run: all index.htm
	firefox --new-window index.htm &

clean:
	rm -f Game.swf

