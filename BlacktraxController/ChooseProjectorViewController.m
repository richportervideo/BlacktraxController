//
//  ChooseProjectorViewController.m
//  BlacktraxController
//
//  Created by Rich Porter on 03/12/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import "ChooseProjectorViewController.h"
#import "DetailViewController.h"

@interface ChooseProjectorViewController ()

@end

@implementation ChooseProjectorViewController

@synthesize tableView;

NSMutableArray *projectors;


- (void)viewDidLoad {
    [super viewDidLoad];
    projectors = [NSMutableArray arrayWithObjects:@"Projector 1", @"Projector 2", @"Projector 3", @"Projector 4", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [projectors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ProjectorCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [projectors objectAtIndex:indexPath.row];
    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ProjectorView2Detail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *destViewController = segue.destinationViewController;
        destViewController.ProjectorName = [projectors objectAtIndex:indexPath.row];
    }
}

- (IBAction)SetSelection:(id)sender {
    
    NSArray *selected = [self.tableView indexPathsForSelectedRows];
    NSLog(@"Printing Selected Items: %@", selected);
    NSLog(@"Number of selected objects %lu", [selected count]);
    
    for (int i = 0; i < [selected count]; i++) {
        NSIndexPath * p = [selected objectAtIndex:i];
        NSLog(@"Selected Projector (0Base): %ld", (long)p.row);
        
    }
    
}
@end
