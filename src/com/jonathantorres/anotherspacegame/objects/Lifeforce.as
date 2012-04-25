package com.jonathantorres.anotherspacegame.objects
{
	import com.jonathantorres.anotherspacegame.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.TextureSmoothing;
	
	/**
	 * @author Jonathan Torres
	 */
	public class Lifeforce extends Sprite
	{
		private var _vx:Number = 0.0;
		private var _vy:Number = 0.0;
		private var _speed:Number = 0.01;
		
		private var _lifeforce:Image;
		
		public function Lifeforce()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function init():void
		{
			_lifeforce = new Image(Assets.getTexture('LifeforceSmall'));
			_lifeforce.smoothing = TextureSmoothing.BILINEAR;
			_lifeforce.x = _lifeforce.width * 0.5;
			_lifeforce.y = _lifeforce.height * 0.5;
			addChild(_lifeforce);
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