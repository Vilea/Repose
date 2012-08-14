//
//  VIFoursquareOAuthController.m
//  Repose
//
//  Created by Junior Bontognali on 8/10/12.
//
//

#import "VIFoursquareOAuthController.h"
#import "Repose.h"
#import "TwitterUser.h"

#define kConsumerKey @"HJMXNADCHBMHZ1BEYDHMOPLDVBB0VDW2Y1OAKIQYT1400FET"
#define kConsumerSecret @"TG2KJHNRLXNOV5LDLDD0TOZBNZEYEO5T5S5UM4PRIDPGOS5M"
#define kCallbackURL @"http://bonto.ch/callback"

@interface VIFoursquareOAuthController () {
    NSMutableArray *_objects;
}

@property (strong, nonatomic) Repose *server;
@property (strong, nonatomic) NSString *token;

@property (strong, nonatomic) UIActivityIndicatorView *ai;

@end


@implementation VIFoursquareOAuthController

@synthesize server = _server;

- (id)init
{
    self = [super init];
    if (self) {
        self.title = NSStringFromClass([self class]);
        self.server = [[Repose alloc] initWithBaseURL:[NSURL URLWithString:@"https://foursquare.com"]];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
    
    self.token = [[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromClass([self class])];
    
    self.ai = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.ai.hidesWhenStopped = YES;
    
    [self.view addSubview:self.ai];
}

- (void)viewDidAppear:(BOOL)animated
{    
    [super viewDidAppear:animated];
    
    self.ai.center = self.view.center;
    
    if (!self.token) {
        [self.server authenticateUsingOAuthWithPath:@"/oauth2/authenticate"
                                         parameters:@{ @"client_id" : kConsumerKey, @"response_type" : @"token", @"redirect_uri" : kCallbackURL}
                                           callback:kCallbackURL
                                      withWebViewIn:self
                                           delegate:(id<AFOAuth2ClientDelegate>)self];
    } else {
        self.server = [[Repose alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.foursquare.com/v2"]];
        [self.server get:@"/v2/users/self/checkins"
              parameters:@{@"oauth_token":self.token}
               withBlock:^(ReposeResponseCode code, id responseObject)
        {
            NSLog(@"responseObject -> %@", responseObject);
            _objects = [[[responseObject objectForKey:@"response"] objectForKey:@"checkins"] objectForKey:@"items"];
            [self.ai stopAnimating];
            [self.tableView reloadData];
        }];
    }
    
    [self.ai startAnimating];
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
    static NSDateFormatter *df = nil;
    
    if (!df) {
        df = [[NSDateFormatter alloc] init];
        [df setTimeStyle:NSDateFormatterMediumStyle];
        [df setDateStyle:NSDateFormatterLongStyle];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *item = [_objects objectAtIndex:indexPath.row];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[item objectForKey:@"createdAt"] intValue]];
    
    cell.textLabel.text = [[item objectForKey:@"venue"] objectForKey:@"name"];
    cell.detailTextLabel.text = [df stringFromDate:date];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - AFOAuth2ClientDelegate

- (void)client:(AFOAuth2Client *)client receivedToken:(NSString *)token
{
    self.token = token;
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:NSStringFromClass([self class])];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.ai stopAnimating];
}


- (void)client:(AFOAuth2Client *)client failedToReceiveToken:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"Dismiss"
                                          otherButtonTitles: nil];
    [alert show];
    
    [self.ai stopAnimating];
}


@end