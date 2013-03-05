Starling Extension: Parallax Layer
===================================

This extension is a custom Sprite to easily create parallax scrolling layers without worrying about the viewport size and your tile size. 

You can use it for regular non-parallax scrolls as well.

Features
--------

The Parallax Layer will scroll a texture (or tiled texture) seamlessly filling the entire Starling viewport width or height, regardless the size of the viewport or the texture.

You can set the base speed, speed factor, direction and axis for each layer.

Layers can autoscroll, or can be controlled externally via `advanceStep()` function.


Installation
------------

In the `src`-directory, you will find the ParallaxLayer class. You can either copy it directly to your Starling-powered application, or you add the source path to your FlexBuilder project.


Sample Code
-----------

The class `ParallaxLayer` extends `Sprite` and behaves accordingly. You can add it as a child to the stage or any other container. 


	var layer1:ParallaxLayer; 
	var layer2:ParallaxLayer;
	var layer3:ParallaxLayer;

	layer1 = new ParallaxLayer(Texture.fromBitmap("tile1.png"), 5, 1.0, ParallaxLayer.BACKWARDS, ParallaxLayer.X_AXIS, true);
	layer2 = new ParallaxLayer(Texture.fromBitmap("tile2.png"), 5, 0.5, ParallaxLayer.BACKWARDS, ParallaxLayer.X_AXIS, true);
	layer3 = new ParallaxLayer(Texture.fromBitmap("tile3.png"), 5, 0.3, ParallaxLayer.BACKWARDS, ParallaxLayer.X_AXIS, true);

	addChild(layer3);
	addChild(layer2);
	addChild(layer1);


	
Limitations
-----------

Regardless it's container and depending on the axis choosen, the ParallaxLayer MUST be placed on global x = 0 or y = 0 since it was designed to fill the entire screen on the choosen axis.


More information
----------------

You can find more information about Starling Framework at http://www.starling-framework.org
