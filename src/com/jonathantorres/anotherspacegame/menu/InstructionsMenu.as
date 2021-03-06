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
	public class InstructionsMenu extends Sprite
	{

		private var _instructionsTitle:TextField;
		private var _backToMainMenu:TextField;
		private var _controlsText:TextField;
		private var _objectivesText:TextField;
		
		private const CONTROLS_MESSAGE:String = 'USE W-A-S-D TO MOVE THE SHIP. \nAVOID THE ASTEROIDS AND THE ENEMY SHIPS. SHOOT THEM DOWN!';
		private const OBJECTIVES_MESSAGE:String = 'COLLECT THE LIFEFORCES FOR PROTECTION. \nHEALTH ICONS RESTORE HEALTH.';
		
		public function InstructionsMenu()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		protected function init():void
		{
			this.x = 0;
			this.y = 0;
			
			_instructionsTitle = new TextField(500, 100, 'INSTRUCTIONS', Assets.getFont('ArialNarrow').fontName, 30, 0xFF0000);
			_instructionsTitle.autoScale = true;
			_instructionsTitle.x = (stage.stageWidth * 0.5) - (_instructionsTitle.width * 0.5);
			_instructionsTitle.y = 120;
			addChild(_instructionsTitle);
			
			_backToMainMenu = new TextField(150, 100, 'BACK TO MAIN MENU', Assets.getFont('ArialNarrow').fontName, 15, 0xFFFFFF);
			_backToMainMenu.autoScale = true;
			_backToMainMenu.x = 20;
			_backToMainMenu.y = stage.stageHeight - 80;
			_backToMainMenu.addEventListener(TouchEvent.TOUCH, onBackToMainMenuTouch);
			addChild(_backToMainMenu);
			
			_controlsText = new TextField(400, 100, CONTROLS_MESSAGE, Assets.getFont('Futura').fontName, 14, 0x929090);
			_controlsText.autoScale = true;
			_controlsText.x = (stage.stageWidth * 0.5) - (_controlsText.width * 0.5);
			_controlsText.y = 190;
			addChild(_controlsText);
			
			_objectivesText = new TextField(300, 100, OBJECTIVES_MESSAGE, Assets.getFont('Futura').fontName, 14, 0x929090);
			_objectivesText.autoScale = true;
			_objectivesText.x = (stage.stageWidth * 0.5) - (_objectivesText.width * 0.5);
			_objectivesText.y = 250;
			addChild(_objectivesText);
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