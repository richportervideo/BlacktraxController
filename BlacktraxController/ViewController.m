//
//  ViewController.m
//  BlacktraxController
//
//  Created by Rich Porter on 27/10/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import "ViewController.h"
#import "SetupViewController.h"

@interface ViewController ()

@property (strong, nonatomic) F53OSCClient* oscClient;
@property (strong, nonatomic) F53OSCServer* oscServer;
@property (strong, nonatomic)  UIView* gestureView;
@property  BOOL onOffState;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.oscClient = [[F53OSCClient alloc] init];
    self.oscServer = [[F53OSCServer alloc] init];
    [self.oscServer setPort:_theRecievePort];
    [self.oscServer setDelegate:self];
    [self.oscServer startListening];
    _onOffState = NO;
    [_onOffButton setTitle:@"Start" forState:(UIControlStateNormal)];
    NSThread * HeartbeatAsyncThread = [[NSThread alloc]initWithTarget:self selector:@selector(heartbeatMethod) object:nil];
    [HeartbeatAsyncThread start];
    /*
    NSLog(@"VIEWCONTROLLER_VIEWDIDLOAD: Current IP Address...%@", _theIPAddress);
    NSLog(@"VIEWCONTROLLER_VIEWDIDLOAD: Current Send Port Address...%i", _theSendPort);
    NSLog(@"VIEWCONTROLLER_VIEWDIDLOAD: Current Recieve Port...%i", _theRecievePort);
    */
}


-(void) heartbeatMethod{
    
    int i = 0;
    
    while (i == 0) {
    
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/heartbeat" arguments:@[@1.f]];
    [self.oscClient sendPacket:message toHost:_theIPAddress onPort:_theSendPort];
    F53OSCMessage *message2 = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/heartbeat" arguments:@[@0.f]];
    [self.oscClient sendPacket:message2 toHost:_theIPAddress onPort:_theSendPort];
    sleep(1);
        
    }
    
}

//This reciever method handles incoming OSC Messages

-(void)takeMessage:(F53OSCMessage *)message {
    
    
    NSArray *theIncomingArgument = message.arguments;
    NSLog(@"INCOMING ADDRESS: %@", message.addressPattern);
    NSLog(@"INCOMING MESSAGE: %@", [theIncomingArgument objectAtIndex:0]);
    

    
    if ([message.addressPattern  isEqual: @"/d3/bt/message/"]){
        NSArray *arguments = message.arguments;
        _selectedProjector.text = [arguments objectAtIndex:0];
    }
    
    
    /*
     
     This is old code for reading incoming address and argument. Keeping for reference
    
    // Setting the Address Label
    [self.addressLabel setText:message.addressPattern];
    //Requesting Argument as an Array
    NSArray *arguments = message.arguments;
    //Converting to NSNumber
    NSNumber *arg = [[NSNumber alloc]init];
    arg = [NSNumber numberWithFloat:([[arguments objectAtIndex:0]floatValue ])];
    
    //Setting Argument label
    [self.incomingDataLabel setText:[arg stringValue]];
    NSLog(@"Incoming address: %@",  message.addressPattern);
    
     */
     
}


/*
 
 This code is working and tested. First is send float on a slider, second is send value on a button
 
 - (IBAction)sendSliderMessage:(UISlider *)sender {
 F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/showcontrol/fader" arguments:@[[NSNumber numberWithFloat:sender.value]]];
 [self.oscClient sendPacket:message toHost:_theIPAddress onPort:_theSendPort];
 
 }
 
 - (IBAction)SendMessage:(id)sender {
 F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/showcontrol/" arguments:@[@5.82]];
 [self.oscClient sendPacket:message toHost:_theIPAddress onPort:_theSendPort];
 }
 
 */

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
    //Ignore Numbers > the size of the view
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
    
    F53OSCMessage *messageX = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/x" arguments:@[[NSNumber numberWithFloat:NewlocationX]]];
    [self.oscClient sendPacket:messageX toHost:_theIPAddress onPort:_theSendPort];
    
    F53OSCMessage *messageY = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/y" arguments:@[[NSNumber numberWithFloat:NewlocationY]]];
    [self.oscClient sendPacket:messageY toHost:_theIPAddress onPort:_theSendPort];
    
}

- (IBAction)calibrateTouchDown:(id)sender {
    
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/ok" arguments:@[@1.f]];
    [self.oscClient sendPacket:message toHost:_theIPAddress onPort:_theSendPort];

}

- (IBAction)calibrateTouchUpInside:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/ok" arguments:@[@0.f]];
    [self sendLoop:message];
}

