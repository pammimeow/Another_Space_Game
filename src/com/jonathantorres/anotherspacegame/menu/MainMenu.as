package com.jonathantorres.anotherspacegame.menu
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.text.TextField;

	import com.jonathantorres.anotherspacegame.Assets;
	import com.jonathantorres.anotherspacegame.Game;
	import com.jonathantorres.anotherspacegame.levels.Level;
	
	/**
	 * @author Jonathan Torres
	 */
	public class MainMenu extends Sprite
	{
		private var _menuItemsNames:Array;
		private var _menuItems:Array;
		private var _menu:Sprite;

		public function MainMenu()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		protected function init():void
		{
			_menuItemsNames = new Array(
					{ name : 'PLAY', sprite : Level }, 
					{ name : 'SETTINGS', sprite : SettingsMenu }, 
					{ name : 'INSTRUCTIONS', sprite : InstructionsMenu },
					{ name : 'CREDITS', sprite : CreditsMenu }
			);
			
			_menuItems = new Array();
			
			_menu = new Sprite();
			_menu.x = stage.stageWidth * 0.5;
			_menu.y = (stage.stageHeight * 0.5) + 30;
			addChild(_menu);
			
			for (var i:int = 0; i < _menuItemsNames.length; i++) {
				var menuTitle:TextField = new TextField(200, 35, _menuItemsNames[i].name, Assets.getFont('Futura').fontName, 24, 0xFFFFFF);
				menuTitle.x = -(menuTitle.width * 0.5);
				menuTitle.y = (i * (30 + 15)) - 60;
				menuTitle.addEventListener(TouchEvent.TOUCH, onMenuTitleTouch);
				
				_menuItems.push(menuTitle);
				_menu.addChild(menuTitle);
			}
		}
		
		protected function onMenuTitleTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage);
			var target:TextField = TextField(event.currentTarget);
			var parentSprite:Sprite = Sprite(this.parent);
			
			//click
			if (touch.phase == 'ended') {
				if (target.text == 'PLAY') parentSprite.removeChild(Game(parentSprite).mainTitle);
				parentSprite.removeChild(this);
				
				for (var j:int = 0; j < _menuItems.length; j++) {
					if (target.text == _menuItems[j].text) {
						var menuToAdd:Sprite = new _menuItemsNames[j].sprite;
						parentSprite.addChild(menuToAdd);
					}
				}
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
			//trace('Removed: ' + this);
		}
		
		protected function onAddedToStage(event:Event):void
		{
			init();
			//trace('Added: ' + this);
		}
	}
}