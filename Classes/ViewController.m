//
//  ViewController.m
//  TestTask
//
//  Created by Evgeny Aleksandrov on 17.07.13.
//  Copyright (c) 2013 SomeCompany. All rights reserved.
//

#import "ViewController.h"
#import "DataUploadingClient.h"
#import "Message.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)buttonClick:(id)sender {
    Message *newMessage = [Message MR_createEntity];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterNoStyle];
    [df setTimeStyle:NSDateFormatterMediumStyle];
    [newMessage setMessageStr:[NSString stringWithFormat:@"test message created on %@",[df stringFromDate:[NSDate date]]]];
    [newMessage setCreationDate:[NSDate date]];
    
    // Для реального проекта с множеством точек изменения БД можно было бы использовать NSNotification (Observer pattern).
    // Но в нашем случае событие возникает в одном месте, получить ссылку на обработчик легко.
    // Еще можно отслеживать NSFetchedResultsController - controllerDidChangeContent, но это опять усложнение для данного случая.
    [[DataUploadingClient sharedClient] newItemAdded];
}

@end
