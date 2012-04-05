package com.jonathantorres.anotherspacegame.ui
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	/**
	 * @author Jonathan Torres
	 */
	public class Lifebar extends Sprite
	{
		private var _rectangleShape:RoundedRectangle;
		private var _rectangleData:BitmapData;
		private var _rectangle:Image;

		private var _lifeDisplayShape:flash.display.Sprite;
		private var _lifeDisplayData:BitmapData;
		private var _lifeDisplay:Image;

		private var _lifeText:TextField;
		
		public function Lifebar()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function init():void
		{
			_rectangleShape = new RoundedRectangle(260, 50);
			_rectangleData = new BitmapData(_rectangleShape.rectWidth, _rectangleShape.rectHeight, true, 0x000000);
			_rectangleData.draw(_rectangleShape);
			
			_rectangle = new Image(Texture.fromBitmapData(_rectangleData));
			addChild(_rectangle);
			
			_lifeDisplayShape = new flash.display.Sprite();
			_lifeDisplayShape.graphics.beginFill(0xe34900, 1.0);
			_lifeDisplayShape.graphics.drawRect(0, 0, 200, 10);
			_lifeDisplayShape.graphics.endFill();
			
			_lifeDisplayData = new BitmapData(200, 10, true, 0x000000);
			_lifeDisplayData.draw(_lifeDisplayShape);
			
			_lifeDisplay = new Image(Texture.fromBitmapData(_lifeDisplayData));
			_lifeDisplay.x = 45;
			_lifeDisplay.y = 9;
			addChild(_lifeDisplay);
			
			_lifeText = new TextField(50, 28, 'LIFE', 'Arial', 11, 0xFFFFFF);
			addChild(_lifeText);
		}
		
		protected function onAddedToStage(event:Event):void
		{
			init();
		}
	}
}