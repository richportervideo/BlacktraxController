//
//  StartupViewController.m
//  BlacktraxController
//
//  Created by Rich Porter on 03/12/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import "StartupViewController.h"
#import "calibration.h"
#import "ViewController.h"
#import "StartupViewController.h"
#import "SetupViewController.h"
#import "ChooseProjectorViewController.h"

@interface StartupViewController ()

@property (strong, nonatomic) F53OSCClient* oscClient;
@property (strong, nonatomic) F53OSCServer* oscServer;

@end

@implementation StartupViewController


@synthesize theCal;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"");
    NSLog(@"--------------------------");
    NSLog(@"STARTUP VIEW CONTROLLER");
    NSLog(@"--------------------------");
    NSLog(@"");
    
    if (!theCal){
        theCal = [[calibration alloc]init];
        NSLog(@"Calibration Object Created");
         _SetupLabel.text = @"Default IP And Port Config Selected";
        _ChooseProjectorsLabel.text = @"No Projectors Currently Selected";
        
    } else {
        NSLog(@"Memory Address for Current Calibration Object %p", theCal);
        NSLog(@"IP Currently Set to: %@", theCal.theIPAddress);
        NSLog(@"Send Port Currently Set to: %d", theCal.theSendPort);
        NSLog(@"RecievePort Currently Set to: %d", theCal.theRecievePort);
        //Logging Number of selected Projectors
        NSLog(@"Selected Projector Count %lu", (unsigned long)[theCal.selectedProjectors count]);
        //Logging Name of selected Projectors
        for (int i = 0; i < [theCal.selectedProjectors count]; i++){
            NSLog(@"Selected Projector: %@", [theCal.selectedProjectors objectAtIndex:i]);
        }
        
    }
    
    //Setting up OSC
    self.oscClient = [[F53OSCClient alloc] init];
    self.oscServer = [[F53OSCServer alloc] init];
    [self.oscServer setPort:theCal.theRecievePort];
    [self.oscServer setDelegate:self];
    [self.oscServer startListening];
    
    //check to see if there is a valid set of selected projectors.
    
    if ((theCal.selectedProjectors == nil) || ([theCal.selectedProjectors count] == 0) ){
        
        NSLog(@"\n");
        NSLog(@"--------------------------");
        NSLog(@"Currently no selected projectors");
        NSLog(@"--------------------------");
        NSLog(@"\n");

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)takeMessage:(F53OSCMessage *)message {
    
    
    NSArray *theIncomingArgument = message.arguments;
    NSLog(@"INCOMING ADDRESS: %@", message.addressPattern);
    NSLog(@"INCOMING MESSAGE: %@", [theIncomingArgument objectAtIndex:0]);
    
    
    if ([message.addressPattern  isEqual: @"/d3/bt/sendtotalprojectors"]){
        
        //Clear out the projectorObjects array so it's blank
        [theCal.projectorObjects removeAllObjects];
        
        //Create array to hold incoming arguments (as set out by F53OSC)
        NSArray *arguments = message.arguments;
        
        //Pull first argument from message
        NSString *incomingMessage = [arguments objectAtIndex:0];
        
        //Separate in incoming message into separate objects delimited by "%%@@"
        theCal.totalProjectors = [incomingMessage componentsSeparatedByString:@"%%@@"];
        
        //For each projector detected (in the above method) create a projection object passing the name as specified by d3
        for (int i =0; i < [theCal.totalProjectors count]; i++) {
            Projector *p = [[Projector alloc] initWithName:[theCal.totalProjectors objectAtIndex:i]];
            [theCal.projectorObjects addObject:p];
        }
        
    } else if ([message.addressPattern isEqual:@"/d3/bt/d3heartbeat"]){
        _heartBeatRecievedLabel.text = @"...looking for d3...";
    } else if ([message.addressPattern isEqual:@"/d3/bt/lockProjector"]){
        
        //Create array to hold incoming arguments (as set out by F53OSC)
        NSArray *arguments = message.arguments;
        
        //Pull first argument from message
        NSString *whichProjector = [arguments objectAtIndex:0];
        NSString *isItLocked = [arguments objectAtIndex:1];
        
        NSArray *lockProj = [whichProjector componentsSeparatedByString:@"%PROJ%"];
        NSArray *lockValue = [isItLocked componentsSeparatedByString:@"%LOCK%"];
    }
}

