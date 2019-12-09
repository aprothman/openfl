package openfl.display3D.textures;

#if (display || !flash)
import openfl.display.BitmapData;
import openfl.utils.ByteArray;

#if !openfl_global
@:jsRequire("openfl/display3D/textures/Texture", "default")
#end
final extern class Texture extends TextureBase
{
	public function uploadCompressedTextureFromByteArray(data:ByteArray, byteArrayOffset:UInt, async:Bool = false):Void;
	public function uploadFromBitmapData(source:BitmapData, miplevel:UInt = 0):Void;
	public function uploadFromByteArray(data:ByteArray, byteArrayOffset:UInt, miplevel:UInt = 0):Void;
}
#else
typedef Texture = flash.display3D.textures.Texture;
#end
