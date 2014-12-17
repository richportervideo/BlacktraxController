//
//  calibration.m
//  BlacktraxController
//
//  Created by Rich Porter on 10/11/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import "calibration.h"

@implementation calibration

- (id)init {
    self = [super init];
    
    if (self){
        _theIPAddress = @"192.168.0.1";
        _theSendPort = 9000;
        _theRecievePort = 9001;
        _timesChanged = -1;
        NSLog(@"Memory Address for current calibration object %p", self);
        _projectorObjects = [[NSMutableArray alloc]init];
        _selectionSet = NO;
    }
    
    
    return self;
}



@end
