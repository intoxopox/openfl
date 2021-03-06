package test;

import haxe.Timer;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.utils.Assets;
import openfl.events.Event;
import openfl.filters.GlowFilter;
import openfl.filters.BitmapFilterQuality;

class GlowTest extends FunctionalTest
{
	private var bitmaps:Array<Bitmap> = [];
	private var filters:Array<GlowFilter> = [];

	public function new()
	{
		super();
	}

	public override function start():Void
	{
		content = new Sprite();

		var bitmapData = Assets.getBitmapData("assets/openfl.png");
		for (i in 0...4)
		{
			bitmaps[i] = new Bitmap(bitmapData);
			bitmaps[i].x = 50 + i * (bitmapData.width + 50);
			bitmaps[i].y = 50;
			content.addChild(bitmaps[i]);
			filters[i] = new GlowFilter(0xFF0000, 1.0, 6, 6, 2, BitmapFilterQuality.HIGH, false, false);
			bitmaps[i].filters = [filters[i]];
		}

		filters[1].inner = true;

		filters[2].knockout = true;

		filters[3].inner = true;
		filters[3].knockout = true;

		content.addEventListener(Event.ENTER_FRAME, update);
	}

	public override function stop():Void
	{
		content.removeEventListener(Event.ENTER_FRAME, update);
		content = null;
		bitmaps = [];
		filters = [];
	}

	private function update(e:Event):Void
	{
		var sinT = Math.sin(Timer.stamp()) * 0.5 + 0.5;
		var blur = 2 + sinT * 8;
		for (i in 0...4)
		{
			filters[i].blurX = filters[i].blurY = blur;
			bitmaps[i].filters = [filters[i]];
		}
	}
}
