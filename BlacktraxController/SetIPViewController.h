//
//  SetIPViewController.h
//  BlacktraxController
//
//  Created by Rich Porter on 09/11/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "calibration.h"

@interface SetIPViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *ipBoxOne;
@property (weak, nonatomic) IBOutlet UITextField *ipBoxTwo;
@property (weak, nonatomic) IBOutlet UITextField *ipBoxThree;
@property (weak, nonatomic) IBOutlet UITextField *ipBoxFour;
@property (weak, nonatomic) IBOutlet UITextField *portTextBox;

@property calibration *theCalibrationObject;

@end
