//
//  TTParentObject.m
//  TestTask
//
//  Created by Evgeny Aleksandrov on 17.07.13.
//  Copyright (c) 2013 SomeCompany. All rights reserved.
//

#import "TTParentObject.h"

@interface TTParentObject () {
    UIView *viewToDraw;
}

@end

@implementation TTParentObject

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    //[[UIApplication sharedApplication] keyWindow];
    UIWindow *topWindow = [[[UIApplication sharedApplication].windows sortedArrayUsingComparator:^NSComparisonResult(UIWindow *win1, UIWindow *win2) {
        return win1.windowLevel - win2.windowLevel;
    }] lastObject];
    UIView *topView = [[topWindow subviews] lastObject];
    viewToDraw = topView;
    
    return self;
}

- (void)onRecieve {
    NSAssert(NO, @"The 'onRecieve' method must be implemented by subclass.");
}

- (void)changeBgColorTo:(UIColor *)color {
    [UIView animateWithDuration:0.3 animations:^{
        [viewToDraw setBackgroundColor:color];
    }];
}

@end
