package com.jonathantorres.anotherspacegame.objects
{
	import com.jonathantorres.anotherspacegame.Assets;
	
	import flash.ui.Keyboard;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.extensions.ParticleDesignerPS;
	
	/**
	 * @author Jonathan Torres
	 */
	public class PlayerShip extends Sprite
	{
		private var _ship:Image;
		private var _fire:ParticleDesignerPS;
		private var _moveLeft:Boolean;
		private var _moveRight:Boolean;
		private var _moveUp:Boolean;
		private var _moveDown:Boolean;
		private var _vx:Number = 0.0;
		private var _vy:Number = 0.0;
		private var _ax:Number = 0.0;
		private var _ay:Number = 0.0;
		private var _speed:Number = 0.08;
		
		public var lasers:Array = new Array();
		
		public function PlayerShip()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function init():void
		{
			this.x = stage.stageWidth * 0.5;
			this.y = stage.stageHeight * 0.5;
			
			_ship = new Image(Assets.getTexture('MainShip'));
			_ship.x = -_ship.width;
			_ship.y = -_ship.height * 0.5;
			
			_fire = new ParticleDesignerPS(Assets.getParticleXML('MainShipThrustParticle'), 
										   Assets.getTexture('MainShipThrust'));
			_fire.emitterX = (-_ship.width) + 20;
			_fire.emitterY = 5;
			_fire.start();
			
			addChild(_fire);
			addChild(_ship);
			
			Starling.juggler.add(_fire);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		public function moveShip():void
		{
			_vx += _ax;
			_vy += _ay;
			
			this.x += _vx;
			this.y += _vy;
			
			if (this.x <= 0) {
				this.x = stage.stageWidth + _ship.width;
			} else if ((this.x - _ship.width) >= stage.stageWidth) {
				this.x = 0;
			}
		}
		
		public function shoot():void
		{
			var laser:Laser = new Laser('player');
			laser.x = this.x - 5;
			laser.y = this.y - 3;
			Sprite(this.parent).addChild(laser);
			lasers.push(laser);
		}
		
		public function removeListeners():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{
			_ax = 0;
			_ay = 0;
			
			switch(event.keyCode) {
				case Keyboard.LEFT:
				case Keyboard.A:
					_moveLeft = false;
					break;
				
				case Keyboard.RIGHT:
				case Keyboard.D:
					_moveRight = false;
					break;
				
				case Keyboard.UP:
				case Keyboard.W:
					_moveUp = false;
					break;
				
				case Keyboard.DOWN:
				case Keyboard.S:
					_moveDown = false;
					break;
				
				case Keyboard.SPACE:
					shoot();
					break;
			}
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			switch(event.keyCode) {
				case Keyboard.LEFT:
				case Keyboard.A:
					_moveLeft = true;
					_ax = -_speed;
					break;
				
				case Keyboard.RIGHT:
				case Keyboard.D:
					_moveRight = true;
					_ax = _speed;
					break;
				
				case Keyboard.UP:
				case Keyboard.W:
					_moveUp = true;
					_ay = -_speed;
					break;
				
				case Keyboard.DOWN:
				case Keyboard.S:
					_moveDown = true;
					_ay = _speed;
					break;
			}
		}
		
		protected function onAddedToStage(event:Event):void
		{
			init();
		}

		public function get ship():Image
		{
			return _ship;
		}

		public function set ship(value:Image):void
		{
			_ship = value;
		}

	}
}