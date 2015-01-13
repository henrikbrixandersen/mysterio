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

@property (strong, nonatomic) NSArray *bluePixels;
@property (strong, nonatomic) NSArray *whitePixels;

+ (NSArray*)createPixelsWithSize:(NSInteger)size color:(NSColor*)color rows:(NSInteger)rows columns:(NSInteger)columns xOffset:(NSInteger)xOffset yOffset:(NSInteger)yOffset;

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

		self.bluePixels = [MysterioView createPixelsWithSize:pixelSize
													   color:[[NSColor blueColor] colorWithAlphaComponent:0.75]
														rows:rows
													 columns:cols
													 xOffset:xOffset
													 yOffset:yOffset];
		self.whitePixels = [MysterioView createPixelsWithSize:pixelSize
													   color:[[NSColor whiteColor] colorWithAlphaComponent:0.75]
														rows:rows
													 columns:cols
													 xOffset:xOffset
													 yOffset:yOffset];
	}

    return self;
}

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

	[black set];
	[NSBezierPath fillRect:self.bounds];

	for (NSArray *column in self.bluePixels) {
		for (MysterioPixel *pixel in column) {
			if (SSRandomIntBetween(0, 1) == 1) {
				[pixel.color set];
				[pixel fill];
			}
		}
	}

	for (NSArray *column in self.whitePixels) {
		for (MysterioPixel *pixel in column) {
			if (SSRandomIntBetween(0, 1) == 1) {
				[pixel.color set];
				[pixel fill];
			}
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
