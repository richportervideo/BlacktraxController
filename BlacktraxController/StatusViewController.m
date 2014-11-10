//
//  StatusViewController.m
//  BlacktraxController
//
//  Created by Rich Porter on 10/11/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import "StatusViewController.h"
#import "calibration.h"
#import "SetIPViewController.h"

@interface StatusViewController ()


@end

@implementation StatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    
    if (!_theCalibrationObject)
    {
        _theCalibrationObject = [[calibration alloc]init];
    }
    
    _theCalibrationObject.timesChanged ++;
    NSLog(@"Times Changed = %i", _theCalibrationObject.timesChanged);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Pass the Calibration object when the view is changed

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"StatusToIP"]){
        SetIPViewController *controller = (SetIPViewController *)segue.destinationViewController;
        controller.theCalibrationObject = _theCalibrationObject;
        
        
        
    }
}

@end
