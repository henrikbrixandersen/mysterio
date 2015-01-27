//
//  MysterioLayer.m
//  Mysterio
//
//  Created by Henrik Brix Andersen on 19/01/15.
//  Copyright (c) 2015 Henrik Brix Andersen. All rights reserved.
//

#import "MysterioPixel.h"
#import "MysterioLayer.h"

#pragma mark - Private interface

@interface MysterioLayer()

@property (strong, nonatomic, readwrite) NSArray *pixels;
@property (nonatomic, readwrite) NSInteger rows;
@property (nonatomic, readwrite) NSInteger columns;

@end

#pragma mark - Implementation

@implementation MysterioLayer

+ (instancetype)layerWithPixelSize:(NSInteger)size
							 color:(NSColor*)color
							  rows:(NSInteger)rows
						   columns:(NSInteger)columns
						   xOffset:(NSInteger)xOffset
						   yOffset:(NSInteger)yOffset
						borderSize:(CGFloat)borderSize
					  cornerRadius:(CGFloat)cornerRadius
{
	MysterioLayer *layer = [[self alloc] init];

	if (layer) {
		NSMutableArray *rowArray = [NSMutableArray arrayWithCapacity:rows];
		for (int x = 0; x < rows; x++) {
			NSMutableArray *colArray = [NSMutableArray arrayWithCapacity:columns];

			for (int y = 0; y < columns; y++) {
				NSRect rect = NSMakeRect(xOffset + x * size,
										 yOffset + y * size,
										 size, size);
				MysterioPixel *pixel = [MysterioPixel pixelWithRect:rect
														 borderSize:borderSize
													   cornerRadius:cornerRadius
															  color:color];
				[colArray addObject:pixel];
			}
			[rowArray addObject:[NSArray arrayWithArray:colArray]];
		}

		layer.pixels = [NSArray arrayWithArray:rowArray];
		layer.rows = rows;
		layer.columns = columns;
	}

	return layer;
}

- (void)animateLayerOneFrame
{
	if (self.delegate) {
		[self.delegate animateLayerOneFrame:self];
	} else {
		for (NSArray *column in self.pixels) {
			for (MysterioPixel *pixel in column) {
				[pixel.color set];
				[pixel fill];
			}
		}
	}
}

@end
