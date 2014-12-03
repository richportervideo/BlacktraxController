//
//  SetupViewController.m
//  BlacktraxController
//
//  Created by Rich Porter on 24/11/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import "SetupViewController.h"
#import "ViewController.h"
#import "StartupViewController.h"
#include <ifaddrs.h>
#include <arpa/inet.h>

@interface SetupViewController ()


@end

@implementation SetupViewController

@synthesize theCal;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Memory Address for current calibration object %p", theCal);
    
    [_ipOutlet setText: theCal.theIPAddress];
    [_sendPortOutlet setText: [@(theCal.theSendPort) stringValue]];
    [_recievePortOutlet setText:[@(theCal.theRecievePort) stringValue]];
    
    //Return iphone IP Address to a label
    _yourIPAddress.text = [self getIPAddress];
    

    
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

    [_ipOutlet setText:@"10.0.0.100"];
    [_sendPortOutlet setText:@"9000"];
    [_recievePortOutlet setText:@"9001"];
}

#pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 if([segue.identifier isEqualToString:@"Setup2Startup"]){
     
     StartupViewController *controller = (StartupViewController *)segue.destinationViewController;
     theCal.theIPAddress = _ipOutlet.text;
     theCal.theSendPort = [_sendPortOutlet.text intValue];
     theCal.theRecievePort = [_recievePortOutlet.text intValue];
     controller.theCal = theCal;
    }
 }

- (NSString *)getIPAddress {
    
    NSString *address = @"ERROR: Are you on WIFI?";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}

@end
