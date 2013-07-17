//
//  TTObjectB.m
//  TestTask
//
//  Created by Evgeny Aleksandrov on 17.07.13.
//  Copyright (c) 2013 SomeCompany. All rights reserved.
//

#import "TTObjectB.h"
#import "TTObjectFactory.h"

@implementation TTObjectB

+ (void)load {
    [[TTObjectFactory sharedFactory] registerClass:[self class] withKey:@"b"];
}

- (void)onRecieve {
    DLog(@"OnRecieve B");
    [self changeBgColorTo:[UIColor blueColor]];
}

@end
