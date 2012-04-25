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
		private var _topRockRect:Rectangle;
		private var _bottomRock:Image;
		private var _bottomRockRect:Rectangle;
		
		private var _playerShip:PlayerShip;
		private var _playerShipRect:Rectangle;
		private var _playerLasers:Array;
		
		private var _enemyShips:Array;
		private var _enemyDeployment:Timer;
		private var _typesOfEnemies:Array;
		
		private var _asteroids:Array;
		private var _asteroidDeployment:Timer;
		private var _typesOfAsteroids:Array;
		
		private var _healthbars:Array;
		private var _healthbarsDeployment:Timer;
		
		private var _lifeforces:Array;
		private var _lifeforceDeployment:Timer;
		
		private var _life:Lifebar;
		private var _score:Score;
		private var _time:Time;
		private var _levelNum:LevelNumber;
		
		private var _shipIsProtected:Boolean;

		private var _protectingLifeforce:Lifeforce;
		
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
			_enemyDeployment = new Timer(2000, 50);
			_enemyDeployment.addEventListener(TimerEvent.TIMER, onEnemyDeploymentTimer);
			_enemyDeployment.start();
			
			_healthbars = new Array();
			_healthbarsDeployment = new Timer(10000, 10);
			_healthbarsDeployment.addEventListener(TimerEvent.TIMER, onHealthbarDeploymentTimer);
			_healthbarsDeployment.start();
			
			_asteroids = new Array();
			_typesOfAsteroids = new Array('small', 'medium', 'large');
			_asteroidDeployment = new Timer(4000, 20);
			_asteroidDeployment.addEventListener(TimerEvent.TIMER, onAsteroidDeploymentTimer);
			_asteroidDeployment.start();
			
			_lifeforces = new Array();
			_lifeforceDeployment = new Timer(12000, 5);
			_lifeforceDeployment.addEventListener(TimerEvent.TIMER, onLifeforceDeploymentTimer);
			_lifeforceDeployment.start();
			
			_shipIsProtected = false;
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function onEnterFrame(event:Event):void
		{
			_playerLasers = _playerShip.lasers;
			_playerShipRect = _playerShip.ship.getBounds(this.parent);
			_topRockRect = _topRock.getBounds(this.parent);
			_bottomRockRect = _bottomRock.getBounds(this.parent);
			
			_playerShip.moveShip();
			updateLifeforcePosition();
			
			/*
			* Collision : Ship with the top and the bottom rocks
			*/
			if ((_playerShipRect.intersects(_topRockRect)) || (_playerShipRect.intersects(_bottomRockRect))) {
				//trace('Ship hits top or bottom rocks');
			}
			
			/*
			 * Animation and Collisions : Player ship and his lasers
			 */
			for (var k:int = 0; k < _playerLasers.length; k++) {
				var playerLaser:Laser = Laser(_playerLasers[k]);
				var playerLaserRect:Rectangle = playerLaser.getBounds(this.parent);
				
				playerLaser.animate('right');
				
				for (var l:int = 0; l < _enemyShips.length; l++) {
					var enemyShip:EnemyShip = _enemyShips[l];
					
					if (this.contains(enemyShip)) {
						var enemyShipRect:Rectangle = enemyShip.getBounds(this.parent);
						
						if (playerLaserRect.intersects(enemyShipRect)) {
							//trace('Player hits an enemy');
							removeChild(enemyShip);
							_enemyShips.splice(l, 1);
							
							removeChild(playerLaser);
							_playerShip.lasers.splice(k, 1);
							continue;
						}
					}
				}
				
				for (var o:int = 0; o < _asteroids.length; o++) {
					var asteroid:Asteroid = _asteroids[o];
					
					if (this.contains(asteroid)) {
						var asteroidRect:Rectangle = asteroid.getBounds(this.parent);
						
						if (playerLaserRect.intersects(asteroidRect)) {
							//trace('Player hits an asteroid');
							removeChild(asteroid);
							_asteroids.splice(o, 1);
							
							removeChild(playerLaser);
							_playerShip.lasers.splice(k, 1);
							continue;
						}
					}
				}
			}
			
			/*
			 * Animation and Collisions : Enemy Ships and their lasers
			 */
			for (var i:int = 0; i < _enemyShips.length; i++) {
				var enemy:EnemyShip = _enemyShips[i];
				var enemyLasers:Array = enemy.lasers;
				enemy.animate();
				
				if (enemy.x <= 0 - enemy.width) {
					removeChild(enemy);
					_enemyShips.splice(i, 1);
					continue;
					//trace('Enemies: ' + _enemyShips.length);
				}
				
				if (this.contains(enemy)) {
					var enemyRect:Rectangle = enemy.getBounds(this.parent);
					
					if (_playerShipRect.intersects(enemyRect)) {
						removeProtectingLifeforce();
						
						removeChild(enemy);
						_enemyShips.splice(i, 1);
						continue;
						//trace('Player ship hits enemy ship');
					}
					
					if ((enemyRect.intersects(_topRockRect)) || (enemyRect.intersects(_bottomRockRect))) {
						removeChild(enemy);
						_enemyShips.splice(i, 1);
						continue;
						//trace('Enemy hits top or bottom rocks');
					}
				}
				
				for (var j:int = 0; j < enemyLasers.length; j++) {
					var laser:Laser = enemyLasers[j];
					laser.animate('left');
					
					if (laser.x <= 0) {
						removeChild(laser);
						enemyLasers.splice(j, 1);
						continue;
						//trace('Enemies: ' + _enemyShips.length);
					}
					
					if (this.contains(laser)) {
						var laserRect:Rectangle = laser.getBounds(this.parent);
						
						if (_playerShipRect.intersects(laserRect)) {
							//trace('enemy shot player');
							removeProtectingLifeforce();
							
							removeChild(laser);
							enemyLasers.splice(j, 1);
							continue;
						}
					}
				}
			}
			
			/*
			* Animation and Collisions : Asteroids
			*/
			for (var n:int = 0; n < _asteroids.length; n++) {
				var theAsteroid:Asteroid = _asteroids[n];
				theAsteroid.animate();
				
				if (this.contains(theAsteroid)) {
					var theAsteroidRect:Rectangle = theAsteroid.getBounds(this.parent);
					
					if (_playerShipRect.intersects(theAsteroidRect)) {
						//trace('player ship hits asteroid');
						removeProtectingLifeforce();
						
						removeChild(theAsteroid);
						_asteroids.splice(n, 1);
						continue;
					}
				}
			}
			
			/*
			* Animation and Collisions : Healthbars
			*/
			for (var m:int = 0; m < _healthbars.length; m++) {
				var healthbar:Health = _healthbars[m];
				healthbar.animate();
				
				if (this.contains(healthbar)) {
					var healthbarRect:Rectangle = healthbar.getBounds(this.parent);
					
					if (_playerShipRect.intersects(healthbarRect)) {
						//trace('player takes health bar');
						removeChild(healthbar);
						_healthbars.splice(m, 1);
						continue;
					}
				}
			}
			
			/*
			* Animation and Collisions : Lifeforces
			*/
			for (var p:int = 0; p < _lifeforces.length; p++) {
				var lifeforce:Lifeforce = _lifeforces[p];
				lifeforce.animate();
				
				if (this.contains(lifeforce)) {
					var lifeforceRect:Rectangle = lifeforce.getBounds(this.parent);
					
					if (_playerShipRect.intersects(lifeforceRect)) {
						//trace('player protects ship');
						addProtectingLifeforce();
						
						removeChild(lifeforce);
						_lifeforces.splice(p, 1);
						continue;
					}
				}
			}
			
		}
		
		protected function updateLifeforcePosition():void
		{
			if (_shipIsProtected && (_protectingLifeforce != null)) {
				_protectingLifeforce.x = _playerShip.x - 250;
				_protectingLifeforce.y = _playerShip.y - 150;
			}
		}
		
		protected function addProtectingLifeforce():void
		{
			if (!_shipIsProtected) {
				_protectingLifeforce = new Lifeforce();
				_protectingLifeforce.scaleX = _protectingLifeforce.scaleY = 3.0;
				_protectingLifeforce.x = _playerShip.x - 250;
				_protectingLifeforce.y = _playerShip.y - 150;
				addChild(_protectingLifeforce);
				
				_shipIsProtected = true;
			}
		}
		
		protected function removeProtectingLifeforce():void
		{
			if (_shipIsProtected && (_protectingLifeforce != null)) {
				removeChild(_protectingLifeforce);
				_shipIsProtected = false;
			}
		}
		
		protected function onLifeforceDeploymentTimer(event:TimerEvent):void
		{
			var lifeforce:Lifeforce = new Lifeforce();
			lifeforce.x = stage.stageWidth + (lifeforce.width) + 20;
			lifeforce.y = (Math.random() * (350 - (_topRock.height + 50))) + _topRock.height;
			addChild(lifeforce);
			
			_lifeforces.push(lifeforce);
		}
		
		protected function onAsteroidDeploymentTimer(event:TimerEvent):void
		{
			var asteroid:Asteroid = new Asteroid(_typesOfAsteroids[Math.floor(Math.random() * 3)]);
			asteroid.x = stage.stageWidth + (asteroid.width) + 50;
			asteroid.y = (Math.random() * (350 - (_topRock.height + 50))) + _topRock.height;
			addChild(asteroid);
			
			_asteroids.push(asteroid);
		}
		
		protected function onEnemyDeploymentTimer(event:TimerEvent):void
		{
			var enemyShip:EnemyShip = new EnemyShip(_typesOfEnemies[Math.floor(Math.random() * 3)]);
			enemyShip.x = stage.stageWidth + enemyShip.width;
			enemyShip.y = (Math.random() * (350 - (_topRock.height + 50))) + _topRock.height;
			addChild(enemyShip);
			
			_enemyShips.push(enemyShip);
		}
		
		protected function onHealthbarDeploymentTimer(event:TimerEvent):void
		{
			var healthbar:Health = new Health();
			healthbar.x = stage.stageWidth + healthbar.width;
			healthbar.y = (Math.random() * (350 - (_topRock.height + 50))) + _topRock.height;
			addChild(healthbar);
			
			_healthbars.push(healthbar);
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