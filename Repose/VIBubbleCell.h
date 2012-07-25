//
//  VIBubbleCell.h
//  Repose
//
//  Created by Junior Bontognali on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIBubbleCell : UITableViewCell
@property (nonatomic, strong) NSString *message;

+ (CGFloat)heightForRowWithMessage:(NSString *)message;
- (void)setBubbleColor:(NSInteger)colorIndex alignment:(NSInteger)alignment;

@end
