package openfl.display;

#if !flash
// TODO: Force keeping of SWF symbols a different way?
import openfl._internal.formats.swf.SWFLite;
import openfl._internal.symbols.BitmapSymbol;
import openfl._internal.symbols.ButtonSymbol;
import openfl._internal.symbols.DynamicTextSymbol;
import openfl._internal.symbols.FontSymbol;
import openfl._internal.symbols.ShapeSymbol;
import openfl._internal.symbols.SpriteSymbol;
import openfl._internal.symbols.StaticTextSymbol;
import openfl._internal.symbols.SWFSymbol;
import openfl._internal.symbols.timeline.Frame;
import openfl._internal.symbols.timeline.FrameObject;
import openfl._internal.symbols.timeline.FrameObjectType;
import openfl._internal.utils.Timeline;
import openfl.events.MouseEvent;
import openfl.filters.BitmapFilter;
import openfl.filters.BlurFilter;
import openfl.filters.ColorMatrixFilter;
import openfl.filters.ConvolutionFilter;
import openfl.filters.DisplacementMapFilter;
import openfl.filters.DropShadowFilter;
import openfl.filters.GlowFilter;

/**
	The MovieClip class inherits from the following classes: Sprite,
	DisplayObjectContainer, InteractiveObject, DisplayObject, and
	EventDispatcher.

	Unlike the Sprite object, a MovieClip object has a timeline.

	In Flash Professional, the methods for the MovieClip class provide the
	same functionality as actions that target movie clips. Some additional
	methods do not have equivalent actions in the Actions toolbox in the
	Actions panel in the Flash authoring tool.

	Children instances placed on the Stage in Flash Professional cannot be
	accessed by code from within the constructor of a parent instance since
	they have not been created at that point in code execution. Before
	accessing the child, the parent must instead either create the child
	instance by code or delay access to a callback function that listens for
	the child to dispatch its `Event.ADDED_TO_STAGE` event.

	If you modify any of the following properties of a MovieClip object that
	contains a motion tween, the playhead is stopped in that MovieClip object:
	`alpha`, `blendMode`, `filters`,
	`height`, `opaqueBackground`, `rotation`,
	`scaleX`, `scaleY`, `scale9Grid`,
	`scrollRect`, `transform`, `visible`,
	`width`, `x`, or `y`. However, it does not
	stop the playhead in any child MovieClip objects of that MovieClip
	object.

	**Note:**Flash Lite 4 supports the MovieClip.opaqueBackground
	property only if FEATURE_BITMAPCACHE is defined. The default configuration
	of Flash Lite 4 does not define FEATURE_BITMAPCACHE. To enable the
	MovieClip.opaqueBackground property for a suitable device, define
	FEATURE_BITMAPCACHE in your project.
**/
#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
@:access(openfl._internal.symbols.SWFSymbol)
@:access(openfl.geom.ColorTransform)
class MovieClip extends Sprite #if (openfl_dynamic && haxe_ver < "4.0.0") implements Dynamic<DisplayObject> #end
{
	@:noCompletion private static var __constructor:MovieClip->Void;
	@:noCompletion private static var __initSWF:SWFLite;
	@:noCompletion private static var __initSymbol:SpriteSymbol;
	#if 0
	// Suppress checkstyle warning
	private static var __unusedImport:Array<Class<Dynamic>> = [
		BitmapSymbol, ButtonSymbol, DynamicTextSymbol, FontSymbol, ShapeSymbol, SpriteSymbol, StaticTextSymbol, SWFSymbol, BlurFilter, ColorMatrixFilter,
		ConvolutionFilter, DisplacementMapFilter, DropShadowFilter, GlowFilter
	];
	#end

	/**
		Specifies the number of the frame in which the playhead is located in the
		timeline of the MovieClip instance. If the movie clip has multiple scenes,
		this value is the frame number in the current scene.
	**/
	public var currentFrame(get, never):Int;

	/**
		The label at the current frame in the timeline of the MovieClip instance.
		If the current frame has no label, `currentLabel` is
		`null`.
	**/
	public var currentFrameLabel(get, never):String;

