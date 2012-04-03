package com.jonathantorres.anotherspacegame.objects
{
	import com.jonathantorres.anotherspacegame.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * @author Jonathan Torres
	 */
	public class EnemyShip extends Sprite
	{
		private var _color:String;
		private var _vx:Number = 0.0;
		private var _vy:Number = 0.0;
		private var _speed:Number = 0.01;
		
		private var _ship:Image;
		
		public function EnemyShip(color:String)
		{
			super();
			
			_color = color;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function init():void
		{
			switch(_color) {
				case 'gray': 
					_ship = new Image(Assets.getTexture('EnemyShipGray'));		
					break;
				
				case 'red': 
					_ship = new Image(Assets.getTexture('EnemyShipRed'));			
					break;
				
				case 'green': 
					_ship = new Image(Assets.getTexture('EnemyShipGreen'));				
					break;
			}
			
			_ship.x = -_ship.width;
			_ship.y = -_ship.height * 0.5;
			addChild(_ship);
		}
		
		public function animate():void
		{
			_vx += _speed;
			_vy += (_speed / 10);
			
			this.x -= _vx;
			this.y += _vy;
		}
		
		protected function shoot():void
		{
			
		}
		
		protected function onAddedToStage(event:Event):void
		{
			init();
		}
	}
}