//
//  MysterioBlueLayerAnimator.m
//  Mysterio
//
//  Created by Henrik Brix Andersen on 19/01/15.
//  Copyright (c) 2015 Henrik Brix Andersen. All rights reserved.
//

@import ScreenSaver;

#import "MysterioLayer.h"
#import "MysterioPixel.h"
#import "MysterioBackgroundPixelLayerDelegate.h"

@interface MysterioBackgroundPixelLayerDelegate()

@property (nonatomic) BOOL initialized;

@end

@implementation MysterioBackgroundPixelLayerDelegate

- (void)initializeLayer:(MysterioLayer*)layer
{
	for (NSArray *column in layer.pixels) {
		for (MysterioPixel *pixel in column) {
			if (SSRandomFloatBetween(0, 1) < 0.5) {
				pixel.color = [pixel.color colorWithAlphaComponent:0];
			}
		}
	}
}

- (void)animateLayerOneFrame:(MysterioLayer*)layer
{
	if (!self.initialized) {
		[self initializeLayer:layer];
		self.initialized = TRUE;
	}

	for (NSArray *column in layer.pixels) {
		for (MysterioPixel *pixel in column) {
			// TODO: Animate pixel alpha value
			[pixel.color set];
			[pixel fill];
		}
	}
}

@end
