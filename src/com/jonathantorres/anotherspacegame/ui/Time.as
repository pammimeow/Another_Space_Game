package com.jonathantorres.anotherspacegame.ui
{
	import com.jonathantorres.anotherspacegame.Assets;
	
	import flash.display.BitmapData;
	import flash.utils.getTimer;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	/**
	 * @author Jonathan Torres
	 */
	public class Time extends Sprite
	{
		private var _rectangleShape:RoundedRectangle;
		private var _rectangleData:BitmapData;
		private var _rectangle:Image;
		private var _timeTitle:TextField;
		private var _gameTime:TextField;
		
		public function Time()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function showGameTime(startTime:int):void
		{
			var passedTime:int = getTimer() - startTime;
			var seconds:int = Math.floor(passedTime / 1000);
			var minutes:int = Math.floor(seconds / 60);
			seconds -= minutes * 60;
			
			var time:String = minutes + ':' + String(seconds + 100).substr(1, 2);
			_gameTime.text = time;
		}
		
		protected function init():void
		{
			_rectangleShape = new RoundedRectangle(80, 50);
			_rectangleData = new BitmapData(_rectangleShape.rectWidth, _rectangleShape.rectHeight, true, 0x000000);
			_rectangleData.draw(_rectangleShape);
			
			_rectangle = new Image(Texture.fromBitmapData(_rectangleData));
			addChild(_rectangle);
			
			_timeTitle = new TextField(40, 28, 'TIME', Assets.getFont('Futura').fontName, 14, 0xFFFFFF);
			_timeTitle.x = 4;
			addChild(_timeTitle);
			
			_gameTime = new TextField(50, 28, '0:00', Assets.getFont('Futura').fontName, 14, 0xe34900);
			_gameTime.x = 30;
			addChild(_gameTime);
		}
		
		protected function onAddedToStage(event:Event):void
		{
			init();
		}

		public function get gameTime():TextField
		{
			return _gameTime;
		}

		public function set gameTime(value:TextField):void
		{
			_gameTime = value;
		}
	}
}