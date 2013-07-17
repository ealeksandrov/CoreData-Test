//
//  DataUploadingClient.h
//  TestTask
//
//  Created by Evgeny Aleksandrov on 17.07.13.
//  Copyright (c) 2013 SomeCompany. All rights reserved.
//

#import "AFHTTPClient.h"

@interface DataUploadingClient : AFHTTPClient

+ (DataUploadingClient *)sharedClient;

- (void)newItemAdded;
- (void)sendOldestStoredMessage;

@end
