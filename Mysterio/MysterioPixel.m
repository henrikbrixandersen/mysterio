//
//  MysterioPixel.m
//  Mysterio
//
//  Created by Henrik Brix Andersen on 12/01/15.
//  Copyright (c) 2015 Henrik Brix Andersen. All rights reserved.
//

#import "MysterioPixel.h"

#pragma mark - Private Interface

@interface MysterioPixel()

@property (strong, nonatomic) NSBezierPath *path;

@end

#pragma mark - Implementation

@implementation MysterioPixel

+ (instancetype)pixelWithRect:(NSRect)rect borderSize:(CGFloat)borderSize cornerRadius:(CGFloat)cornerRadius color:(NSColor*)color
{
	MysterioPixel *pixel = [[self alloc] init];

	if (pixel) {
		NSRect pixelRect;
		pixelRect.size.width = rect.size.width - 2 * borderSize;
		pixelRect.size.height = rect.size.height - 2 * borderSize;
		pixelRect.origin.x = rect.origin.x + borderSize;
		pixelRect.origin.y = rect.origin.y + borderSize;

		pixel.path = [NSBezierPath bezierPathWithRoundedRect:pixelRect
													 xRadius:cornerRadius
													 yRadius:cornerRadius];
		pixel.color = color;
	}

	return pixel;
}

- (void)fill
{
	[self.path fill];
}

@end
