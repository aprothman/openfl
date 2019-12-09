package flash.display;

#if flash
enum abstract InterpolationMethod(String) from String to String
{
	public var LINEAR_RGB = "linearRGB";
	public var RGB = "rgb";

	@:noCompletion public inline static function fromInt(value:Null<Int>):InterpolationMethod
	{
		return switch (value)
		{
			case 0: LINEAR_RGB;
			case 1: RGB;
			default: null;
		}
	}
}
#else
typedef InterpolationMethod = openfl.display.InterpolationMethod;
#end
