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
        _thePort = 9000;
        _timesChanged = -1;
        NSLog(@"Memory Address for current calibration object %p", self);
    }
    
    
    return self;
}



@end
