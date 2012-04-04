package com.jonathantorres.anotherspacegame.objects
{
	import com.jonathantorres.anotherspacegame.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * @author Jonathan Torres
	 */
	public class Laser extends Sprite
	{
		private var _laser:Image;
		private var _ax:Number = 2.0;
		private var _vx:Number = 0.0;
		private var _speed:Number = 0.005;
		private var _color:String;
		
		public function Laser(color:String)
		{
			super();
			
			_color = color;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function init():void
		{
			switch(_color) {
				case 'player':
					_laser = new Image(Assets.getTexture('PlayerLaser'));
					break;
				
				case 'red':
					_laser = new Image(Assets.getTexture('RedLaser'));
					break;
				
				case 'green':
					_laser = new Image(Assets.getTexture('GreenLaser'));
					break;
				
				case 'blue':
					_laser = new Image(Assets.getTexture('BlueLaser'));
					break;
			}
			
			addChild(_laser);
		}
		
		public function animate(direction:String):void
		{
			_ax += _speed;
			_vx += _ax;
			
			if (direction == 'right') {
				this.x += _vx;
			} else if (direction == 'left') {
				this.x -= _vx;
			}
		}
		
		protected function onAddedToStage(event:Event):void
		{
			init();
		}
	}
}