//
//  SetupViewController.h
//  BlacktraxController
//
//  Created by Rich Porter on 24/11/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import "ViewController.h"


@interface SetupViewController : ViewController

@property NSString* setupIPAddress;
@property int setupSendPort;
@property int setupRecievePort;

//Set Default Values for textBoxes
- (IBAction)setDefaultValues:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *ipOutlet;
@property (weak, nonatomic) IBOutlet UITextField *sendPortOutlet;
@property (weak, nonatomic) IBOutlet UITextField *recievePortOutlet;


@end
