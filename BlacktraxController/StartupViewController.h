//
//  StartupViewController.h
//  BlacktraxController
//
//  Created by Rich Porter on 03/12/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import "ViewController.h"
#import "calibration.h"

@interface StartupViewController : ViewController

@property calibration* theCal; 

@property (weak, nonatomic) IBOutlet UILabel *SetupLabel;
@property (weak, nonatomic) IBOutlet UILabel *ChooseProjectorsLabel;

@end
