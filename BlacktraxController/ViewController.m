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
#define RECEIVEPORT 3002

@interface ViewController ()

@property (strong, nonatomic) F53OSCClient* oscClient;
@property (strong, nonatomic) F53OSCServer* oscServer;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *argumentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

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


//This reciever method handles incoming OSC Messages

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
    NSLog(@"Incoming address: %@",  message.addressPattern);
    
    
    if ([message.addressPattern isEqualToString:@"/1/fader1"]) {
        [self.resultLabel setText:@"Fader"];
    } else if ([message.addressPattern isEqualToString:@"/1/push1"]){
        [self.resultLabel setText:@"Push"];
    } else {
        [self.resultLabel setText:@"Default"];
    }
    
}

- (IBAction)calibrateTouchDown:(id)sender {
    
    NSLog(@"touchdown");

}

- (IBAction)calibrateTouchUpInside:(id)sender {
    NSLog(@"touchupinside");
}




- (IBAction)Calibrate:(id)sender {

    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/showcontrol/" arguments:@[@5.82]];
    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];

}

/*
 
 This code is working and tested. First is send float on a slider, second is send value on a button
 
 - (IBAction)sendSliderMessage:(UISlider *)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/showcontrol/fader" arguments:@[[NSNumber numberWithFloat:sender.value]]];
    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];
    
}

- (IBAction)SendMessage:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/showcontrol/" arguments:@[@5.82]];
    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];
}

*/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