	/**
		The current label in which the playhead is located in the timeline of the
		MovieClip instance. If the current frame has no label,
		`currentLabel` is set to the name of the previous frame that
		includes a label. If the current frame and previous frames do not include
		a label, `currentLabel` returns `null`.
	**/
	public var currentLabel(get, never):String;

	/**
		Returns an array of FrameLabel objects from the current scene. If the
		MovieClip instance does not use scenes, the array includes all frame
		labels from the entire MovieClip instance.
	**/
	public var currentLabels(get, never):Array<FrameLabel>;

	/**
		A Boolean value that indicates whether a movie clip is enabled. The
		default value of `enabled` is `true`. If
		`enabled` is set to `false`, the movie clip's Over,
		Down, and Up frames are disabled. The movie clip continues to receive
		events(for example, `mouseDown`, `mouseUp`,
		`keyDown`, and `keyUp`).

		The `enabled` property governs only the button-like
		properties of a movie clip. You can change the `enabled`
		property at any time; the modified movie clip is immediately enabled or
		disabled. If `enabled` is set to `false`, the object
		is not included in automatic tab ordering.
	**/
	public var enabled(get, set):Bool;

	/**
		The number of frames that are loaded from a streaming SWF file. You can
		use the `framesLoaded` property to determine whether the
		contents of a specific frame and all the frames before it loaded and are
		available locally in the browser. You can also use it to monitor the
		downloading of large SWF files. For example, you might want to display a
		message to users indicating that the SWF file is loading until a specified
		frame in the SWF file finishes loading.

		If the movie clip contains multiple scenes, the
		`framesLoaded` property returns the number of frames loaded for
		_all_ scenes in the movie clip.
	**/
	public var framesLoaded(get, never):Int;

	public var isPlaying(get, never):Bool;

	// @:noCompletion @:dox(hide) public var scenes (default, never):Array<openfl.display.Scene>;

	/**
		The total number of frames in the MovieClip instance.

		If the movie clip contains multiple frames, the
		`totalFrames` property returns the total number of frames in
		_all_ scenes in the movie clip.
	**/
	public var totalFrames(get, never):Int;

	// @:noCompletion @:dox(hide) public var trackAsMenu:Bool;
	@:noCompletion private var __enabled:Bool;
	@:noCompletion private var __hasDown:Bool;
	@:noCompletion private var __hasOver:Bool;
	@:noCompletion private var __hasUp:Bool;
	@:noCompletion private var __mouseIsDown:Bool;
	@:noCompletion private var __swf:SWFLite;
	@:noCompletion private var __symbol:SpriteSymbol;
	@:noCompletion private var __timeline:Timeline;

	#if openfljs
	@:noCompletion private static function __init__()
	{
		untyped Object.defineProperties(MovieClip.prototype, {
			"currentFrame": {get: untyped __js__("function () { return this.get_currentFrame (); }")},
			"currentFrameLabel": {get: untyped __js__("function () { return this.get_currentFrameLabel (); }")},
			"currentLabel": {get: untyped __js__("function () { return this.get_currentLabel (); }")},
			"currentLabels": {get: untyped __js__("function () { return this.get_currentLabels (); }")},
			"enabled": {
				get: untyped __js__("function () { return this.get_enabled (); }"),
				set: untyped __js__("function (v) { return this.set_enabled (v); }")
			},
			"framesLoaded": {get: untyped __js__("function () { return this.get_framesLoaded (); }")},
			"isPlaying": {get: untyped __js__("function () { return this.get_isPlaying (); }")},
			"totalFrames": {get: untyped __js__("function () { return this.get_totalFrames (); }")},
		});
	}
	#end

	/**
		Creates a new MovieClip instance. After creating the MovieClip, call the
		`addChild()` or `addChildAt()` method of a display
		object container that is onstage.
	**/
	public function new()
	{
		super();

		__enabled = true;

		if (__constructor != null)
		{
			var method = __constructor;
			__constructor = null;

			method(this);
		}
		else if (__initSymbol != null)
		{
			__swf = __initSWF;
			__symbol = __initSymbol;

			__initSWF = null;
			__initSymbol = null;

			__fromSymbol(__swf, __symbol);
		}
	}

