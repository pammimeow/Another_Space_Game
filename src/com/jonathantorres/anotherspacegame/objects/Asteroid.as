package com.jonathantorres.anotherspacegame.objects
{
	import com.jonathantorres.anotherspacegame.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * @author Jonathan Torres
	 */
	public class Asteroid extends Sprite
	{
		private var _size:String;
		private var _asteroid:Image;
		private var _vx:Number = 0.0;
		private var _vy:Number = 0.0;
		private var _speed:Number = 0.01;
		private var _rotationSpeed:Number = 0.01;
		
		public var scoreValue:uint = 30;
		public var damage:uint;
		
		public function Asteroid(size:String)
		{
			super();
			
			_size = size;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function init():void
		{
			switch(_size) {
				case 'small':
					_asteroid = new Image(Assets.getTexture('AsteroidSmall'));
					damage = 5;
					break;
				
				case 'medium':
					_asteroid = new Image(Assets.getTexture('AsteroidMedium'));
					damage = 10;
					break;
				
				case 'large':
					_asteroid = new Image(Assets.getTexture('AsteroidBig'));
					damage = 15;
					break;
			}
			
			_asteroid.x = -_asteroid.width * 0.5;
			_asteroid.y = -_asteroid.height * 0.5;
			addChild(_asteroid);
		}
		
		public function animate():void
		{
			_vx += _speed;
			_vy += _speed;
			
			this.x -= _vx;
			this.rotation += _rotationSpeed;
			//this.y += _vy;
		}
		
		protected function onAddedToStage(event:Event):void
		{
			init();
		}
	}
}