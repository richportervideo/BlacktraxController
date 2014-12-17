//
//  Projector.h
//  BlacktraxController
//
//  Created by Rich Porter on 07/12/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Projector : NSObject

// Class method for creating projectors with passed name
+(Projector*)initWithName:(NSString*)passedname;

-(id)initWithName:(NSString*)passedname;

@property NSString *name;
@property NSString *backgroundColour;
@property BOOL lockedState;

@end
