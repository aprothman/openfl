package openfl.display;


import lime.graphics.RendererType;
import openfl.display.BlendMode;
import openfl.display.DisplayObject;
import openfl.display.Stage;
import openfl.events.EventDispatcher;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;

#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end

@:allow(openfl._internal.renderer)
@:allow(openfl.display)


class DisplayObjectRenderer extends EventDispatcher {
	
	
	private var __allowSmoothing:Bool;
	private var __blendMode:BlendMode;
	private var __displayMatrix:Matrix;
	private var __roundPixels:Bool;
	private var __stage:Stage;
	private var __transparent:Bool;
	private var __type:RendererType;
	
	
	private function new () {
		
		super ();
		
		__allowSmoothing = true;
		
	}
	
	
	private function __clear ():Void {
		
		
		
	}
	
	
	private function __popMask ():Void {
		
		
		
	}
	
	
	private function __popMaskObject (object:DisplayObject, handleScrollRect:Bool = true):Void {
		
		
		
	}
	
	
	private function __popMaskRect ():Void {
		
		
		
	}
	
	
	private function __pushMask (mask:DisplayObject):Void {
		
		
		
	}
	
	
	private function __pushMaskObject (object:DisplayObject, handleScrollRect:Bool = true):Void {
		
		
		
	}
	
	
	private function __pushMaskRect (rect:Rectangle, transform:Matrix):Void {
		
		
		
	}
	
	
	private function __render (object:IBitmapDrawable):Void {
		
		
		
	}
	
	
	private function __renderStage3D (stage:Stage):Void {
		
		
		
	}
	
	
	private function __resize (width:Int, height:Int):Void {
		
		
		
	}
	
	
	private function __setBlendMode (value:BlendMode):Void {
		
		
		
	}
	
	
}