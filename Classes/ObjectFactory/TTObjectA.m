//
//  TTObjectA.m
//  TestTask
//
//  Created by Evgeny Aleksandrov on 17.07.13.
//  Copyright (c) 2013 SomeCompany. All rights reserved.
//

#import "TTObjectA.h"
#import "TTObjectFactory.h"

@implementation TTObjectA

+ (void)load {
    [[TTObjectFactory sharedFactory] registerClass:[self class] withKey:@"a"];
}

- (void)onRecieve {
    DLog(@"OnRecieve A");
    [self changeBgColorTo:[UIColor redColor]];
}

@end
