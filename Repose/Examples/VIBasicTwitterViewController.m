//
//  VIMasterViewController.m
//  Repose
//
//  Created by Junior Bontognali on 7/24/12.
//  Copyright (c) 2012 Vilea GmbH. All rights reserved.
//

#import "VIBasicTwitterViewController.h"
#import "Repose.h"
#import "VIBubbleCell.h"
#import "TwitterUser.h"

@interface VIBasicTwitterViewController () {
    NSMutableArray *_objects;
}

@property (strong, nonatomic) Repose *client;

@property (strong, nonatomic) UIActivityIndicatorView *ai;

@end

@implementation VIBasicTwitterViewController

@synthesize client = _server;

- (id)init
{
    self = [super init];
    if (self) {
        self.title = NSStringFromClass([self class]);
        self.client = [[Repose alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com/1"]];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
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
    
    self.ai = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.ai.center = self.view.center;
    self.ai.hidesWhenStopped = YES;
    
    [self.view addSubview:self.ai];
    
    // https:/api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=bontoJR&count=2
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"false", @"include_entities", @"true", @"include_rts", @"VileaGmbH", @"screen_name", @"100", @"count", nil];
    [self.client get:@"statuses/user_timeline.json" parameters:params withBlock:^(ReposeResponseCode code, id responseObject){
        NSLog(@"responseObject -> %@", responseObject);
        _objects = responseObject;
        
        [self.ai stopAnimating];
        [self.tableView reloadData];
    }];
    
    [self.ai startAnimating];
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
    static UIColor *color1, *color2;
    
    if (!color1 || color2) {
        color1 = [UIColor colorWithHue:0.576 saturation:0.933 brightness:0.988 alpha:1.000];
        color2 = [UIColor colorWithHue:0.276 saturation:0.933 brightness:0.988 alpha:1.000];
    }
    
    VIBubbleCell *cell = (VIBubbleCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[VIBubbleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    NSDictionary *object = [_objects objectAtIndex:indexPath.row];
    
    [cell setMessage:[object objectForKey:@"text"]];
    [cell setBubbleColor:(indexPath.row%2)?color1:color2 position:(indexPath.row%2)];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
