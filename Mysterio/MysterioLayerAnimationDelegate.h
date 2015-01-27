//
//  MysterioLayerDelegate.h
//  Mysterio
//
//  Created by Henrik Brix Andersen on 19/01/15.
//  Copyright (c) 2015 Henrik Brix Andersen. All rights reserved.
//

@import AppKit;

@class MysterioLayer;

@protocol MysterioLayerAnimationDelegate<NSObject>

- (void)animateLayerOneFrame:(MysterioLayer*)layer;

@end