- (IBAction)clearTouchDown:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/clear" arguments:@[@1.f]];
    [self.oscClient sendPacket:message toHost:_theIPAddress onPort:_theSendPort];
    
}

- (IBAction)clearTouchUpInside:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/clear" arguments:@[@0.f]];
   [self sendLoop:message];
}

- (IBAction)downTouchDown:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/down" arguments:@[@1.f]];
    [self.oscClient sendPacket:message toHost:_theIPAddress onPort:_theSendPort];
}

- (IBAction)downTouchUpInside:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/down" arguments:@[@0.f]];
    [self sendLoop:message];
}

- (IBAction)rightTouchDown:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/right" arguments:@[@1.f]];
    [self.oscClient sendPacket:message toHost:_theIPAddress onPort:_theSendPort];
}

- (IBAction)rightTouchUpInside:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/right" arguments:@[@0.f]];
    [self sendLoop:message];
}

- (IBAction)leftTouchDown:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/left" arguments:@[@1.f]];
    [self.oscClient sendPacket:message toHost:_theIPAddress onPort:_theSendPort];
}

- (IBAction)leftTouchUpInside:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/left" arguments:@[@0.f]];
    [self sendLoop:message];
}

- (IBAction)upTouchDown:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/up" arguments:@[@1.f]];
    [self.oscClient sendPacket:message toHost:_theIPAddress onPort:_theSendPort];
}

- (IBAction)upTouchUpInside:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/up" arguments:@[@0.f]];
    [self sendLoop:message];
}

- (IBAction)nextTouchDown:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/next" arguments:@[@1.f]];
    [self.oscClient sendPacket:message toHost:_theIPAddress onPort:_theSendPort];
}

- (IBAction)nextTouchUpInside:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/next" arguments:@[@0.f]];
    [self sendLoop:message];
}

- (IBAction)prevTouchDown:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/prev" arguments:@[@1.f]];
    [self.oscClient sendPacket:message toHost:_theIPAddress onPort:_theSendPort];

}

- (IBAction)prevTouchUpInside:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/prev" arguments:@[@0.f]];
    [self sendLoop:message];
}



- (IBAction)onOffTouchDown:(id)sender {
    if (!_onOffState) {
        F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/start" arguments:@[@1.f]];
        [self.oscClient sendPacket:message toHost:_theIPAddress onPort:_theSendPort];
        // NSLog(@"Start Message Just Sent");
    } else {
        F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/done" arguments:@[@1.f]];
        [self.oscClient sendPacket:message toHost:_theIPAddress onPort:_theSendPort];
        // NSLog(@"Done Message Just Sent");
    }
    
}

- (IBAction)onOffTouchUpInside:(id)sender {
    
    if (!_onOffState) {
        [_onOffButton setTitle:@"End" forState:(UIControlStateNormal)];
        _onOffState = YES;
        F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/start" arguments:@[@0.f]];
        [self sendLoop:message];
        // NSLog(@"Start Message Just Sent");
        // NSLog(@"onOffState = %@", _onOffState ? @"Yes" : @"No" );
    } else {
        [_onOffButton setTitle:@"Start" forState:(UIControlStateNormal)];
        _onOffState = NO;
        F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/done" arguments:@[@0.f]];
        [self sendLoop:message];
        // NSLog(@"Done Message Just Sent");
        // NSLog(@"onOffState = %@", _onOffState ? @"Yes" : @"No" );
        
    }
    
}

- (IBAction)rotLeftTouchDown:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/rotleft" arguments:@[@1.f]];
    [self.oscClient sendPacket:message toHost:_theIPAddress onPort:_theSendPort];
}

- (IBAction)rotLeftTouchUpInside:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/rotleft" arguments:@[@0.f]];
    [self sendLoop:message];
}

- (IBAction)rotRightTouchDown:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/rotright" arguments:@[@1.f]];
    [self.oscClient sendPacket:message toHost:_theIPAddress onPort:_theSendPort];
}

- (IBAction)rotRightTouchUpInside:(id)sender {
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/rotright" arguments:@[@0.f]];
    [self sendLoop:message];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if([segue.identifier isEqualToString:@"MainToIP"]){
         SetupViewController *controller = (SetupViewController *)segue.destinationViewController;
         controller.setupIPAddress = _theIPAddress;
         controller.setupSendPort = _theSendPort;
         controller.setupRecievePort = _theRecievePort;
     }

 }
-(void) sendLoop: (F53OSCMessage *) message {
    int i = 0;
    while (i < 10) {
        [self.oscClient sendPacket:message toHost:_theIPAddress onPort:_theSendPort];
        i ++;
    }
}



@end
