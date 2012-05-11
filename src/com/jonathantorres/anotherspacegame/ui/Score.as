package com.jonathantorres.anotherspacegame.ui
{
	import com.jonathantorres.anotherspacegame.Assets;
	
	import flash.display.BitmapData;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	
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
		
		private var _score:Number;
		
		public function Score()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function updateScore(score:Number):void
		{
			_gameScore.text = '' + score;
		}
		
		public function sumScore(score:Number):void
		{
			_score += score;
		}
		
		protected function init():void
		{
			_rectangleShape = new RoundedRectangle(140, 50);
			_rectangleData = new BitmapData(_rectangleShape.rectWidth, _rectangleShape.rectHeight, true, 0x000000);
			_rectangleData.draw(_rectangleShape);
			
			_rectangle = new Image(Texture.fromBitmapData(_rectangleData));
			addChild(_rectangle);
			
			_scoreTitle = new TextField(50, 28, 'SCORE', Assets.getFont('Futura').fontName, 14, 0xFFFFFF);
			_scoreTitle.x = 8;
			addChild(_scoreTitle);
			
			_gameScore = new TextField(80, 28, '0', Assets.getFont('Futura').fontName, 14, 0xe34900);
			_gameScore.hAlign = HAlign.LEFT;
			_gameScore.x = 58;
			addChild(_gameScore);
		}
		
		protected function onAddedToStage(event:Event):void
		{
			init();
		}

		public function get score():Number
		{
			return _score;
		}

		public function set score(value:Number):void
		{
			_score = value;
		}

	}
}