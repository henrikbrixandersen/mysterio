//
//  MysterioPixel.h
//  Mysterio
//
//  Created by Henrik Brix Andersen on 12/01/15.
//  Copyright (c) 2015 Henrik Brix Andersen. All rights reserved.
//

@import AppKit;

@interface MysterioPixel : NSObject

@property (strong, nonatomic) NSColor *color;

+ (instancetype)pixelWithRect:(NSRect)rect borderSize:(CGFloat)borderSize cornerRadius:(CGFloat)cornerRadius color:(NSColor*)color;

- (void)fill;

@end
