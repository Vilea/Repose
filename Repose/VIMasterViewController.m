//
//  VIMasterViewController.m
//  Repose
//
//  Created by Junior Bontognali on 7/24/12.
//  Copyright (c) 2012 Vilea GmbH. All rights reserved.
//

#import "VIMasterViewController.h"
#import "Repose.h"
#import "VIBubbleCell.h"
#import "TwitterUser.h"

@interface VIMasterViewController () {
    NSMutableArray *_objects;
}

@property (strong, nonatomic) Repose *server;

@end

@implementation VIMasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize server = _server;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
        self.server = [[Repose alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com/1"]];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // https:/api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=bontoJR&count=2
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"false", @"include_entities", @"true", @"include_rts", @"bontoJR", @"screen_name", @"20", @"count", nil];
    [self.server get:@"statuses/user_timeline.json" parameters:params withBlock:^(ReposeResponseCode code, id responseObject){
        NSLog(@"responseObject -> %@", responseObject);
        _objects = responseObject;
        
        [self.tableView reloadData];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *object = [_objects objectAtIndex:indexPath.row];
    return [VIBubbleCell heightForRowWithMessage:[object objectForKey:@"text"]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    VIBubbleCell *cell = (VIBubbleCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[VIBubbleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }


    NSDictionary *object = [_objects objectAtIndex:indexPath.row];
    [cell setMessage:[object objectForKey:@"text"]];
    [cell setBubbleColor:0 alignment:(indexPath.row % 2)];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
