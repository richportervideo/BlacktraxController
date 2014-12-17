//
//  DetailViewController.m
//  BlacktraxController
//
//  Created by Rich Porter on 03/12/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation DetailViewController

@synthesize theCal;

NSMutableArray *colours;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"");
    NSLog(@"--------------------------");
    NSLog(@"DETAIL VIEW CONTROLLER");
    NSLog(@"--------------------------");
    NSLog(@"");
    
    NSLog(@"Memory Address for Current Calibration Object %p", theCal);
    NSLog(@"Projector Object %@", _theSelectedProjector.name);
    
    _ProjectorNameOutlet.text = _ProjectorName;
    colours = [NSMutableArray arrayWithObjects:@"Red",@"Green",@"Blue",@"Cyan",@"Magenta",@"Yellow", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [colours count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"colourCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [colours objectAtIndex:indexPath.row];
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Detail2Projector"]) {
        
        //Get destination viewcontroller
        ChooseProjectorViewController *controller = segue.destinationViewController;
        //Get index of selected colour
        NSIndexPath *selectedColourIndex = [_colourTableView indexPathForSelectedRow];
        //Get selected colour as string
        NSString *selectedColourString = [colours objectAtIndex: selectedColourIndex.row];
        //Print Selected Colour
        NSLog(@"Selected Colour: %@", selectedColourString);
        
        
        //Pass the calibration object to the destination viewcontroller
        controller.theCal = theCal;
    }
}


@end
