package com.jonathantorres.anotherspacegame.objects
{
	import com.jonathantorres.anotherspacegame.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * @author Jonathan Torres
	 */
	public class Health extends Sprite
	{
		private var _vx:Number = 0.0;
		private var _vy:Number = 0.0;
		private var _speed:Number = 0.01;
		
		private var _health:Image;
		
		public function Health()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function init():void
		{
			_health = new Image(Assets.getTexture('HealthIcon'));
			_health.x = _health.width * 0.5;
			_health.y = _health.height * 0.5;
			addChild(_health);
		}
		
		public function animate():void
		{
			_vx += _speed;
			_vy += (_speed / 10);
			
			this.x -= _vx;
			this.y += _vy;
		}
		
		protected function onAddedToStage(event:Event):void
		{
			init();
		}
	}
}