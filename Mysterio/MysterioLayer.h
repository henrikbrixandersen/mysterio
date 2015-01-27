//
//  MysterioLayer.h
//  Mysterio
//
//  Created by Henrik Brix Andersen on 19/01/15.
//  Copyright (c) 2015 Henrik Brix Andersen. All rights reserved.
//

@import AppKit;

#include "MysterioLayerAnimationDelegate.h"

@interface MysterioLayer : NSObject

@property (strong, nonatomic) id<MysterioLayerAnimationDelegate> delegate;
@property (strong, nonatomic, readonly) NSArray *pixels;
@property (nonatomic, readonly) NSInteger rows;
@property (nonatomic, readonly) NSInteger columns;

+ (instancetype)layerWithPixelSize:(NSInteger)size
							 color:(NSColor*)color
							  rows:(NSInteger)rows
						   columns:(NSInteger)columns
						   xOffset:(NSInteger)xOffset
						   yOffset:(NSInteger)yOffset
						borderSize:(CGFloat)borderSize
					  cornerRadius:(CGFloat)cornerRadius;

- (void)animateLayerOneFrame;

@end
