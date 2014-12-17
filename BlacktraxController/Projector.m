//
//  Projector.m
//  BlacktraxController
//
//  Created by Rich Porter on 07/12/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import "Projector.h"

@implementation Projector

- (id)init {
    self = [super init];
    
    if (self){
    
        _lockedState = NO;
        _backgroundColour = @"Red";
    }
    
    return self;
}

+(Projector*)initWithName:(NSString*)passedname{
  
    return [[Projector alloc]initWithName:passedname];
}

-(id) initWithName:(NSString*)passedname{

    self = [super init];

if (self){
    _name = passedname;
    _lockedState = NO;
    _backgroundColour = @"Red";
}

return self;
}



@end
