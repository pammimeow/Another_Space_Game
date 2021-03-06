package com.jonathantorres.anotherspacegame
{
	import flash.display.Bitmap;
	import flash.media.Sound;
	import flash.text.Font;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;

	/**
	 * @author Jonathan Torres
	 */
	public class Assets
	{
		/*The Player Spaceship*/
		[Embed(source="../../../../assets/textures/spaceship.png")]
		private static const MainShip:Class;
		
		/*The player spaceship thrust (fire) XML*/
		[Embed(source="../../../../assets/particles/shipfire_particle.pex", mimeType="application/octet-stream")]
		private static const MainShipThrustParticle:Class;
		
		/*The player spaceship thrust (fire) (texture)*/
		[Embed(source="../../../../assets/particles/shipfire_texture.png")]
		private static const MainShipThrust:Class;
		
		/*Asteriods*/
		[Embed(source="../../../../assets/textures/asteriod_big.png")]
		private static const AsteroidBig:Class;
		
		[Embed(source="../../../../assets/textures/asteriod_medium.png")]
		private static const AsteroidMedium:Class;
		
		[Embed(source="../../../../assets/textures/asteriod_small.png")]
		private static const AsteroidSmall:Class;
		
		/*Lasers*/
		[Embed(source="../../../../assets/textures/blue_laser.png")]
		private static const BlueLaser:Class;
		
		[Embed(source="../../../../assets/textures/green_laser.png")]
		private static const GreenLaser:Class;
		
		[Embed(source="../../../../assets/textures/red_laser.png")]
		private static const RedLaser:Class;
		
		[Embed(source="../../../../assets/textures/player_laser.png")]
		private static const PlayerLaser:Class;
		
		/*Enemies*/
		[Embed(source="../../../../assets/textures/enemy_ship_gray.png")]
		private static const EnemyShipGray:Class;
		
		[Embed(source="../../../../assets/textures/enemy_ship_red.png")]
		private static const EnemyShipRed:Class;
		
		[Embed(source="../../../../assets/textures/enemy_ship_green.png")]
		private static const EnemyShipGreen:Class;
		
		/*Lifeforces*/
		[Embed(source="../../../../assets/textures/lifeforce_small.png")]
		private static const LifeforceSmall:Class;
		
		[Embed(source="../../../../assets/textures/lifeforce_big.png")]
		private static const LifeforceBig:Class;
		
		/*Health Icon*/
		[Embed(source="../../../../assets/textures/health_icon.png")]
		private static const HealthIcon:Class;
		
		/*The Rocks on top and bottom*/
		[Embed(source="../../../../assets/textures/rocks.png")]
		private static const Rocks:Class;
		
		/*The Space World*/
		[Embed(source="../../../../assets/textures/the_space.jpg")]
		private static const SpaceWorld:Class;
		
		/*Fonts*/
		[Embed(source="../../../../assets/fonts/Arial-Narrow.ttf", embedAsCFF="false", fontName="Arial Narrow", mimeType="application/x-font-truetype")]
		private static const ArialNarrow:Class;
		
		[Embed(source="../../../../assets/fonts/Futura-CondensedMedium.ttf", embedAsCFF="false", fontName="Futura Condensed Medium", fontFamily="Futura", mimeType="application/x-font-truetype")]
		private static const Futura:Class;
		
		/*Sounds*/
		[Embed(source="../../../../assets/sounds/game_music.mp3")]
		private static const BackgroundMusic:Class;
		
		[Embed(source="../../../../assets/sounds/laser.mp3")]
		private static const LaserSound:Class;
		
		private static var _textureAssets:Dictionary = new Dictionary();
		private static var _xmlAssets:Dictionary = new Dictionary();
		private static var _soundAssets:Dictionary = new Dictionary();
		
		public function Assets() { }
		
		public static function getTexture(name:String):Texture
		{	
			if (_textureAssets[name] == undefined) {
				var bitmap:Bitmap = Bitmap(new Assets[name]());
				_textureAssets[name] = Texture.fromBitmap(bitmap);
			}
			
			return _textureAssets[name];
		}
		
		public static function getParticleXML(name:String):XML
		{
			if (_xmlAssets[name] == undefined) {
				_xmlAssets[name] = XML(new Assets[name]());
			}
			
			return _xmlAssets[name];
		}
		
		public static function prepareSounds():void
		{
			_soundAssets['BackgroundMusic'] = new BackgroundMusic();
			_soundAssets['LaserSound'] = new LaserSound();
		}
		
		public static function getSound(name:String):Sound
		{
			var sound:Sound = Sound(_soundAssets[name]);
			return sound;
		}
		
		public static function getFont(name:String):Font
		{
			var font:Font = new Assets[name]();
			return font;
		}
	}
}