package com.jonathantorres.anotherspacegame.menu
{
	import com.jonathantorres.anotherspacegame.Game;
	import com.jonathantorres.anotherspacegame.levels.Level;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	/**
	 * @author Jonathan Torres
	 */
	public class GameOverMenu extends Sprite
	{
		private var _gameOverTitle:TextField;
		private var _backToMainMenu:TextField;
		private var _finishedScore:Number;
		private var _playAgainText:TextField;
		private var _playerScoreTitle:TextField;
		private var _playerScoreText:TextField;
		
		public function GameOverMenu(score:Number)
		{
			super();
			
			_finishedScore = score;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		protected function init():void
		{
			this.x = 0;
			this.y = 0;
			
			_gameOverTitle = new TextField(500, 100, 'Game Over', 'Arial', 30, 0xFFFFFF);
			_gameOverTitle.autoScale = true;
			_gameOverTitle.x = (stage.stageWidth * 0.5) - (_gameOverTitle.width * 0.5);
			_gameOverTitle.y = 180;
			addChild(_gameOverTitle);
			
			_backToMainMenu = new TextField(150, 100, 'Back to Main Menu', 'Arial', 15, 0xFFFFFF);
			_backToMainMenu.autoScale = true;
			_backToMainMenu.x = 20;
			_backToMainMenu.y = stage.stageHeight - 80;
			_backToMainMenu.addEventListener(TouchEvent.TOUCH, onBackToMainMenuTouch);
			addChild(_backToMainMenu);
			
			_playAgainText = new TextField(150, 60, 'Play again?', 'Arial', 12, 0xE34900);
			_playAgainText.autoScale = true;
			_playAgainText.x = (stage.stageWidth * 0.5) - (_playAgainText.width * 0.5);
			_playAgainText.y = 240;
			_playAgainText.addEventListener(TouchEvent.TOUCH, onPlayAgainTouch);
			addChild(_playAgainText);
			
			_playerScoreTitle = new TextField(150, 60, 'Your score: ', 'Arial', 14, 0xE34900);
			_playerScoreTitle.autoScale = true;
			_playerScoreTitle.x = ((stage.stageWidth * 0.5) - (_playerScoreTitle.width * 0.5)) - 5;
			_playerScoreTitle.y = 300;
			addChild(_playerScoreTitle);
			
			_playerScoreText = new TextField(150, 60, String(_finishedScore), 'Arial', 14, 0xFFFFFF);
			_playerScoreText.autoScale = true;
			_playerScoreText.hAlign = HAlign.LEFT;
			_playerScoreText.x = _playerScoreTitle.x + 110;
			_playerScoreText.y = _playerScoreTitle.y;
			addChild(_playerScoreText);
		}
		
		protected function onPlayAgainTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage);
			var target:TextField = TextField(event.currentTarget);
			var parentSprite:Sprite = Sprite(this.parent);
			
			//click
			if (touch.phase == 'ended') {
				parentSprite.removeChild(this);
				parentSprite.removeChild(Game(parentSprite).mainTitle);
				parentSprite.addChild(new Level());
			}
				
			//hover
			else if (touch.phase == 'hover') {
				target.color = 0xFFFFFF;
			}
			
			//out
			if (!event.interactsWith(target)) {
				target.color = 0xE34900;
			}
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