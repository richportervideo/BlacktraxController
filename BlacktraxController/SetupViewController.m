//
//  SetupViewController.m
//  BlacktraxController
//
//  Created by Rich Porter on 24/11/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import "SetupViewController.h"
#import "ViewController.h"

@interface SetupViewController ()


@end

@implementation SetupViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    [_ipOutlet setText:_setupIPAddress];
    [_sendPortOutlet setText: [@(_setupSendPort) stringValue] ];
    [_recievePortOutlet setText:[@(_setupRecievePort) stringValue]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_ipOutlet resignFirstResponder];
    [_sendPortOutlet resignFirstResponder];
    [_recievePortOutlet resignFirstResponder];
}


- (IBAction)setDefaultValues:(id)sender {

    [_ipOutlet setText:@"10.0.30.211"];
    [_sendPortOutlet setText:@"9000"];
    [_recievePortOutlet setText:@"9001"];
}

#pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 if([segue.identifier isEqualToString:@"IPToMain"]){
     
     SetupViewController *controller = (SetupViewController *)segue.destinationViewController;
     
     controller.theIPAddress = _ipOutlet.text;
     controller.theSendPort = [_sendPortOutlet.text intValue];
     controller.theRecievePort = [_recievePortOutlet.text intValue];
     
 
    }
 }


@end
