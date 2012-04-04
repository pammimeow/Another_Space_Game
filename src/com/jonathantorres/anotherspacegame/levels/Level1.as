package com.jonathantorres.anotherspacegame.levels
{
	import com.jonathantorres.anotherspacegame.Assets;
	import com.jonathantorres.anotherspacegame.objects.Asteroid;
	import com.jonathantorres.anotherspacegame.objects.EnemyShip;
	import com.jonathantorres.anotherspacegame.objects.Health;
	import com.jonathantorres.anotherspacegame.objects.Laser;
	import com.jonathantorres.anotherspacegame.objects.Lifeforce;
	import com.jonathantorres.anotherspacegame.objects.PlayerShip;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.ParticleDesignerPS;
	import starling.text.TextField;
	import starling.utils.deg2rad;
	
	/**
	 * @author Jonathan Torres
	 */
	public class Level1 extends Sprite
	{
		private var _topRock:Image;
		private var _bottomRock:Image;
		private var _bigAsteroid:Asteroid;
		private var _playerShip:PlayerShip;
		private var _enemyShip:EnemyShip;
		private var _health:Health;
		private var _lifeforce:Lifeforce;
		
		public function Level1()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		protected function init():void
		{
			_topRock = new Image(Assets.getTexture('Rocks'));
			_topRock.x = stage.stageWidth;
			_topRock.y = _topRock.height;
			_topRock.rotation = deg2rad(180);
			addChild(_topRock);
			
			_bottomRock = new Image(Assets.getTexture('Rocks'));
			_bottomRock.x = 0;
			_bottomRock.y = (stage.stageHeight) - _bottomRock.height;
			addChild(_bottomRock);
			
			_playerShip = new PlayerShip();
			addChild(_playerShip);
			
			_bigAsteroid = new Asteroid('small');
			_bigAsteroid.x = 800;
			_bigAsteroid.y = 300;
			addChild(_bigAsteroid);
			
			_enemyShip = new EnemyShip('red');
			_enemyShip.x = 800;
			_enemyShip.y = 250;
			addChild(_enemyShip);
			
			_health = new Health();
			_health.x = 300;
			_health.y = 300;
			addChild(_health);
			
			_lifeforce = new Lifeforce();
			_lifeforce.x = 600;
			_lifeforce.y = 230;
			addChild(_lifeforce);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function onEnterFrame(event:Event):void
		{
			_playerShip.moveShip();
			_bigAsteroid.animate();
			_enemyShip.animate();
			_health.animate();
			_lifeforce.animate();
			
			var playerLasers:Array = _playerShip.lasers;
			var enemyLasers:Array = _enemyShip.lasers;
			
			for (var i:int = 0; i < playerLasers.length; i++) {
				Laser(playerLasers[i]).animate('right');
			}
			
			for (var j:int = 0; j < enemyLasers.length; j++) {
				Laser(enemyLasers[j]).animate('left');
			}
		}
		
		protected function onAddedToStage(event:Event):void
		{
			init();
			//trace('Added: ' + this);
		}
		
		protected function onRemovedFromStage(event:Event):void
		{
			//trace('Removed: ' + this);
		}
	}
}