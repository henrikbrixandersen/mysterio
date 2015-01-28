/**
 * Copyright (c) 2015, Henrik Brix Andersen <henrik@brixandersen.dk>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

@import ScreenSaver;

#import "MysterioLayer.h"
#import "MysterioPixel.h"
#import "MysterioBackgroundPixelLayerDelegate.h"

#pragma mark - Private Interface

@interface MysterioBackgroundPixelLayerDelegate()

@property (nonatomic) BOOL initialized;

@end

#pragma mark - Implementation

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
