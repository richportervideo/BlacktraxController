//
//  calibration.h
//  BlacktraxController
//
//  Created by Rich Porter on 10/11/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface calibration : NSObject

@property NSString* theIPAddress;
@property int theSendPort;
@property int theRecievePort;
@property NSString *theMessage;
@property int timesChanged;

@end
