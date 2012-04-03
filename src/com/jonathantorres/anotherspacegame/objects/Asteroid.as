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
		private var _ax:Number = 0.0001;
		private var _ay:Number = 0.001;
		private var _vx:Number = 0.0;
		private var _vy:Number = 0.0;
		private var _speed:Number = 0.0001;
		
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
					break;
				
				case 'medium':
					_asteroid = new Image(Assets.getTexture('AsteroidMedium'));
					break;
				
				case 'large':
					_asteroid = new Image(Assets.getTexture('AsteroidBig'));
					break;
			}
			
			addChild(_asteroid);
		}
		
		public function animate():void
		{
			_ax += _speed;
			_ay += _speed;
			_vx += _ax;
			_vy += _ay;
			
			this.x -= _vx;
			//this.y += _vy;
		}
		
		protected function onAddedToStage(event:Event):void
		{
			init();
		}
	}
}