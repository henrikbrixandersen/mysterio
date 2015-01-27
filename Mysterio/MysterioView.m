//
//  MysterioView.m
//  Mysterio
//
//  Created by Henrik Brix Andersen on 11/01/15.
//  Copyright (c) 2015 Henrik Brix Andersen. All rights reserved.
//

#import "MysterioLayer.h"
#import "MysterioBlueLayerAnimationDelegate.h"
#import "MysterioView.h"

#pragma mark - Definitions

#define FRAME_RATE 10.0

#define PIXEL_COUNT_MAX 22
#define PIXEL_BORDER 0.10
#define PIXEL_CORNER_RADIUS 0.10

#pragma mark - Private Interface

@interface MysterioView()

@property (strong, nonatomic) MysterioLayer *blueLayer;
@property (strong, nonatomic) MysterioLayer *whiteLayer;

@end

#pragma mark -

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

		self.blueLayer = [MysterioLayer layerWithPixelSize:pixelSize
													 color:[NSColor blueColor]
													  rows:rows
												   columns:cols
												   xOffset:xOffset
												   yOffset:yOffset
												borderSize:pixelSize * PIXEL_BORDER
											  cornerRadius:pixelSize * PIXEL_CORNER_RADIUS];
		self.blueLayer.delegate = [[MysterioBlueLayerAnimationDelegate alloc] init];

		self.whiteLayer = [MysterioLayer layerWithPixelSize:pixelSize
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
	[self.blueLayer animateLayerOneFrame];

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
