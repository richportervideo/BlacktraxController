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

@end

@implementation StartupViewController


@synthesize theCal;

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"Startup2Setup"]){
        SetupViewController *controller = (SetupViewController *)segue.destinationViewController;
        controller.theCal = theCal;
    } else if ([segue.identifier isEqualToString:@"Startup2ChooseProjector"]){
        ChooseProjectorViewController * controller = (ChooseProjectorViewController *) segue.destinationViewController;
        controller.theCal = theCal;
    } else if ([segue.identifier isEqualToString:@"Startup2Calibrate"]){
        ViewController * controller = (ViewController *) segue.destinationViewController;
        controller.theCal = theCal;
    }
}

@end
