//
//  ChooseProjectorViewController.h
//  BlacktraxController
//
//  Created by Rich Porter on 03/12/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import "ViewController.h"
#import "calibration.h"
#import "F53OSC.h"
#import "StartupViewController.h"

@interface ChooseProjectorViewController : ViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *ProjectortableView;
@property calibration *theCal;
@property NSMutableArray *selectedPJIndicies;
@property (strong, nonatomic) NSMutableArray *selectedPJNames;



- (IBAction)SetSelection:(id)sender;
- (IBAction)getProjectorsFromd3:(id)sender;

@end
