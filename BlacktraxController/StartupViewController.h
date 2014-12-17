//
//  StartupViewController.h
//  BlacktraxController
//
//  Created by Rich Porter on 03/12/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import "ViewController.h"
#import "calibration.h"
#import "F53OSC.h"
#include "Projector.h"

@interface StartupViewController : ViewController

- (IBAction)GenerateSelectedProjectorData:(id)sender;
- (IBAction)CalibrateAction:(id)sender;

@property calibration* theCal; 

@property (weak, nonatomic) IBOutlet UILabel *SetupLabel;
@property (weak, nonatomic) IBOutlet UILabel *ChooseProjectorsLabel;
@property (weak, nonatomic) IBOutlet UILabel *heartBeatRecievedLabel;

@end
