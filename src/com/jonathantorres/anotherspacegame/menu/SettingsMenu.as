package com.jonathantorres.anotherspacegame.menu
{
	import com.jonathantorres.anotherspacegame.Assets;
	import com.jonathantorres.anotherspacegame.Game;
	import com.jonathantorres.anotherspacegame.utils.SoundManager;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	
	/**
	 * @author Jonathan Torres
	 */
	public class SettingsMenu extends Sprite
	{

		private var _settingsTitle:TextField;
		private var _backToMainMenu:TextField;
		private var _audioTitle:TextField;
		private var _sfxTitle:TextField;
		private var _sfxSwitch:TextField;
		private var _audioSwitch:TextField;
		private var _bgAudio:Sound;
		private var _bgAudioChannel:SoundChannel;
		
		public function SettingsMenu()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		protected function init():void
		{
			this.x = 0;
			this.y = 0;
			
			_bgAudioChannel = Game.bgAudioChannel;
			
			_settingsTitle = new TextField(500, 100, 'SETTINGS', Assets.getFont('ArialNarrow').fontName, 30, 0xFF0000);
			_settingsTitle.autoScale = true;
			_settingsTitle.x = (stage.stageWidth * 0.5) - (_settingsTitle.width * 0.5);
			_settingsTitle.y = 120;
			addChild(_settingsTitle);
			
			_audioTitle = new TextField(200, 50, 'BACKGROUND MUSIC', Assets.getFont('Futura').fontName, 16, 0xFFFFFF);
			_audioTitle.autoScale = true;
			_audioTitle.x = (stage.stageWidth * 0.5) - (_audioTitle.width * 0.5) - 60;
			_audioTitle.y = 200;
			addChild(_audioTitle);
			
			_audioSwitch = new TextField(100, 50, 'ON', Assets.getFont('Futura').fontName, 16, 0xFF5201);
			_audioSwitch.autoScale = true;
			_audioSwitch.x = _audioTitle.x + 145;
			_audioSwitch.y = _audioTitle.y;
			_audioSwitch.addEventListener(TouchEvent.TOUCH, onAudioSwitchTouch);
			addChild(_audioSwitch);
			
			_sfxTitle = new TextField(200, 50, 'SOUND EFFECTS', Assets.getFont('Futura').fontName, 16, 0xFFFFFF);
			_sfxTitle.autoScale = true;
			_sfxTitle.x = (stage.stageWidth * 0.5) - (_sfxTitle.width * 0.5) - 46;
			_sfxTitle.y = 240;
			addChild(_sfxTitle);
			
			_sfxSwitch = new TextField(100, 50, 'ON', Assets.getFont('Futura').fontName, 16, 0xFF5201);
			_sfxSwitch.autoScale = true;
			_sfxSwitch.x = _sfxTitle.x + 130;
			_sfxSwitch.y = _sfxTitle.y;
			_sfxSwitch.addEventListener(TouchEvent.TOUCH, onSfxSwitchTouch);
			addChild(_sfxSwitch);
			
			_backToMainMenu = new TextField(150, 100, 'BACK TO MAIN MENU', Assets.getFont('ArialNarrow').fontName, 15, 0xFFFFFF);
			_backToMainMenu.autoScale = true;
			_backToMainMenu.x = 20;
			_backToMainMenu.y = stage.stageHeight - 80;
			_backToMainMenu.addEventListener(TouchEvent.TOUCH, onBackToMainMenuTouch);
			addChild(_backToMainMenu);
			
			/* Are sfx enabled? */
			if (SoundManager.sfxOn) {
				_sfxSwitch.text = 'ON';
				_sfxSwitch.color = 0xFF5201;
				_sfxSwitch.alpha = 1.0;
			} else {
				_sfxSwitch.text = 'OFF';
				_sfxSwitch.color = 0xCCCCCC;
				_sfxSwitch.alpha = 0.5;
			}
			
			/* Is bg music enabled? */
			if (SoundManager.bgMusicOn) {
				_audioSwitch.color = 0xFF5201;
				_audioSwitch.text = 'ON';
				_audioSwitch.alpha = 1.0;
			} else {
				_audioSwitch.color = 0xCCCCCC;
				_audioSwitch.alpha = 0.5;
				_audioSwitch.text = 'OFF';
			}
		}
		
		protected function onSfxSwitchTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage);
			var target:TextField = TextField(event.currentTarget);
			var parentSprite:Sprite = Sprite(this.parent);
			
			//click
			if (touch.phase == 'ended') {
				if (SoundManager.sfxOn) {
					target.color = 0xCCCCCC;
					target.alpha = 0.5;
					target.text = 'OFF';
					SoundManager.sfxOn = false;
				} else {
					target.color = 0xFF5201;
					target.text = 'ON';
					target.alpha = 1.0;
					SoundManager.sfxOn = true;
				}
			}
		}
		
		protected function onAudioSwitchTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage);
			var target:TextField = TextField(event.currentTarget);
			var parentSprite:Sprite = Sprite(this.parent);
			
			//click
			if (touch.phase == 'ended') {
				if (SoundManager.bgMusicOn) {
					_bgAudioChannel.stop();
					
					target.color = 0xCCCCCC;
					target.alpha = 0.5;
					target.text = 'OFF';
					SoundManager.bgMusicOn = false;
				} else {
					_bgAudio = Assets.getSound('BackgroundMusic');
					_bgAudioChannel = _bgAudio.play(0, int.MAX_VALUE);
					
					target.color = 0xFF5201;
					target.text = 'ON';
					target.alpha = 1.0;
					SoundManager.bgMusicOn = true;
				}
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