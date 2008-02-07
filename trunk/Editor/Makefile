all: *.hx
	haxe -swf Editor.swf -swf-version 9 -swf-header 800:600:60:000000 -cp ../APE -main Main.hx

run: all index.htm
	firefox --new-window index.htm &

clean:
	rm -f Editor.swf

