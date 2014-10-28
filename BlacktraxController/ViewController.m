//
//  ViewController.m
//  BlacktraxController
//
//  Created by Rich Porter on 27/10/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import "ViewController.h"

#define SENDHOST @"127.0.0.1"
#define SENDPORT 3000
#define RECEIVEPORT 3001

@interface ViewController ()

@property (strong, nonatomic) F53OSCClient* oscClient;
@property (strong, nonatomic) F53OSCServer* oscServer;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *argumentsLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.oscClient = [[F53OSCClient alloc] init];
    self.oscServer = [[F53OSCServer alloc] init];
    [self.oscServer setPort:RECEIVEPORT];
    [self.oscServer setDelegate:self];
    [self.oscServer startListening];
}

-(void)takeMessage:(F53OSCMessage *)message {
    
    //Setting the Address Label
    [self.addressLabel setText:message.addressPattern];
    //Requesting Argument as an Array
    NSArray *arguments = message.arguments;
    //Converting to NSNumber
    NSNumber *arg = [[NSNumber alloc]init];
    arg = [NSNumber numberWithFloat:([[arguments objectAtIndex:0]floatValue ])];
    //Setting Argument label
    [self.argumentsLabel setText:[arg stringValue]];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end