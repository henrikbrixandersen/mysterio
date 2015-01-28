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

#import "MysterioPixel.h"
#import "MysterioLayer.h"

#pragma mark - Private Interface

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