- (IBAction)GenerateSelectedProjectorData:(id)sender {
    
    NSLog(@"");
    NSLog(@"--------------------------");
    NSLog(@"Creating Dummy Total Projector Data...");
    NSLog(@"--------------------------");
    NSLog(@"");
    
    //Clear the projectorObjects Array
    [theCal.projectorObjects removeAllObjects];
    
    //Simulate String created by incoming message
    NSString *dummyTotalProjectorsString = @"Projector 1%%@@Projector 2%%@@Projector 3%%@@Proejctor 4";
    //Create Array of projector names
    theCal.totalProjectors = [dummyTotalProjectorsString componentsSeparatedByString:@"%%@@"];
    //For each projector detected (in the above method) create a projection object passing the name as specified by d3
    for (int i =0; i < [theCal.totalProjectors count]; i++) {
        Projector *p = [[Projector alloc] initWithName:[theCal.totalProjectors objectAtIndex:i]];
        [theCal.projectorObjects addObject:p];
        NSLog(@"Projector Object created for Projector: %@", [theCal.totalProjectors objectAtIndex:i] );
    }
    NSLog(@"thecal.projectorObjects count: %lu", (unsigned long)[theCal.totalProjectors count]);
    
    NSLog(@"");
    NSLog(@"--------------------------");
    NSLog(@"Creating Dummy Lock Data...");
    NSLog(@"--------------------------");
    NSLog(@"");
    
    NSString *dummyLockString = @"1%LOCK%0%LOCK%0%LOCK%1";
    NSArray *dummyLockArray = [dummyLockString componentsSeparatedByString:@"%LOCK%"];
    
    
    /*
    for (int p = 0; p < [dummyLockArray count]; p++) {
        if ([[dummyLockArray objectAtIndex:p]integerValue] == 1){
            [[[theCal.projectorObjects objectAtIndex:p] lockedState] setlockedState:YES];
        }
    }
    */
}

- (IBAction)CalibrateAction:(id)sender {
    if (theCal.selectionSet == YES) {
        NSLog(@"Trying to Segue");
        [self performSegueWithIdentifier:@"Startup2Calibrate" sender:self];
    } else {
        NSLog(@"Failing to Segue");
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:@"No Projectors Selected"
                                  delegate:self
                                  cancelButtonTitle:@"Return"
                                  otherButtonTitles: nil];
        
        [alertView show];
        
        //[self alertView];
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //Prepare to segue to IPSetup Page
    if([segue.identifier isEqualToString:@"Startup2Setup"]){
        SetupViewController *controller = (SetupViewController *)segue.destinationViewController;
        controller.theCal = theCal;
    } else if ([segue.identifier isEqualToString:@"Startup2ChooseProjector"]){
        ChooseProjectorViewController * controller = (ChooseProjectorViewController *) segue.destinationViewController;
        
        F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/getTotalProjectors" arguments:@[@1.f]];
        [self.oscClient sendPacket:message toHost:theCal.theIPAddress onPort:theCal.theSendPort];
        F53OSCMessage *message2 = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/getTotalProjectors" arguments:@[@1.f]];
        [self.oscClient sendPacket:message2 toHost:theCal.theIPAddress onPort:theCal.theSendPort];

        
        controller.theCal = theCal;
    } else if ([segue.identifier isEqualToString:@"Startup2Calibrate"]){
        
        //Create string from selected projectors array
        NSString *sendSelectedProjectors = [theCal.selectedProjectors componentsJoinedByString:@"%%@@"];
        //Log newly created string
        NSLog(@"SelectedProjectorString: %@", sendSelectedProjectors);
        //Send it to d3
        F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/selectedProjectors" arguments: @[sendSelectedProjectors]];
        [self sendloop:message];
        
        ViewController * controller = (ViewController *) segue.destinationViewController;
        controller.theCal = theCal;
    }
}

-(void)sendloop: (F53OSCMessage*)message{
   
    int i = 0;
    while (i < 10){
        [self.oscClient sendPacket:message toHost:theCal.theIPAddress onPort:theCal.theSendPort];
        NSLog(@"Message send to d3:%@", message);
        i ++;
    }
}
@end
