//
//  VIMasterViewController.h
//  Repose
//
//  Created by Junior Bontognali on 7/24/12.
//  Copyright (c) 2012 Vilea GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VIDetailViewController;

@interface VIMasterViewController : UITableViewController

@property (strong, nonatomic) VIDetailViewController *detailViewController;

@end
