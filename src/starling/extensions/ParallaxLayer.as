// =================================================================================================
//
//	Parallax Layer extension for Starling Framework
//	Copyright 2012 Antonio Rodriguez Fernandez
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package starling.extensions {
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.display.BlendMode;
	import starling.events.EnterFrameEvent;
	
	
	public class ParallaxLayer extends Sprite {
		
		public static const X_AXIS:Boolean = true;
		public static const Y_AXIS:Boolean = false;
		public static const FORWARD:Boolean = true;
		public static const BACKWARDS:Boolean = false;
		
		private var _tileTex:Texture;
		private var _baseSpeed:Number;
		private var _speedFactor:Number;
		private var _tileSize:int;
		private var _layerSize:int;
		private var _scrollAxis:Boolean;
		private var _scrollDir:Boolean;
		
		private var _speed:Number;
		private var _viewPortSize:int;
		private var _thisSize:int;
		private var _retPoint:int;
		private var _autoRun:Boolean;
		private var _blendMode:String;
		
		
		
		private var auxTile:Image;
		private var reps:int; 


		public function ParallaxLayer(tileTex:Texture, baseSpeed:Number, speedFactor:Number,  dir:Boolean = true, axis:Boolean = true, autoRun:Boolean = true, blendMode:String = BlendMode.AUTO) {
			_scrollAxis = axis;
			_scrollDir = dir;
			_baseSpeed = baseSpeed;
			_speedFactor = speedFactor;
			_tileTex = tileTex;
			_autoRun = autoRun;
			_blendMode = blendMode;
			
			_speed = _baseSpeed * _speedFactor; 
			
			_viewPortSize = _scrollAxis == true ? Starling.current.stage.stageWidth : Starling.current.stage.stageHeight;
			
			init();
		}
		
		
		private function init():void {
			auxTile = new Image(_tileTex);
			
			
			_tileSize = _scrollAxis == true ? auxTile.width : auxTile.height;
			
			addChild(auxTile);
			reps = Math.ceil(_viewPortSize / _tileSize);
			reps++;
			
			if (reps * _tileSize < _viewPortSize + _tileSize) {
				reps++;
			}
			
			for (var i:int = 1; i < reps; i++) {
				auxTile = new Image(auxTile.texture);
				
				if (_scrollAxis) {
					auxTile.x += _tileSize * i;
				} else {
					auxTile.y += _tileSize * i;
				}
				addChild(auxTile);
			}
			
			
			flatten();
			this.blendMode = _blendMode;
			
			if (_scrollAxis) {
				_thisSize = this.width;
			} else {
				_thisSize = this.height;
			}
			
			
			
			if (_tileSize > _viewPortSize) {
				
				_retPoint = -_tileSize;
				
			} else {
				_retPoint = -(_thisSize - _viewPortSize);
				
			}
			
			if (_autoRun) {
				_autoRun = false;
				start(_baseSpeed, _speedFactor);
			}
			
		}
		
		
		
		public function advanceStep(baseSpeed:Number = 0):void {
			if (!_autoRun) {
				if (baseSpeed < 0) {
					_scrollDir = BACKWARDS;
				} else {
					_scrollDir = FORWARD;
				}
				_speed = Math.abs(baseSpeed) * _speedFactor; 
			}
			
			var aux:Number;
						
			if (_scrollAxis) {
				if (_scrollDir) {
					aux = this.x + _speed;
					if (aux >= 0) { 
						this.x = _retPoint;
					} else {
						this.x = aux;
					}
				} else {
					aux = this.x - _speed;
							
					if (aux <= _retPoint) { 
						
						this.x = 0;
					} else {
						this.x = aux;
					}
				}
				
			} else {
				if (_scrollDir) {
					aux = this.y + _speed;
					if (aux >= 0) {
						this.y = _retPoint;
					} else {
						this.y = aux;
					}
				} else {
					aux = this.y - _speed;
					if (aux <= _retPoint) {
						this.y = 0;
					} else {
						this.y = aux;
					}
				}
			}
		}
		
		
		public function start(baseSpeed:Number, speedFactor:Number):void {
			if (!_autoRun) {
				_baseSpeed = baseSpeed;
				_speedFactor = speedFactor;
				_speed = _baseSpeed * _speedFactor; 
				_autoRun = true;
				addEventListener(EnterFrameEvent.ENTER_FRAME, _animate);
			}
		}
		
		public function stop():void {
			if (_autoRun) {
				_autoRun = false;
				this.removeEventListener(EnterFrameEvent.ENTER_FRAME, _animate);
			}
		}
		
		
		public function get baseSpeed():Number {
			return _baseSpeed;
		}
		
		public function set baseSpeed(baseSpeed:Number):void {
			_baseSpeed = baseSpeed;
			_speed = _baseSpeed * _speedFactor;
		}
		
		public function get speedFactor():Number {
			return _speedFactor;
		}
		
		public function set speedFactor(speedFactor:Number):void {
			_speedFactor = speedFactor;
			_speed = _baseSpeed * _speedFactor;
		}
		
		public function get scrollDir():Boolean {
			return _scrollDir;
		}
		
		public function set scrollDir(dir:Boolean):void {
			_scrollDir = dir;
		}
				
		private  function _animate(e:EnterFrameEvent):void {
			advanceStep();
		}
		

	}
}