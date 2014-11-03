//
//  ViewController.m
//  BlacktraxController
//
//  Created by Rich Porter on 27/10/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import "ViewController.h"

#define SENDHOST @"10.0.30.242"
#define SENDPORT 9000
#define RECEIVEPORT 3002

@interface ViewController ()

@property (strong, nonatomic) F53OSCClient* oscClient;
@property (strong, nonatomic) F53OSCServer* oscServer;
@property (strong, nonatomic)  UIView* gestureView;
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

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    
    CGPoint
    location = [recognizer locationInView:self.theGestureView];
    
    //Ignore -numbers
    if (location.x <= 0) {
        location.x = 0;
    }
    if (location.y <= 0){
        location.y = 0;
    }
    //Ignore Numbers over the size of the view
    if (location.x >= 288){
        location.x = 288;
    }
    if (location.y >= 200){
        location.y = 200;
    }
    //Range map the result
    float NewlocationX = location.x/288.0;
    float NewlocationY = location.y/200;
    
    /* 
     
    Logging to check the values
     
    NSLog(@"X Value is %f", NewlocationX);
    NSLog(@"Y Value is %f", NewlocationY);
     
    */
    
    F53OSCMessage *messageX = [F53OSCMessage messageWithAddressPattern:@"/d3/showcontrol/x" arguments:@[[NSNumber numberWithFloat:NewlocationX]]];
    [self.oscClient sendPacket:messageX toHost:SENDHOST onPort:SENDPORT];
    
    F53OSCMessage *messageY = [F53OSCMessage messageWithAddressPattern:@"/d3/showcontrol/y" arguments:@[[NSNumber numberWithFloat:NewlocationY]]];
    [self.oscClient sendPacket:messageY toHost:SENDHOST onPort:SENDPORT];
    
}

- (IBAction)calibrateTouchDown:(id)sender {
    
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/calibrate" arguments:@[@1.f]];
    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];

}

- (IBAction)calibrateTouchUpInside:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/calibrate" arguments:@[@0.f]];
    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];
}

- (IBAction)clearTouchDown:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/clear" arguments:@[@1.f]];
    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];
    
}

- (IBAction)clearTouchUpInside:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/clear" arguments:@[@0.f]];
    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];
}

- (IBAction)downTouchDown:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/down" arguments:@[@1.f]];
    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];
}

- (IBAction)downTouchUpInside:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/down" arguments:@[@0.f]];
    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];
}

- (IBAction)rightTouchDown:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/right" arguments:@[@1.f]];
    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];
}

- (IBAction)rightTouchUpInside:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/right" arguments:@[@0.f]];
    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];
}

- (IBAction)leftTouchDown:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/left" arguments:@[@1.f]];
    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];
}

- (IBAction)leftTouchUpInside:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/left" arguments:@[@0.f]];
    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];
}

- (IBAction)upTouchDown:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/up" arguments:@[@1.f]];
    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];
}

- (IBAction)upTouchUpInside:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/up" arguments:@[@0.f]];
    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];
}

- (IBAction)pplusTouchDown:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/pplus" arguments:@[@1.f]];
    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];
}

- (IBAction)pplusTouchUpInside:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/pplus" arguments:@[@0.f]];
    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];
}

- (IBAction)pminusTouchDown:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/pminus" arguments:@[@1.f]];
    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];
}

- (IBAction)pminusTouchUpInside:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/pminus" arguments:@[@0]];
    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];
}

- (IBAction)testTouchDown:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/test" arguments:@[@1.f]];
    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];
}

- (IBAction)testTouchUpInside:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/test" arguments:@[@0.f]];
    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];
}

- (IBAction)doneTouchDown:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/done" arguments:@[@1.f]];
    [self.oscClient sendPacket:message toHost:SENDHOST onPort:SENDPORT];
}

- (IBAction)doneTouchUpInside:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/done" arguments:@[@0.f]];
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
