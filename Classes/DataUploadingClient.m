//
//  DataUploadingClient.m
//  TestTask
//
//  Created by Evgeny Aleksandrov on 17.07.13.
//  Copyright (c) 2013 SomeCompany. All rights reserved.
//

#import "DataUploadingClient.h"
#import "AFJSONRequestOperation.h"
#import "JSONKit.h"
#import "Message.h"

static NSString * const kAPIBaseURLString = @"http://spall.ru/";

@interface DataUploadingClient ()

- (void)sendMessage:(NSString *)messageString withSuccessBlock:(void (^)(NSDictionary *))successBlock andFailureBlock:(void (^)(NSString *))failureBlock;

@end

@implementation DataUploadingClient

+ (DataUploadingClient *)sharedClient
{
    static DataUploadingClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[DataUploadingClient alloc] initWithBaseURL:[NSURL URLWithString:kAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self)
    {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	//[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    [self setParameterEncoding:AFJSONParameterEncoding];
    
    __weak typeof(self) weakSelf = self;
    
    [weakSelf setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status) {
            DLog(@"Server is available now");
            if([Message MR_countOfEntities]) {
                [weakSelf sendOldestStoredMessage];
            }
        } else {
            DLog(@"Server is not available now");
        }
    }];
    
    return self;
}


- (void)newItemAdded {
    if(self.networkReachabilityStatus) {
        [self sendOldestStoredMessage];
    }
}

- (void)sendOldestStoredMessage {
    __weak typeof(self) weakSelf = self;
    __block Message *nextToSend = [Message MR_findFirstOrderedByAttribute:@"creationDate" ascending:YES];
    
    void (^uploadSuccessBlock) (NSDictionary *) = ^ (NSDictionary *responseDict) {
        //DO SMTH
        [nextToSend MR_deleteEntity];
        
        if([Message MR_countOfEntities]) {
            [weakSelf sendOldestStoredMessage];
        }
    };
    
    void (^uploadFailBlock) (NSString *) = ^ (NSString *errorDescription) {
        DLog(@"upload failed: %@",errorDescription);
        
        double delayInSeconds = 5.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        if(self.networkReachabilityStatus) {
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [weakSelf sendOldestStoredMessage];
            });
        }
    };
    
    [weakSelf sendMessage:nextToSend.messageStr withSuccessBlock:uploadSuccessBlock andFailureBlock:uploadFailBlock];
}

- (void)sendMessage:(NSString *)messageString withSuccessBlock:(void (^)(NSDictionary *))successBlock andFailureBlock:(void (^)(NSString *))failureBlock {
    
    NSString *basePath = @"m.php";
    NSDictionary *par = @{@"type" : @"c"};
    NSString *parameters = [NSString stringWithFormat:@"?%@=%@",messageString,[par JSONString]];
    NSString *fullPath = [NSString stringWithFormat:@"%@%@",basePath,parameters];
    fullPath = [fullPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[DataUploadingClient sharedClient] getPath:fullPath parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSDictionary *jsonDic = [JSON objectFromJSONData];
        
        if (!jsonDic) {
            NSString *errorString = @"Нет ответа от сервера!";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            if(failureBlock) failureBlock(errorString);
        } else {
            //DO SMTH
            if(successBlock) successBlock(jsonDic);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorDescription = [NSString stringWithFormat:@"Sending fail with %@",error.localizedDescription];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:errorDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        if(failureBlock) failureBlock(error.localizedDescription);
    }];
}

@end
