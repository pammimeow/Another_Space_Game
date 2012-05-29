package com.jonathantorres.anotherspacegame.objects
{
	import com.jonathantorres.anotherspacegame.Assets;
	import com.jonathantorres.anotherspacegame.utils.SoundManager;
	
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.utils.Timer;
	
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
		private var _shootTimer:Timer;
		
		public var lasers:Array = new Array();
		public var scoreValue:uint = 50;
		public var damage:uint = 15;
		
		public function EnemyShip(color:String)
		{
			super();
			
			_color = color;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
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
			
			_ship.x = 0;
			_ship.y = -(_ship.height * 0.5);
			addChild(_ship);
			
			_shootTimer = new Timer((Math.random() * 2000) + 1000);
			_shootTimer.addEventListener(TimerEvent.TIMER, onShootTimer);
			_shootTimer.start();
		}
		
		protected function onShootTimer(event:TimerEvent):void
		{
			shoot();
		}
		
		public function animate():void
		{
			_vx += _speed;
			_vy += (_speed / 10);
			
			this.x -= _vx;
			this.y += _vy;
		}
		
		public function shoot():void
		{
			var shipColor:String = _color;
			var shootSound:Sound = Assets.getSound('LaserSound');
			if (SoundManager.sfxOn) shootSound.play();
			
			if (shipColor == 'gray') {
				shipColor = 'blue';
			}
			
			var laser:Laser = new Laser(shipColor);
			laser.x = this.x - 10;
			laser.y = this.y - 5;
			Sprite(this.parent).addChild(laser);
			lasers.push(laser);
		}
		
		protected function onAddedToStage(event:Event):void
		{
			init();
		}
		
		protected function onRemovedFromStage(event:Event):void
		{
			if (lasers.length != 0) {
				for (var i:int = 0; i < lasers.length; i++) {
					Sprite(this.parent).removeChild(lasers[i]);
					lasers.splice(i, 1);
				}
			}
			
			_shootTimer.stop();
			_shootTimer.removeEventListener(TimerEvent.TIMER, onShootTimer);
			_shootTimer = null;
		}
	}
}