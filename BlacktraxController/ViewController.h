//
//  ViewController.h
//  BlacktraxController
//
//  Created by Rich Porter on 27/10/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F53OSC.h"


@interface ViewController : UIViewController <F53OSCClientDelegate>

-(void)takeMessage:(F53OSCMessage *)message;


//Gesture Recognition

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;

//Outlet for the view housing the gesture recogniser
@property (weak, nonatomic) IBOutlet UIView *theGestureView;

@property (weak, nonatomic) IBOutlet UIButton *onOffButton;

//Button declarations...

- (IBAction)calibrateTouchDown:(id)sender;
- (IBAction)calibrateTouchUpInside:(id)sender;

- (IBAction)clearTouchDown:(id)sender;
- (IBAction)clearTouchUpInside:(id)sender;

- (IBAction)downTouchDown:(id)sender;
- (IBAction)downTouchUpInside:(id)sender;

- (IBAction)rightTouchDown:(id)sender;
- (IBAction)rightTouchUpInside:(id)sender;

- (IBAction)leftTouchDown:(id)sender;
- (IBAction)leftTouchUpInside:(id)sender;

- (IBAction)upTouchDown:(id)sender;
- (IBAction)upTouchUpInside:(id)sender;

- (IBAction)nextTouchDown:(id)sender;
- (IBAction)nextTouchUpInside:(id)sender;

- (IBAction)prevTouchDown:(id)sender;
- (IBAction)prevTouchUpInside:(id)sender;

- (IBAction)onOffTouchDown:(id)sender;
- (IBAction)onOffTouchUpInside:(id)sender;

- (IBAction)rotLeftTouchDown:(id)sender;
- (IBAction)rotLeftTouchUpInside:(id)sender;

- (IBAction)rotRightTouchDown:(id)sender;
- (IBAction)rotRightTouchUpInside:(id)sender;

@end

