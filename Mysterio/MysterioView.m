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

#define FRAME_RATE 5.0

#define PIXEL_COUNT_MAX 22
#define PIXEL_BORDER 0.10
#define PIXEL_CORNER_RADIUS 0.10

#pragma mark - Private Interface

@interface MysterioView()

@property (strong, nonatomic) NSArray *bluePixels;
@property (strong, nonatomic) NSArray *whitePixels;

+ (NSArray*)createPixelsWithSize:(NSInteger)size
						   color:(NSColor*)color
							rows:(NSInteger)rows
						 columns:(NSInteger)columns
						 xOffset:(NSInteger)xOffset
						 yOffset:(NSInteger)yOffset;

@end

#pragma mark -

@implementation MysterioView

+ (NSArray*)createPixelsWithSize:(NSInteger)size color:(NSColor*)color rows:(NSInteger)rows columns:(NSInteger)columns xOffset:(NSInteger)xOffset yOffset:(NSInteger)yOffset
{
	NSMutableArray *rowArray = [NSMutableArray arrayWithCapacity:rows];
	for (int x = 0; x < rows; x++) {
		NSMutableArray *colArray = [NSMutableArray arrayWithCapacity:columns];

		for (int y = 0; y < columns; y++) {
			NSRect rect = NSMakeRect(xOffset + x * size,
									 yOffset + y * size,
									 size, size);
			MysterioPixel *pixel = [MysterioPixel pixelWithRect:rect
													 borderSize:size * PIXEL_BORDER
												   cornerRadius:size * PIXEL_CORNER_RADIUS
														  color:color];
			[colArray addObject:pixel];
		}
		[rowArray addObject:[NSArray arrayWithArray:colArray]];
	}

	return [NSArray arrayWithArray:rowArray];
}

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

		self.bluePixels = [MysterioView createPixelsWithSize:pixelSize
													   color:[[NSColor blueColor] colorWithAlphaComponent:0.0]
														rows:rows
													 columns:cols
													 xOffset:xOffset
													 yOffset:yOffset];
		self.whitePixels = [MysterioView createPixelsWithSize:pixelSize
														color:[[NSColor whiteColor] colorWithAlphaComponent:0.0]
														rows:rows
													 columns:cols
													 xOffset:xOffset
													 yOffset:yOffset];
	}

    return self;
}

- (void)drawRect:(NSRect)rect
{
	[super drawRect:rect];

	[[NSGraphicsContext currentContext] setCompositingOperation:NSCompositeCopy];
	for (NSArray *column in self.bluePixels) {
		for (MysterioPixel *pixel in column) {
			[pixel.color set];
			[pixel fill];
		}
	}

	[[NSGraphicsContext currentContext] setCompositingOperation:NSCompositeOverlay];
	for (NSArray *column in self.whitePixels) {
		for (MysterioPixel *pixel in column) {
			[pixel.color set];
			[pixel fill];
		}
	}
}

- (void)animateOneFrame
{
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
					alpha -= 0.1;
					break;

				case 2:
					alpha += 0.1;
					break;
			}

			pixel.color = [pixel.color colorWithAlphaComponent:alpha];
		}
	}

	[self setNeedsDisplay:YES];

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
