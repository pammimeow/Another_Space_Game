package com.jonathantorres.anotherspacegame.ui
{
	import flash.display.Sprite;
	
	/**
	 * @author Jonathan Torres
	 */
	public class RoundedRectangle extends Sprite
	{
		private var _rectWidth:Number;
		private var _rectHeight:Number;
		
		public function RoundedRectangle(width:Number = 200, height:Number = 30)
		{
			super();
			
			_rectWidth = width;
			_rectHeight = height;
			
			this.graphics.lineStyle(1.0, 0xFFFFFF, 1.0);
			this.graphics.beginFill(0x262626, 1.0);
			this.graphics.drawRoundRect(0, 0, (_rectWidth - 1), (_rectHeight - 1), 20, 20);
			this.graphics.endFill();
		}

		public function get rectWidth():Number
		{
			return _rectWidth;
		}

		public function set rectWidth(value:Number):void
		{
			_rectWidth = value;
		}

		public function get rectHeight():Number
		{
			return _rectHeight;
		}

		public function set rectHeight(value:Number):void
		{
			_rectHeight = value;
		}
	}
}