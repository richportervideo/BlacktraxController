//
//  ChooseProjectorViewController.m
//  BlacktraxController
//
//  Created by Rich Porter on 03/12/2014.
//  Copyright (c) 2014 RichPorter. All rights reserved.
//

#import "ChooseProjectorViewController.h"
#import "DetailViewController.h"
#import "StartupViewController.h"

@interface ChooseProjectorViewController ()

@property (strong, nonatomic) F53OSCClient* oscClient;
@property (strong, nonatomic) F53OSCServer* oscServer;

@end

@implementation ChooseProjectorViewController


@synthesize ProjectortableView;
@synthesize theCal;
// @synthesize selectedPJIndicies;
// @synthesize selectedPJNames;

NSMutableArray *projectors;



- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"");
    NSLog(@"--------------------------");
    NSLog(@"CHOOSE PROJECTOR VIEW CONTROLLER");
    NSLog(@"--------------------------");
    NSLog(@"");
    
    NSLog(@"Memory Address for Current Calibration Object %p", theCal);
    
    _selectedPJIndicies = [[NSMutableArray alloc]init];
    _selectedPJNames = [[NSMutableArray alloc]init];
    
    //Setting up OSC
    self.oscClient = [[F53OSCClient alloc] init];
    self.oscServer = [[F53OSCServer alloc] init];
    [self.oscServer setPort:theCal.theRecievePort];
    [self.oscServer setDelegate:self];
    [self.oscServer startListening];
    
    F53OSCMessage *message = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/gettotalprojectors" arguments:@[@1.f]];
    [self.oscClient sendPacket:message toHost:theCal.theIPAddress onPort:theCal.theSendPort];
    F53OSCMessage *message1 = [F53OSCMessage messageWithAddressPattern:@"/d3/bt/gettotalprojectors" arguments:@[@0.f]];
    [self.oscClient sendPacket:message1 toHost:theCal.theIPAddress onPort:theCal.theSendPort];
    
    NSLog(@"Passed Projector Objects: %lu", (unsigned long)[theCal.projectorObjects count]);
    projectors = [NSMutableArray arrayWithObjects:@"Foo 1", @"Foo 2", @"Foo 3", @"Foo 4" ,nil];
}

-(void)takeMessage:(F53OSCMessage *)message {

if ([message.addressPattern  isEqual: @"/d3/bt/sendtotalprojectors"]){
    NSArray *arguments = message.arguments;
    NSString *incomingMessage = [arguments objectAtIndex:0];
    theCal.totalProjectors = [incomingMessage componentsSeparatedByString:@"%%@@"];
    
}

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [theCal.totalProjectors count];
    
    //Uncomment to use local test values
    //return [projectors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ProjectorCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    
    //NSLog(@"call.textLabel.text: %@", [[theCal.projectorObjects objectAtIndex:indexPath.row] name]);
    
    //Get projector object and ask for name
    cell.textLabel.text = [[theCal.projectorObjects objectAtIndex:indexPath.row] name];
    
    //Uncomment to use local values
    //cell.textLabel.text = [projectors objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
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
    
    
    // Segue to detail view
    if ([segue.identifier isEqualToString:@"ProjectorView2Detail"]) {
        NSIndexPath *indexPath = [self.ProjectortableView indexPathForSelectedRow];
        DetailViewController *destViewController = segue.destinationViewController;
        destViewController.ProjectorName = [[theCal.projectorObjects objectAtIndex:indexPath.row] name];
        destViewController.theSelectedProjector = [theCal.projectorObjects objectAtIndex:indexPath.row];
        destViewController.theCal = theCal;
    
    }
    // Segue back to  Startup Screen Passing Selected Projectors
    else if ([segue.identifier isEqualToString:@"ChooseProjector2Startup"]) {
        
        //Clear SelectedPJNames
        [_selectedPJNames removeAllObjects];
        
        //Get Target View Controller
        StartupViewController *controller = (StartupViewController *)segue.destinationViewController;
        // Array of selected projectors as indexPaths
        NSArray *selected = [self.ProjectortableView indexPathsForSelectedRows];
        
        //For every object in the selected array convert to _SelectedPJNames
        for (int i = 0; i < [selected count]; i++){
            NSIndexPath * p = [selected objectAtIndex:i];
            [_selectedPJNames addObject:[theCal.totalProjectors objectAtIndex:p.row]];
            
            //Logging to confirm which projectors added to _selectedPJNames
            //NSLog(@"Projector Just Added to SelectedPJNames: %@", [projectors objectAtIndex:p.row]);
        }
        //Logging to print selectedPJNames Count
        NSLog(@"SelectedPJNames count, %lu", (unsigned long)[_selectedPJNames count]);
        
        //Pass selected projectors to calibration object
        theCal.selectedProjectors = [NSArray arrayWithArray:_selectedPJNames];
        
        //Confirm selectedProjectors Count is the same once passed to the calibration object
        NSLog(@"TheCal.selectedProjectors count, %lu", (unsigned long)[theCal.selectedProjectors count]);
        
        if ([theCal.selectedProjectors count] > 0){
            theCal.selectionSet = YES;
        } else {
            theCal.selectionSet = NO;
        }
        //Pass calibration object to the setupViewController
        controller.theCal = theCal;
    }
}

//Test method used for constructing method passing selected projectors back to the calibration object. No longer required (but useful).

- (IBAction)SetSelection:(id)sender {
    
    NSArray *selected = [self.ProjectortableView indexPathsForSelectedRows];
    //NSLog(@"Printing Selected Items: %@", selected);
    NSLog(@"Number of selected objects %lu", [selected count]);
    
    for (int i = 0; i < [selected count]; i++) {
        NSIndexPath * p = [selected objectAtIndex:i];
        //NSLog(@"Selected Projector (0Base): %ld", (long)p.row);
        [_selectedPJIndicies addObject:[NSNumber numberWithLong:p.row]];
    }
    
    // This loop logs each item inside _selectedPJIndicies NSMutableArray
    NSLog(@"selectedPJIndicies count: %lu", (unsigned long)[_selectedPJIndicies count]);
    for (int j = 0; j < [_selectedPJIndicies count]; j++){
        //NSLog(@"Inside the second loop");
        NSLog(@"SelectedPJIndices log object: %@", [_selectedPJIndicies objectAtIndex:j]);
    }
    NSLog(@"Finished the Set Selection Method");
}

- (IBAction)getProjectorsFromd3:(id)sender {
    
}
@end
