package com.jonathantorres.anotherspacegame
{
	import com.jonathantorres.anotherspacegame.utils.Stats;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import starling.core.Starling;
	
	/**
	 * @author Jonathan Torres
	 */
	[SWF(frameRate="60", width="980", height="440")]
	public class Main extends Sprite
	{
		private var _starling:Starling;
		
		public function Main()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(event:Event):void
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