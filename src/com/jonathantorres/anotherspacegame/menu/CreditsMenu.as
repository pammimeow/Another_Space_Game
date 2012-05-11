package com.jonathantorres.anotherspacegame.menu
{
	import com.jonathantorres.anotherspacegame.Assets;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	
	/**
	 * @author Jonathan Torres
	 */
	public class CreditsMenu extends Sprite
	{
		private var _creditsTitle:TextField;
		private var _backToMainMenu:TextField;
		private var _creatorInfo:TextField;
		private var _funInfo:TextField;
		private var _goInfo:TextField;
		
		private const CREATOR_TEXT:String = 'DESIGNED & DEVELOPED BY JONATHAN TORRES. \nWWW.JONATHANTORRES.COM';
		private const FUN_TEXT:String = 'I DID THIS GAME JUST FOR FUN. \nESPECCIALLY TO TRY OUT THE STARLING FRAMEWORK.';
		private const GO_TEXT:String = 'GO AND CHECK IT OUT!';
		
		public function CreditsMenu()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		protected function init():void
		{
			this.x = 0;
			this.y = 0;
			
			_creditsTitle = new TextField(500, 100, 'CREDITS', Assets.getFont('ArialNarrow').fontName, 30, 0xFF0000);
			_creditsTitle.autoScale = true;
			_creditsTitle.x = (stage.stageWidth * 0.5) - (_creditsTitle.width * 0.5);
			_creditsTitle.y = 110;
			addChild(_creditsTitle);
			
			_backToMainMenu = new TextField(150, 100, 'BACK TO MAIN MENU', Assets.getFont('ArialNarrow').fontName, 15, 0xFFFFFF);
			_backToMainMenu.autoScale = true;
			_backToMainMenu.x = 20;
			_backToMainMenu.y = stage.stageHeight - 80;
			_backToMainMenu.addEventListener(TouchEvent.TOUCH, onBackToMainMenuTouch);
			addChild(_backToMainMenu);
			
			_creatorInfo = new TextField(300, 100, CREATOR_TEXT, Assets.getFont('Futura').fontName, 14, 0x929090);
			_creatorInfo.autoScale = true;
			_creatorInfo.x = (stage.stageWidth * 0.5) - (_creatorInfo.width * 0.5);
			_creatorInfo.y = 160;
			addChild(_creatorInfo);
			
			_funInfo = new TextField(300, 100, FUN_TEXT, Assets.getFont('Futura').fontName, 14, 0x929090);
			_funInfo.autoScale = true;
			_funInfo.x = (stage.stageWidth * 0.5) - (_funInfo.width * 0.5);
			_funInfo.y = 225;
			addChild(_funInfo);
			
			_goInfo = new TextField(300, 100, GO_TEXT, Assets.getFont('Futura').fontName, 14, 0x929090);
			_goInfo.autoScale = true;
			_goInfo.x = (stage.stageWidth * 0.5) - (_goInfo.width * 0.5);
			_goInfo.y = 300;
			addChild(_goInfo);
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