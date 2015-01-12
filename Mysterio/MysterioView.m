//
//  MysterioView.m
//  Mysterio
//
//  Created by Henrik Brix Andersen on 11/01/15.
//  Copyright (c) 2015 Henrik Brix Andersen. All rights reserved.
//

#import "MysterioView.h"

#pragma mark - Definitions

#define MAX_PIXELS 22
#define PIXEL_SEPARATION 16
#define PIXEL_ROUNDING 10

#pragma mark - Private Interface

@interface MysterioView()

#pragma mark TODO: NSArray as property
@property (strong, nonatomic) NSMutableArray *pixels;

@end

#pragma mark -

#pragma mark TODO: Add

@implementation MysterioView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/10.0];

		self.pixels = [NSMutableArray array];
		int width = self.bounds.size.width;
		int height = self.bounds.size.height;

		int pixelSize = MAX(width, height) / MAX_PIXELS;

		int pixelsPerRow = width / pixelSize;
		int pixelsPerCol = height / pixelSize;

		int rowOffset = (width - pixelSize * pixelsPerRow) / 2;
		int colOffset = (height - pixelSize * pixelsPerCol) / 2;

		for (int x = 0; x < pixelsPerRow; x++) {
			[self.pixels addObject:[NSMutableArray array]];

			for (int y = 0; y < pixelsPerCol; y++) {
				NSRect rect = NSMakeRect(rowOffset + x * pixelSize + pixelSize / PIXEL_SEPARATION,
										 colOffset + y * pixelSize + pixelSize / PIXEL_SEPARATION,
										 pixelSize - pixelSize / (PIXEL_SEPARATION / 2),
										 pixelSize - pixelSize / (PIXEL_SEPARATION / 2));
				NSBezierPath *pixel = [NSBezierPath bezierPathWithRoundedRect:rect
																	  xRadius:pixelSize / PIXEL_ROUNDING
																	  yRadius:pixelSize / PIXEL_ROUNDING];

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
	NSColor *black = [NSColor blueColor];
	NSColor *blue = [NSColor blackColor];

	for (NSArray *column in self.pixels) {
		for (NSBezierPath *pixel in column) {
			if (SSRandomIntBetween(0, 1) == 0) {
				[black setFill];
			} else {
				[blue setFill];
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
