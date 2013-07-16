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
    
    return self;
}


- (void)newItemAdded {
    Message *aMessage = [Message MR_findFirstOrderedByAttribute:@"creationDate" ascending:YES];
    NSLog(@"oldest of %d entities:%@",[Message MR_countOfEntities],aMessage);
    [[DataUploadingClient sharedClient] sendMessage:aMessage.messageStr withSuccessBlock:nil andFailureBlock:nil];
}

- (void)sendMessage:(NSString *)messageString withSuccessBlock:(void (^)(NSDictionary *))successBlock andFailureBlock:(void (^)(NSString *))failureBlock {
    
    NSString *basePath = @"m.php";
    NSDictionary *par = @{@"type" : @"c"};
    NSString *parameters = [NSString stringWithFormat:@"?%@=%@",messageString,[par JSONString]];
    NSString *fullPath = [NSString stringWithFormat:@"%@%@",basePath,parameters];
    fullPath = [fullPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[DataUploadingClient sharedClient] getPath:fullPath parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSDictionary *jsonDic = [JSON objectFromJSONData];
        NSLog(@"%@",jsonDic);
        
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
        NSString *errorDescription = [NSString stringWithFormat:@"user auth fail with %@",error.localizedDescription];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:errorDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        if(failureBlock) failureBlock(error.localizedDescription);
    }];
}

@end
