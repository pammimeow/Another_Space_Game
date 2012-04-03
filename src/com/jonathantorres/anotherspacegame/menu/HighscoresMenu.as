package com.jonathantorres.anotherspacegame.menu
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	
	/**
	 * @author Jonathan Torres
	 */
	public class HighscoresMenu extends Sprite
	{

		private var _highscoresTitle:TextField;
		private var _backToMainMenu:TextField;
		
		public function HighscoresMenu()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		protected function init():void
		{
			this.x = 0;
			this.y = 0;
			
			_highscoresTitle = new TextField(500, 100, 'Highscores', 'Arial', 30, 0xFF0000);
			_highscoresTitle.autoScale = true;
			_highscoresTitle.x = (stage.stageWidth * 0.5) - (_highscoresTitle.width * 0.5);
			_highscoresTitle.y = stage.stageHeight * 0.5;
			addChild(_highscoresTitle);
			
			_backToMainMenu = new TextField(150, 100, 'Back to Main Menu', 'Arial', 15, 0xFFFFFF);
			_backToMainMenu.autoScale = true;
			_backToMainMenu.x = 20;
			_backToMainMenu.y = stage.stageHeight - 80;
			_backToMainMenu.addEventListener(TouchEvent.TOUCH, onBackToMainMenuTouch);
			addChild(_backToMainMenu);
		}
		
		protected function onBackToMainMenuTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage);
			var target:TextField = TextField(event.currentTarget);
			var parentSprite:Sprite = Sprite(this.parent);
			
			//click
			if (touch.phase == 'ended') {
				parentSprite.removeChild(this);
				parentSprite.addChild(new MainMenu());
			} 
				
			//hover
			else if (touch.phase == 'hover') {
				target.color = 0xFF0000;
			}
			
			//out
			if (!event.interactsWith(target)) {
				target.color = 0xFFFFFF;
			}
		}
		
		protected function onRemovedFromStage(event:Event):void
		{
			
		}
		
		protected function onAddedToStage(event:Event):void
		{
			init();
		}
	}
}