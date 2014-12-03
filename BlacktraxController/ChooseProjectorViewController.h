//
//  ChooseProjectorViewController.h
//  BlacktraxController
//
//  Created by Rich Porter on 03/12/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import "ViewController.h"

@interface ChooseProjectorViewController : ViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

- (IBAction)SetSelection:(id)sender;

@end
