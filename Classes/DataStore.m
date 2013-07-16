//
//  DataStore.m
//  TestTask
//
//  Created by Evgeny Aleksandrov on 17.07.13.
//  Copyright (c) 2013 SomeCompany. All rights reserved.
//

#import "DataStore.h"
#import "Message.h"

@implementation DataStore

+ (DataStore *)sharedStore {
    static DataStore *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[DataStore alloc] init];
    });
    
    return _sharedClient;
}

- (id)init {
    self = [super init];
    if (self) {
        //nice place to override init
    }
    return self;
}

- (void)newItemAdded {
    Message *aMessage = [Message MR_findFirstOrderedByAttribute:@"creationDate" ascending:YES];
    NSLog(@"oldest of %d entities:%@",[Message MR_countOfEntities],aMessage);
}

@end
