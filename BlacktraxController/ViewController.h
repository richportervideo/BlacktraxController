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


@end

