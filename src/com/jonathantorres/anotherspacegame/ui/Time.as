package com.jonathantorres.anotherspacegame.ui
{
	import flash.display.BitmapData;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.text.TextField;
	
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
		
		protected function init():void
		{
			_rectangleShape = new RoundedRectangle(80, 50);
			_rectangleData = new BitmapData(_rectangleShape.rectWidth, _rectangleShape.rectHeight, true, 0x000000);
			_rectangleData.draw(_rectangleShape);
			
			_rectangle = new Image(Texture.fromBitmapData(_rectangleData));
			addChild(_rectangle);
			
			_timeTitle = new TextField(40, 28, 'TIME', 'Arial', 11, 0xFFFFFF);
			_timeTitle.x = 4;
			addChild(_timeTitle);
			
			_gameTime = new TextField(50, 28, '10:00', 'Arial', 11, 0xe34900);
			_gameTime.x = 30;
			addChild(_gameTime);
		}
		
		protected function onAddedToStage(event:Event):void
		{
			init();
		}
	}
}