	public function addFrameScript(index:Int, method:Void->Void):Void
	{
		if (__timeline != null)
		{
			__timeline.addFrameScript(index, method);
		}
	}

	public static function fromTimeline(timeline:ITimeline):MovieClip
	{
		var movieClip = new MovieClip();
		movieClip.__timeline = new Timeline(movieClip, timeline);
		movieClip.play();
		return movieClip;
	}

	/**
		Starts playing the SWF file at the specified frame. This happens after all
		remaining actions in the frame have finished executing. To specify a scene
		as well as a frame, specify a value for the `scene` parameter.

		@param frame A number representing the frame number, or a string
					 representing the label of the frame, to which the playhead is
					 sent. If you specify a number, it is relative to the scene
					 you specify. If you do not specify a scene, the current scene
					 determines the global frame number to play. If you do specify
					 a scene, the playhead jumps to the frame number in the
					 specified scene.
		@param scene The name of the scene to play. This parameter is optional.
	**/
	public function gotoAndPlay(frame:#if (haxe_ver >= "3.4.2") Any #else Dynamic #end, scene:String = null):Void
	{
		if (__timeline != null)
		{
			__timeline.gotoAndPlay(frame, scene);
		}
	}

	/**
		Brings the playhead to the specified frame of the movie clip and stops it
		there. This happens after all remaining actions in the frame have finished
		executing. If you want to specify a scene in addition to a frame, specify
		a `scene` parameter.

		@param frame A number representing the frame number, or a string
					 representing the label of the frame, to which the playhead is
					 sent. If you specify a number, it is relative to the scene
					 you specify. If you do not specify a scene, the current scene
					 determines the global frame number at which to go to and
					 stop. If you do specify a scene, the playhead goes to the
					 frame number in the specified scene and stops.
		@param scene The name of the scene. This parameter is optional.
		@throws ArgumentError If the `scene` or `frame`
							  specified are not found in this movie clip.
	**/
	public function gotoAndStop(frame:#if (haxe_ver >= "3.4.2") Any #else Dynamic #end, scene:String = null):Void
	{
		if (__timeline != null)
		{
			__timeline.gotoAndStop(frame, scene);
		}
	}

	/**
		Sends the playhead to the next frame and stops it. This happens after all
		remaining actions in the frame have finished executing.

	**/
	public function nextFrame():Void
	{
		if (__timeline != null)
		{
			__timeline.nextFrame();
		}
	}

	// @:noCompletion @:dox(hide) public function nextScene ():Void;

	/**
		Moves the playhead in the timeline of the movie clip.

	**/
	public function play():Void
	{
		if (__timeline != null)
		{
			__timeline.play();
		}
	}

	/**
		Sends the playhead to the previous frame and stops it. This happens after
		all remaining actions in the frame have finished executing.

	**/
	public function prevFrame():Void
	{
		if (__timeline != null)
		{
			__timeline.prevFrame();
		}
	}

	// @:noCompletion @:dox(hide) public function prevScene ():Void;

	/**
		Stops the playhead in the movie clip.

	**/
	public function stop():Void
	{
		if (__timeline != null)
		{
			__timeline.stop();
		}
	}

	public override function __enterFrame(deltaTime:Int):Void
	{
		if (__timeline != null)
		{
			__timeline.enterFrame(deltaTime);
		}

		super.__enterFrame(deltaTime);
	}

	@:noCompletion private function __fromSymbol(swf:SWFLite, symbol:SpriteSymbol):Void
	{
		// TODO: Refactor to ITimeline (or remove)
	}

	@:noCompletion private override function __stopAllMovieClips():Void
	{
		super.__stopAllMovieClips();
		stop();
	}

	@:noCompletion private override function __tabTest(stack:Array<InteractiveObject>):Void
	{
		if (!__enabled) return;
		super.__tabTest(stack);
	}

	// Event Handlers
	@:noCompletion private function __onMouseDown(event:MouseEvent):Void
	{
		if (__enabled && __hasDown)
		{
			gotoAndStop("_down");
		}

		__mouseIsDown = true;
		stage.addEventListener(MouseEvent.MOUSE_UP, __onMouseUp, true);
	}

	@:noCompletion private function __onMouseUp(event:MouseEvent):Void
	{
		__mouseIsDown = false;

		if (stage != null)
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, __onMouseUp);
		}

		if (!__buttonMode)
		{
			return;
		}

		if (event.target == this && __enabled && __hasOver)
		{
			gotoAndStop("_over");
		}
		else if (__enabled && __hasUp)
		{
			gotoAndStop("_up");
		}
	}

