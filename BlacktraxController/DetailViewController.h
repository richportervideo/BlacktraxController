//
//  DetailViewController.h
//  BlacktraxController
//
//  Created by Rich Porter on 03/12/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import "ViewController.h"
#import "ChooseProjectorViewController.h"
#import "calibration.h"
#import "Projector.h"



@interface DetailViewController : ViewController

//local calibration Object
@property calibration *theCal;
//Property to reference tableview
@property (nonatomic, strong) IBOutlet UITableView *colourTableView;
//Property to access Projector name at the top of the view
@property (weak, nonatomic) IBOutlet UILabel *ProjectorNameOutlet;
//Property to hold projector name
@property (nonatomic, strong) NSString *ProjectorName;
//Property to hold the current Projector Object
@property (nonatomic, strong) Projector *theSelectedProjector;

@end
