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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClick:(id)sender {
    Message *newMessage = [Message MR_createEntity];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterNoStyle];
    [df setTimeStyle:NSDateFormatterMediumStyle];
    [newMessage setMessageStr:[NSString stringWithFormat:@"test message created on %@",[df stringFromDate:[NSDate date]]]];
    [newMessage setCreationDate:[NSDate date]];
    [[DataUploadingClient sharedClient] newItemAdded];
}

@end
