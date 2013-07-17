//
//  TTObjectFactory.h
//  TestTask
//
//  Created by Evgeny Aleksandrov on 17.07.13.
//  Copyright (c) 2013 SomeCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTParentObject.h"

@interface TTObjectFactory : NSObject

+ (TTObjectFactory *)sharedFactory;

- (TTParentObject *)createWithType:(NSString *)type;
- (void)registerClass:(Class)classToRegister withKey:(NSString*)key;

@end
