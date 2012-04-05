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
	public class LevelNumber extends Sprite
	{
		private var _rectangleShape:RoundedRectangle;
		private var _rectangleData:BitmapData;
		private var _rectangle:Image;
		private var _levelTitle:TextField;
		private var _gameLevel:TextField;
		
		public function LevelNumber()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function init():void
		{
			_rectangleShape = new RoundedRectangle(75, 50);
			_rectangleData = new BitmapData(_rectangleShape.rectWidth, _rectangleShape.rectHeight, true, 0x000000);
			_rectangleData.draw(_rectangleShape);
			
			_rectangle = new Image(Texture.fromBitmapData(_rectangleData));
			addChild(_rectangle);
			
			_levelTitle = new TextField(40, 28, 'LEVEL', 'Arial', 11, 0xFFFFFF);
			_levelTitle.x = 8;
			addChild(_levelTitle);
			
			_gameLevel = new TextField(20, 28, '10', 'Arial', 11, 0xe34900);
			_gameLevel.x = 45;
			addChild(_gameLevel);
		}
		
		protected function onAddedToStage(event:Event):void
		{
			init();
		}
	}
}