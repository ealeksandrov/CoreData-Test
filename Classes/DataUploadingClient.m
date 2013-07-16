//
//  DataUploadingClient.m
//  TestTask
//
//  Created by Evgeny Aleksandrov on 17.07.13.
//  Copyright (c) 2013 SomeCompany. All rights reserved.
//

#import "DataUploadingClient.h"
#import "AFJSONRequestOperation.h"

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

- (void)sendMessage:(NSString *)messageString withSuccessBlock:(void (^)(NSDictionary *))successBlock andFailureBlock:(void (^)(NSString *))failureBlock {
    
    NSString *basePath = @"m.php";
    NSString *parameters = [NSString stringWithFormat:@"?%@={\"type\":\"c\"}",messageString];
    NSString *fullPath = [NSString stringWithFormat:@"%@%@",basePath,parameters];
    
    [[DataUploadingClient sharedClient] getPath:fullPath parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        /*NSDictionary *jsonDic = [JSON objectFromJSONData];
        
        if (!jsonDic)
        {
            NSString *errorString = @"Нет ответа от сервера!";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            if(failureBlock) failureBlock(errorString);
        } else {
            //DO SMTH
            if(successBlock) successBlock(jsonDic);
        }*/
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorDescription = [NSString stringWithFormat:@"user auth fail with %@",error.localizedDescription];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:errorDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        if(failureBlock) failureBlock(error.localizedDescription);
    }];
}

@end
