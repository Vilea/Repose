//
//  VIBubbleCell.h
//  Repose
//
//  Created by Junior Bontognali on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    VIBubbleLeft,
    VIBubbleRight
} VIBubblePosition;

@interface VIBubbleCell : UITableViewCell
@property (nonatomic, strong) NSString *message;

+ (CGFloat)heightForRowWithMessage:(NSString *)message;
- (void)setBubbleColor:(UIColor *)color position:(VIBubblePosition)position;

@end
