//
//  SetIPViewController.m
//  BlacktraxController
//
//  Created by Rich Porter on 09/11/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import "SetIPViewController.h"
#import "StatusViewController.h"


@interface SetIPViewController ()

@end

@implementation SetIPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_ipBoxOne setText:@"192"];
    [_ipBoxTwo setText:@"168"];
    [_ipBoxThree setText:@"0"];
    [_ipBoxFour setText:@"10"];
    [_portTextBox setText:@"9000"];
    _theCalibrationObject.timesChanged ++;
    NSLog(@"Times Changed = %i", _theCalibrationObject.timesChanged);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}




//Resign First Responder when user taps away from keypad

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_ipBoxOne resignFirstResponder];
    [_ipBoxTwo resignFirstResponder];
    [_ipBoxThree resignFirstResponder];
    [_ipBoxFour resignFirstResponder];
    [_portTextBox resignFirstResponder];
    
}

#pragma mark - Navigation


// Pass the Calibration object when the view is changed

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"IPBackToStatus"]){
        StatusViewController *controller = (StatusViewController *)segue.destinationViewController;
        //NSLog(@"This is getting called inside Preapre For Segue");
        controller.theCalibrationObject = _theCalibrationObject;
        
        
    }
}

@end
