package;

import lime.ui.WindowAttributes;
#if lime
import lime.graphics.RenderContextAttributes;
#end
#if macro
import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;
#end

@:access(lime.app.Application)
@:access(lime.system.System)
@:access(openfl.display.Stage)
@:dox(hide)
class ApplicationMain
{
	#if !macro
	private static var _app:openfl.display.Application;
	private static var _config:Dynamic;

	public static function main() {
		lime.system.System.__registerEntryPoint("::APP_FILE::", create);

		#if (js && html5)
		#if (munit || utest)
		lime.system.System.embed("::APP_FILE::", null, ::WIN_WIDTH::, ::WIN_HEIGHT::);
		#end
		#else
		create(null);
		#end
	}

	public static function create(config):Void {
		_app = new openfl.display.Application();
		_config = config;

		ManifestResources.init(_config);

		_app.meta["build"] = "::meta.buildNumber::";
		_app.meta["company"] = "::meta.company::";
		_app.meta["file"] = "::APP_FILE::";
		_app.meta["name"] = "::meta.title::";
		_app.meta["packageName"] = "::meta.packageName::";
		_app.meta["version"] = "::meta.version::";

		::if (_config.hxtelemetry != null)::#if hxtelemetry
		_app.meta["hxtelemetry-allocations"] = "::config.hxtelemetry.allocations::";
		_app.meta["hxtelemetry-host"] = "::config.hxtelemetry.host::";
		#end::end::

		// only create window and execute app if noautoexec define Doesn't exists
		#if !noautoexec
		createWindows();

		_app.init();

		var result = _app.exec();

		#if (sys && !ios && !nodejs && !emscripten)
		lime.system.System.exit(result);
		#end
		#end
	}

	public static function createWindows():Void {
		trace("ApplicationMain: createWindows called");
		#if !flash
		::foreach windows::
		var foreignHandle:Null<Int> = cast ::foreignHandle::;

		var renderContext = {
			antialiasing: ::antialiasing::,
			background: ::background::,
			colorDepth: ::colorDepth::,
			depth: ::depthBuffer::,
			hardware: ::hardware::,
			stencil: ::stencilBuffer::,
			type: null,
			vsync: ::vsync::
		};

		if (0 == foreignHandle || null == foreignHandle) {
			var attributes:lime.ui.WindowAttributes = {
				allowHighDPI: ::allowHighDPI::,
				alwaysOnTop: ::alwaysOnTop::,
				borderless: ::borderless::,
				// display: ::display::,
				element: null,
				frameRate: ::fps::,
				#if !web fullscreen: ::fullscreen::, #end
				height: ::height::,
				hidden: #if munit true #else ::hidden:: #end,
				maximized: ::maximized::,
				minimized: ::minimized::,
				parameters: ::parameters::,
				resizable: ::resizable::,
				title: "::title::",
				width: ::width::,
				x: ::x::,
				y: ::y::,
				context: renderContext,
			};

			if (_app.window == null) {
				if (_config != null) {
					var configFields:Array<String> = Reflect.fields(_config);
					var n:Int = -1;
					while (++n < configFields.length) {
						var field = configFields[n];
						if (Reflect.hasField(attributes, field)) {
							Reflect.setField(attributes, field, Reflect.field(_config, field));
						} else if (Reflect.hasField(attributes.context, field)) {
							Reflect.setField(attributes.context, field, Reflect.field(_config, field));
						}
					}
				}

				#if sys
				lime.system.System.__parseArguments(attributes);
				#end
			}
			createWindow(attributes);
		} else {
			#if lime
			createWindowFrom(foreignHandle, renderContext, ::fps::);
			#end
		}
		::end::

		#elseif !air
		_app.window.context.attributes.background = ::WIN_BACKGROUND::;
		_app.window.frameRate = ::WIN_FPS::;
		#end

		preload();
	}

	public static function createWindow(attributes:WindowAttributes):Void {
		trace("ApplicationMain: createWindow called");
		_app.createWindow(attributes);
	}

	#if lime
	public static function createWindowFrom(foreignHandle:Int, ?contextAttributes:RenderContextAttributes, ?frameRate:Int):Void {
		trace("ApplicationMain: createWindowFrom called");
		var curWindow = _app.createWindowFrom(foreignHandle, contextAttributes);
		if (frameRate == null) frameRate = ::fps:: == null ? 30 : ::fps::;
		curWindow.frameRate = frameRate;
	}
	#end

	public static function setUpApp():Void {
		trace("ApplicationMain: setUpApp called");
		preload();
		_app.init();
	}

	private static function preload():Void {
		trace("ApplicationMain: preload called");
		var preloader = getPreloader();
		_app.preloader.onProgress.add (function(loaded, total) {
			trace("ApplicationMain: calling preloader.update");
			@:privateAccess preloader.update(loaded, total);
		});
		_app.preloader.onComplete.add(function() {
			trace("ApplicationMain: calling openfl.display.Preloader.start");
			@:privateAccess preloader.start();
		});

		preloader.onComplete.add(start.bind(cast(_app.window, openfl.display.Window).stage));

		var preloadLibs = ManifestResources.preloadLibraries;
		var n:Int = -1;
		while (++n < preloadLibs.length) {
			trace("ApplicationMain: _app.preloader.addLibrary called");
			_app.preloader.addLibrary(preloadLibs[n]);
		}

		var preloadLibNames = ManifestResources.preloadLibraryNames;
		n = -1;
		while (++n < preloadLibNames.length) {
			trace("ApplicationMain: _app.preloader.addLibraryName called");
			_app.preloader.addLibraryName(preloadLibNames[n]);
		}

		_app.preloader.load();
	}