	@:noCompletion private function __onRollOut(event:MouseEvent):Void
	{
		if (!__enabled) return;

		if (__mouseIsDown && __hasOver)
		{
			gotoAndStop("_over");
		}
		else if (__hasUp)
		{
			gotoAndStop("_up");
		}
	}

	@:noCompletion private function __onRollOver(event:MouseEvent):Void
	{
		if (__enabled && __hasOver)
		{
			gotoAndStop("_over");
		}
	}

	// Getters & Setters
	@:noCompletion private override function set_buttonMode(value:Bool):Bool
	{
		if (__buttonMode != value)
		{
			if (value)
			{
				__hasDown = false;
				__hasOver = false;
				__hasUp = false;

				for (frameLabel in currentLabels)
				{
					switch (frameLabel.name)
					{
						case "_up":
							__hasUp = true;
						case "_over":
							__hasOver = true;
						case "_down":
							__hasDown = true;
						default:
					}
				}

				if (__hasDown || __hasOver || __hasUp)
				{
					addEventListener(MouseEvent.ROLL_OVER, __onRollOver);
					addEventListener(MouseEvent.ROLL_OUT, __onRollOut);
					addEventListener(MouseEvent.MOUSE_DOWN, __onMouseDown);
				}
			}
			else
			{
				removeEventListener(MouseEvent.ROLL_OVER, __onRollOver);
				removeEventListener(MouseEvent.ROLL_OUT, __onRollOut);
				removeEventListener(MouseEvent.MOUSE_DOWN, __onMouseDown);
			}

			__buttonMode = value;
		}

		return value;
	}

	@:noCompletion private function get_currentFrame():Int
	{
		if (__timeline != null)
		{
			return __timeline.currentFrame;
		}
		else
		{
			return 1;
		}
	}

	@:noCompletion private function get_currentFrameLabel():String
	{
		if (__timeline != null)
		{
			return __timeline.currentFrameLabel;
		}
		else
		{
			return null;
		}
	}

	@:noCompletion private function get_currentLabel():String
	{
		if (__timeline != null)
		{
			return __timeline.currentLabel;
		}
		else
		{
			return null;
		}
	}

	@:noCompletion private function get_currentLabels():Array<FrameLabel>
	{
		if (__timeline != null)
		{
			return __timeline.currentLabels;
		}
		else
		{
			return null;
		}
	}

	@:noCompletion private function get_enabled():Bool
	{
		return __enabled;
	}

	@:noCompletion private function set_enabled(value:Bool):Bool
	{
		return __enabled = value;
	}

	@:noCompletion private function get_framesLoaded():Int
	{
		if (__timeline != null)
		{
			return __timeline.framesLoaded;
		}
		else
		{
			return 1;
		}
	}

	@:noCompletion private function get_isPlaying():Bool
	{
		if (__timeline != null)
		{
			return __timeline.isPlaying;
		}
		else
		{
			return false;
		}
	}

	@:noCompletion private function get_totalFrames():Int
	{
		if (__timeline != null)
		{
			return __timeline.totalFrames;
		}
		else
		{
			return 1;
		}
	}
}
#else
typedef MovieClip = flash.display.MovieClip;
#end
