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
	public class Score extends Sprite
	{
		private var _rectangleShape:RoundedRectangle;
		private var _rectangleData:BitmapData;
		private var _rectangle:Image;
		
		private var _scoreTitle:TextField;
		private var _gameScore:TextField;
		
		public function Score()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function init():void
		{
			_rectangleShape = new RoundedRectangle(140, 50);
			_rectangleData = new BitmapData(_rectangleShape.rectWidth, _rectangleShape.rectHeight, true, 0x000000);
			_rectangleData.draw(_rectangleShape);
			
			_rectangle = new Image(Texture.fromBitmapData(_rectangleData));
			addChild(_rectangle);
			
			_scoreTitle = new TextField(50, 28, 'SCORE', 'Arial', 11, 0xFFFFFF);
			_scoreTitle.x = 8;
			addChild(_scoreTitle);
			
			_gameScore = new TextField(80, 28, '100,000,000', 'Arial', 11, 0xe34900);
			_gameScore.x = 55;
			addChild(_gameScore);
		}
		
		protected function onAddedToStage(event:Event):void
		{
			init();
		}
	}
}