	public static function start(stage:openfl.display.Stage):Void {
		trace("ApplicationMain: start called");
		#if flash
		ApplicationMain.getEntryPoint();
		#else
		try {
			ApplicationMain.getEntryPoint();
			trace("ApplicationMain: getEntryPoint called");
			stage.dispatchEvent(new openfl.events.Event(openfl.events.Event.RESIZE, false, false));
			trace("ApplicationMain: stage.dispatchEvent RESIZE called");

			if (stage.window.fullscreen)
			{
				stage.dispatchEvent(new openfl.events.FullScreenEvent(openfl.events.FullScreenEvent.FULL_SCREEN, false, false, true, true));
			}
		} catch (e:Dynamic) {
			#if !display
			stage.__handleError (e);
			#end
		}
		#end
	}
	#end

	macro public static function getEntryPoint() {
		var hasMain = false;

		switch (Context.follow(Context.getType("::APP_MAIN::"))) {
			case TInst(t, params):

				var type = t.get();
				for (method in type.statics.get()) {
					if (method.name == "main") {
						hasMain = true;
						break;
					}
				}

				if (hasMain) {
					return Context.parse("@:privateAccess ::APP_MAIN::.main()", Context.currentPos());
				} else if (type.constructor != null) {
					return macro
					{
						var current = stage.getChildAt (0);

						if (current == null || !Std.is(current, openfl.display.DisplayObjectContainer)) {
							current = new openfl.display.MovieClip();
							stage.addChild(current);
						}

						new DocumentClass(cast current);
					};
				} else {
					Context.fatalError("Main class \"::APP_MAIN::\" has neither a static main nor a constructor.", Context.currentPos());
				}

			default:

				Context.fatalError("Main class \"::APP_MAIN::\" isn't a class.", Context.currentPos());
		}

		return null;
	}

	macro public static function getPreloader() {
		::if (PRELOADER_NAME != "")::
		var type = Context.getType("::PRELOADER_NAME::");

		switch (type) {
			case TInst(classType, _):

				var searchTypes = classType.get();

				while (searchTypes != null) {
					if (searchTypes.pack.length == 2 && searchTypes.pack[0] == "openfl" && searchTypes.pack[1] == "display" && searchTypes.name == "Preloader") {
						return macro
						{
							new ::PRELOADER_NAME::();
						};
					}

					if (searchTypes.superClass != null) {
						searchTypes = searchTypes.superClass.t.get();
					} else {
						searchTypes = null;
					}
				}

			default:
		}

		return macro
		{
			new openfl.display.Preloader(new ::PRELOADER_NAME::());
		}
		::else::
		return macro
		{
			new openfl.display.Preloader(new openfl.display.Preloader.DefaultPreloader());
		};
		::end::
	}

	#if !macro
	@:noCompletion @:dox(hide) public static function __init__() {
		var init = lime.app.Application;

		#if neko
		// Copy from https://github.com/HaxeFoundation/haxe/blob/development/std/neko/_std/Sys.hx#L164
		// since Sys.programPath () isn't available in __init__
		var sys_program_path = {
			var m = neko.vm.Module.local().name;
			try {
				sys.FileSystem.fullPath(m);
			}
			catch (e:Dynamic) {
				// maybe the neko module name was supplied without .n extension...
				if (!StringTools.endsWith(m, ".n")) {
					try {
						sys.FileSystem.fullPath(m + ".n");
					} catch (e:Dynamic) {
						m;
					}
				} else {
					m;
				}
			}
		};

		var loader = new neko.vm.Loader(untyped $loader);
		loader.addPath(haxe.io.Path.directory(#if (haxe_ver >= 3.3) sys_program_path #else Sys.executablePath() #end));
		loader.addPath("./");
		loader.addPath("@executable_path/");
		#end
	}
	#end
}

#if !macro
@:build(DocumentClass.build())
@:keep @:dox(hide) class DocumentClass extends ::APP_MAIN:: {}
#else
class DocumentClass
{
	macro public static function build():Array<Field>
	{
		var classType = Context.getLocalClass().get();
		var searchTypes = classType;

		while (searchTypes != null) {
			if (searchTypes.module == "openfl.display.DisplayObject" || searchTypes.module == "flash.display.DisplayObject") {
				var fields = Context.getBuildFields();

				var method = macro
				{
					current.addChild(this);
					super();
					dispatchEvent(new openfl.events.Event(openfl.events.Event.ADDED_TO_STAGE, false, false));
				}

				fields.push({ name: "new", access: [ APublic ], kind: FFun({ args: [ { name: "current", opt: false, type: macro :openfl.display.DisplayObjectContainer, value: null } ], expr: method, params: [], ret: macro :Void }), pos: Context.currentPos() });

				return fields;
			}

			if (searchTypes.superClass != null) {
				searchTypes = searchTypes.superClass.t.get();
			} else {
				searchTypes = null;
			}
		}

		return null;
	}
}
#end
