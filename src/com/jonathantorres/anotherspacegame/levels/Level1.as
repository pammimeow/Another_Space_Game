package com.jonathantorres.anotherspacegame.levels
{
	import com.jonathantorres.anotherspacegame.Assets;
	import com.jonathantorres.anotherspacegame.objects.Asteroid;
	import com.jonathantorres.anotherspacegame.objects.EnemyShip;
	import com.jonathantorres.anotherspacegame.objects.Health;
	import com.jonathantorres.anotherspacegame.objects.Laser;
	import com.jonathantorres.anotherspacegame.objects.Lifeforce;
	import com.jonathantorres.anotherspacegame.objects.PlayerShip;
	import com.jonathantorres.anotherspacegame.ui.LevelNumber;
	import com.jonathantorres.anotherspacegame.ui.Lifebar;
	import com.jonathantorres.anotherspacegame.ui.Score;
	import com.jonathantorres.anotherspacegame.ui.Time;
	
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
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
		private var _life:Lifebar;
		private var _score:Score;
		private var _time:Time;
		private var _levelNum:LevelNumber;
		private var _enemyShips:Array;
		private var _enemyDeployment:Timer;
		private var _typesOfEnemies:Array;
		
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
			_topRock.y = _topRock.height - 5;
			_topRock.rotation = deg2rad(180);
			addChild(_topRock);
			
			_bottomRock = new Image(Assets.getTexture('Rocks'));
			_bottomRock.x = 0;
			_bottomRock.y = (stage.stageHeight) - (_bottomRock.height - 5);
			addChild(_bottomRock);
			
			_playerShip = new PlayerShip();
			addChild(_playerShip);
			
			/*_bigAsteroid = new Asteroid('small');
			_bigAsteroid.x = 800;
			_bigAsteroid.y = 300;
			addChild(_bigAsteroid);
			
			_health = new Health();
			_health.x = 300;
			_health.y = 300;
			addChild(_health);
			
			_lifeforce = new Lifeforce();
			_lifeforce.x = 600;
			_lifeforce.y = 230;
			addChild(_lifeforce);*/
			
			_life = new Lifebar();
			_life.x = 180;
			_life.y = stage.stageHeight - 25;
			addChild(_life);
			
			_score = new Score();
			_score.x = _life.x + 270;
			_score.y = stage.stageHeight - 25;
			addChild(_score);
			
			_time = new Time();
			_time.x = _score.x + 160;
			_time.y = stage.stageHeight - 25;
			addChild(_time);
			
			_levelNum = new LevelNumber();
			_levelNum.x = _time.x + 100;
			_levelNum.y = stage.stageHeight - 25;
			addChild(_levelNum);
			
			_enemyShips = new Array();
			_typesOfEnemies = new Array('gray', 'red', 'green');
			_enemyDeployment = new Timer(Math.random() * 2000 + 1000);
			_enemyDeployment.addEventListener(TimerEvent.TIMER, onEnemyDeploymentTimer);
			_enemyDeployment.start();
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function onEnterFrame(event:Event):void
		{
			var playerLasers:Array = _playerShip.lasers;
			var playerShipRect:Rectangle = _playerShip.ship.getBounds(this.parent);
			var topRockRect:Rectangle = _topRock.getBounds(this.parent);
			var bottomRockRect:Rectangle = _bottomRock.getBounds(this.parent);
			//var bigAsteroidRect:Rectangle = _bigAsteroid.getBounds(this.parent);
			//var healthRect:Rectangle = _health.getBounds(this.parent);
			//var lifeForceRect:Rectangle = _lifeforce.getBounds(this.parent);
			
			_playerShip.moveShip();
			//_bigAsteroid.animate();
			//_health.animate();
			//_lifeforce.animate();
			
			/*
			 * Animation and Collisions : Player ship and his lasers
			 */
			if (playerLasers.length != 0) {
				for (var k:int = 0; k < playerLasers.length; k++) {
					var playerLaser:Laser = Laser(playerLasers[k]);
					var playerLaserRect:Rectangle = playerLaser.getBounds(this.parent);
					
					playerLaser.animate('right');
					
					for (var l:int = 0; l < _enemyShips.length; l++) {
						var enemyShip:EnemyShip = _enemyShips[l];
						
						if (this.contains(enemyShip)) {
							var enemyShipRect:Rectangle = enemyShip.getBounds(this.parent);
							
							if (playerLaserRect.intersects(enemyShipRect)) {
								trace('Player hits an enemy');
							}
						}
					}
				}
			}
			
			/*
			 * Animation and Collisions : Enemy Ships and their lasers
			 */
			if (_enemyShips.length != 0) {
				for (var i:int = 0; i < _enemyShips.length; i++) {
					var enemy:EnemyShip = _enemyShips[i];
					var enemyLasers:Array = enemy.lasers;
					enemy.animate();
					
					if (enemy.x <= 0 - enemy.width) {
						removeChild(enemy);
					}
					
					if (this.contains(enemy)) {
						var enemyRect:Rectangle = enemy.getBounds(this.parent);
						
						if (playerShipRect.intersects(enemyRect)) {
							trace('Player ship hits enemy ship');
						}
					}
					
					if (enemyLasers.length != 0) {
						for (var j:int = 0; j < enemyLasers.length; j++) {
							var laser:Laser = enemyLasers[j];
							laser.animate('left');
							
							if (laser.x <= 0) {
								removeChild(laser);
							}
							
							if (this.contains(laser)) {
								var laserRect:Rectangle = laser.getBounds(this.parent);
								
								if (playerShipRect.intersects(laserRect)) {
									trace('enemy shot player');
								}
							}
						}
					}
				}
			}
			
			/*
			 * Collisions
			 */
			if ((playerShipRect.intersects(topRockRect)) || (playerShipRect.intersects(bottomRockRect))) {
				trace('Ship hits top or bottom rocks');
			}
			
			/*if (playerShipRect.intersects(bigAsteroidRect)) {
				trace('Ship hits asteroid');
			}
			
			if (playerShipRect.intersects(enemyShipRect)) {
				trace('Ship hits enemy ship');
			}
			
			for (var i:int = 0; i < enemyLasers.length; i++) {
				var enemyLaser:Laser = Laser(enemyLasers[i]);
				var enemyLaserRect:Rectangle = enemyLaser.getBounds(this.parent);
				
				enemyLaser.animate('left');
				
				if (playerShipRect.intersects(enemyLaserRect)) {
					trace('Player got hit by an enemy laser');
				}
			}
			
			for (var j:int = 0; j < playerLasers.length; j++) {
				var playerLaser:Laser = Laser(playerLasers[j]);
				var playerLaserRect:Rectangle = playerLaser.getBounds(this.parent);
				
				playerLaser.animate('right');
				
				if (enemyShipRect.intersects(playerLaserRect)) {
					trace('Player hits an enemy');
				}
			}
			
			if (playerShipRect.intersects(healthRect)) {
				trace('Player took a life bar');
			}
			
			if (playerShipRect.intersects(lifeForceRect)) {
				trace('Player took a life force');
			}*/
		}
		
		protected function onEnemyDeploymentTimer(event:TimerEvent):void
		{
			var enemyShip:EnemyShip = new EnemyShip(_typesOfEnemies[Math.floor(Math.random() * 3)]);
			enemyShip.x = stage.stageWidth + enemyShip.width;
			enemyShip.y = (Math.random() * _bottomRock.y) + _topRock.height;
			addChild(enemyShip);
			
			_enemyShips.push(enemyShip);
		}
		
		protected function onAddedToStage(event:Event):void
		{
			init();
		}
		
		protected function onRemovedFromStage(event:Event):void
		{
			
		}
	}
}