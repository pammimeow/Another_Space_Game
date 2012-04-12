package com.jonathantorres.anotherspacegame
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import starling.core.Starling;
	import com.jonathantorres.anotherspacegame.utils.Stats;
	
	/**
	 * @author Jonathan Torres
	 */
	[SWF(frameRate="60", width="980", height="440")]
	public class Main extends Sprite
	{
		private var _starling:Starling;
		
		public function Main()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			/* To measure performance */
			addChild(new Stats());
			
			_starling = new Starling(Game, stage);
			_starling.start();
		}
	}
}