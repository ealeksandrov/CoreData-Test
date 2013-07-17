//
//  TTObjectFactory.m
//  TestTask
//
//  Created by Evgeny Aleksandrov on 17.07.13.
//  Copyright (c) 2013 SomeCompany. All rights reserved.
//

#import "TTObjectFactory.h"

@interface TTObjectFactory () {
    NSMutableDictionary* stringToClassMapping;
}

@end

@implementation TTObjectFactory

+ (TTObjectFactory *)sharedFactory
{
    static TTObjectFactory *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[TTObjectFactory alloc] init];
    });
    
    return _sharedClient;
}

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    stringToClassMapping = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    return self;
}

- (TTParentObject *)createWithType:(NSString *)type {
    return [[[stringToClassMapping objectForKey:type] alloc] init];
}

- (void)registerClass:(Class)classToRegister withKey:(NSString*)key {
    [stringToClassMapping setObject:classToRegister forKey:key];
}

@end
