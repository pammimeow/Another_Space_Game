package com.jonathantorres.anotherspacegame
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	import com.jonathantorres.anotherspacegame.menu.MainMenu;

	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	/**
	 * @author Jonathan Torres
	 */
	public class Game extends Sprite
	{
		private var _mainMenu:MainMenu;
		private var _background:Image;
		
		private var _mainTitle:TextField;
		private var _bgAudio:Sound;
		public static var bgAudioChannel:SoundChannel;
		
		public function Game()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function init():void
		{
			/*Get music ready*/
			Assets.prepareSounds();
			
			/*Background Music*/
			_bgAudio = Assets.getSound('BackgroundMusic');
			bgAudioChannel = _bgAudio.play(0, int.MAX_VALUE);
			
			/*Space Background*/
			_background = new Image(Assets.getTexture('SpaceWorld'));
			_background.x = 0;
			_background.y = 0;
			addChild(_background);
			
			/*Main Title*/
			_mainTitle = new TextField(900, 100, 'Another Space Game', Assets.getFont('ArialNarrow').fontName, 80, 0xFF0000);
			_mainTitle.autoScale = true;
			_mainTitle.x = (stage.stageWidth * 0.5) - (_mainTitle.width * 0.5);
			_mainTitle.y = 30;
			addChild(_mainTitle);
			
			/*Main Menu*/
			_mainMenu = new MainMenu();
			addChild(_mainMenu);
		}
		
		protected function onAddedToStage(event:Event):void
		{
			init();
		}

		public function get mainTitle():TextField
		{
			return _mainTitle;
		}

		public function set mainTitle(value:TextField):void
		{
			_mainTitle = value;
		}
	}
}