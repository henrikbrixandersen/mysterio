//
//  MysterioView.m
//  Mysterio
//
//  Created by Henrik Brix Andersen on 11/01/15.
//  Copyright (c) 2015 Henrik Brix Andersen. All rights reserved.
//

#import "MysterioPixel.h"
#import "MysterioView.h"

#pragma mark - Definitions

#define FRAME_RATE 10.0

#define PIXEL_COUNT_MAX 22
#define PIXEL_BORDER 0.10
#define PIXEL_CORNER_RADIUS 0.10

#pragma mark - Private Interface

@interface MysterioView()

#pragma mark TODO: NSArray as property
@property (strong, nonatomic) NSMutableArray *pixels;

@end

#pragma mark -

@implementation MysterioView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/FRAME_RATE];

		self.pixels = [NSMutableArray array];
		int width = self.bounds.size.width;
		int height = self.bounds.size.height;

		int pixelSize = MAX(width, height) / PIXEL_COUNT_MAX;

		int pixelsPerRow = width / pixelSize;
		int pixelsPerCol = height / pixelSize;

		int xOffset = (width - pixelSize * pixelsPerRow) / 2;
		int yOffset = (height - pixelSize * pixelsPerCol) / 2;

		for (int x = 0; x < pixelsPerRow; x++) {
			[self.pixels addObject:[NSMutableArray array]];

			for (int y = 0; y < pixelsPerCol; y++) {
				NSRect rect = NSMakeRect(xOffset + x * pixelSize,
										 yOffset + y * pixelSize,
										 pixelSize, pixelSize);
				MysterioPixel *pixel = [MysterioPixel pixelWithRect:rect
														 borderSize:pixelSize * PIXEL_BORDER
													   cornerRadius:pixelSize * PIXEL_CORNER_RADIUS
															  color:[[NSColor blueColor] colorWithAlphaComponent:0.75]];
				[[self.pixels objectAtIndex:x] addObject:pixel];
			}
		}
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
	NSColor *black = [NSColor blackColor];

	for (NSArray *column in self.pixels) {
		for (MysterioPixel *pixel in column) {
			if (SSRandomIntBetween(0, 1) == 0) {
				[black set];
			} else {
				[pixel.color set];
			}
			[pixel fill];
		}
	}

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
