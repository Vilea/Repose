//
//  VIGitHubOAuthController.m
//  Repose
//
//  Created by Junior Bontognali on 8/14/12.
//
//

#import "VIGitHubOAuthController.h"
#import "Repose.h"

#define kConsumerKey @"87b12da56ab1692695dc"
#define kConsumerSecret @"eeaca81b5a9549a7637f419b393c4b533e1ab2b1"
#define kCallbackURL @"http://bonto.ch/callback"

@interface VIGitHubOAuthController () {
    NSMutableArray *_objects;
}

@property (strong, nonatomic) Repose *client;
@property (strong, nonatomic) NSString *token;

@property (strong, nonatomic) UIActivityIndicatorView *ai;

- (void)_loadRepos;

@end

@implementation VIGitHubOAuthController

@synthesize client = _client;

- (id)init
{
    self = [super init];
    if (self) {
        self.title = NSStringFromClass([self class]);
        self.client = [[Repose alloc] initWithBaseURL:[NSURL URLWithString:@"https://github.com"]];
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
        [self.client authenticateUsingOAuthWithPath:@"/login/oauth/authorize"
                                         parameters:@{ @"client_id" : kConsumerKey, @"redirect_uri" : kCallbackURL}
                                           callback:kCallbackURL
                                      withWebViewIn:self
                                           delegate:(id<AFOAuth2ClientDelegate>)self];
    } else {
        if (![self.token isEqualToString:@""])
            [self _loadRepos];
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *item = [_objects objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [item objectForKey:@"name"];
    cell.detailTextLabel.text = [item objectForKey:@"description"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Actions

- (void)_loadRepos
{
    self.client = [[Repose alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.github.com"]];
    [self.client get:@"/user/repos"
          parameters:@{@"access_token":self.token}
           withBlock:^(ReposeResponseCode code, id responseObject)
     {
         NSLog(@"responseObject -> %@", responseObject);
         _objects = responseObject;
         [self.ai stopAnimating];
         [self.tableView reloadData];
     }];
}

#pragma mark - AFOAuth2ClientDelegate

- (void)client:(AFOAuth2Client *)client receivedToken:(NSString *)token
{
    self.token = @"";
    
    [self.client post:@"/login/oauth/access_token"
           parameters:@{@"client_id":kConsumerKey, @"client_secret":kConsumerSecret, @"code":token, @"state":@""}
            withBlock:^(ReposeResponseCode code, id responseObject)
     {
         NSLog(@"object -> %@", responseObject);
         
         [[NSUserDefaults standardUserDefaults] setObject:[responseObject objectForKey:@"access_token"] forKey:NSStringFromClass([self class])];
         [[NSUserDefaults standardUserDefaults] synchronize];
         
         [self _loadRepos];
     }];
    
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