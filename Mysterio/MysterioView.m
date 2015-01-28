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

#import "MysterioLayer.h"
#import "MysterioBackgroundPixelLayerDelegate.h"
#import "MysterioView.h"

#pragma mark - Definitions

#define FRAME_RATE 10.0

#define PIXEL_COUNT_MAX 22
#define PIXEL_BORDER 0.10
#define PIXEL_CORNER_RADIUS 0.10

#pragma mark - Private Interface

@interface MysterioView()

@property (strong, nonatomic) MysterioLayer *backgroundLayer;
@property (strong, nonatomic) MysterioLayer *foregroundLayer;

@end

#pragma mark - Implementation

@implementation MysterioView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1 / FRAME_RATE];

		int width = self.bounds.size.width;
		int height = self.bounds.size.height;

		int pixelSize = MAX(width, height) / PIXEL_COUNT_MAX;

		int rows = width / pixelSize;
		int cols = height / pixelSize;

		int xOffset = (width - pixelSize * rows) / 2;
		int yOffset = (height - pixelSize * cols) / 2;

		self.backgroundLayer = [MysterioLayer layerWithPixelSize:pixelSize
														   color:[NSColor blueColor]
															rows:rows
														 columns:cols
														 xOffset:xOffset
														 yOffset:yOffset
													  borderSize:pixelSize * PIXEL_BORDER
													cornerRadius:pixelSize * PIXEL_CORNER_RADIUS];
		self.backgroundLayer.delegate = [[MysterioBackgroundPixelLayerDelegate alloc] init];

		self.foregroundLayer = [MysterioLayer layerWithPixelSize:pixelSize
														   color:[NSColor whiteColor]
															rows:rows
														 columns:cols
														 xOffset:xOffset
														 yOffset:yOffset
													  borderSize:pixelSize * PIXEL_BORDER
													cornerRadius:pixelSize * PIXEL_CORNER_RADIUS];
	}

    return self;
}

- (void)drawRect:(NSRect)rect
{
	[super drawRect:rect];

	//[[NSGraphicsContext currentContext] setCompositingOperation:NSCompositeCopy];
	//[self.blueLayer fill];

	// FIXME: Only select Overlay if the corresponding blue pixel has an alpha value over threshold
	//[[NSGraphicsContext currentContext] setCompositingOperation:NSCompositeOverlay];
	//[self.whiteLayer fill];
}

- (void)animateOneFrame
{
	[super drawRect:self.bounds];
	[self.backgroundLayer animateLayerOneFrame];

	// Parameters: Ramp up/Ramp down/Stay (with biggest chance of Stay)
	//             Ramp rate (Only changed when entering Ramp up/Ramp down)

	// Chance of change can be different for blue and white pixels
	// (blue should change less often than white)

	// Ramp rate can be different for blue and white pixels
	// (white should ramp up/down faster than blue)

	// Finally: Add "rolling" vectors for increasing the chance of fast ramp up for white pixels

	/*
	for (NSArray *column in self.bluePixels) {
		for (MysterioPixel *pixel in column) {
			CGFloat alpha = pixel.color.alphaComponent;

			switch(SSRandomIntBetween(0, 2)) {
				default:
				case 0:
					// No change
					break;

				case 1:
					alpha -= 0.1;
					break;

				case 2:
					alpha += 0.1;
					break;
			}

			pixel.color = [pixel.color colorWithAlphaComponent:alpha];
		}
	}

	for (NSArray *column in self.whitePixels) {
		for (MysterioPixel *pixel in column) {
			CGFloat alpha = pixel.color.alphaComponent;

			switch(SSRandomIntBetween(0, 2)) {
				default:
				case 0:
					// No change
					break;

				case 1:
					alpha -= 0.2;
					break;

				case 2:
					alpha += 0.2;
					break;
			}

			pixel.color = [pixel.color colorWithAlphaComponent:alpha];
		}
	}
*/
	//[self setNeedsDisplay:YES];

    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
