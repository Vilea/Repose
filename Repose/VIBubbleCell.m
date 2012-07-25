//
//  VIBubbleCell.m
//  Repose
//
//  Created by Junior Bontognali on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VIBubbleCell.h"

@interface VIBubbleCell ()

@property (strong, nonatomic) UIImageView *bubbleView;
@property (strong, nonatomic) UILabel *label;

@end

@implementation VIBubbleCell

@synthesize message = _message;
@synthesize bubbleView;
@synthesize label;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		bubbleView = [[UIImageView alloc] initWithFrame:CGRectZero];
		
		label = [[UILabel alloc] initWithFrame:CGRectZero];
		label.backgroundColor = [UIColor clearColor];
		label.tag = 2;
		label.numberOfLines = 0;
		label.lineBreakMode = UILineBreakModeWordWrap;
		label.font = [UIFont systemFontOfSize:14.0];
		
		UIView *message = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
		[message addSubview:bubbleView];
		[message addSubview:label];
		[self.contentView addSubview:message];

    }
    return self;
}

+ (CGFloat)heightForRowWithMessage:(NSString *)message
{
    CGSize size = [message sizeWithFont:[UIFont systemFontOfSize:14.0] 
                      constrainedToSize:CGSizeMake(240.0, 480.0) 
                          lineBreakMode:UILineBreakModeWordWrap];
	return size.height + 15;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMessage:(NSString *)message
{
    if (_message != message) {
        _message = message;
        
        label.text = _message;
    }
}

- (void)setBubbleColor:(NSInteger)colorIndex alignment:(NSInteger)alignment
{
    CGSize size = [_message sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(240.0f, 480.0f) lineBreakMode:UILineBreakModeWordWrap];
    
    UIImage *balloon;
    
    if(alignment == 0)
    {
        self.bubbleView.frame = CGRectMake(320.0f - (size.width + 28.0f), 2.0f, size.width + 28.0f, size.height + 15.0f);
        balloon = [[UIImage imageNamed:@"green.png"] stretchableImageWithLeftCapWidth:24 topCapHeight:15];
        label.frame = CGRectMake(307.0f - (size.width + 5.0f), 8.0f, size.width + 5.0f, size.height);
    }
    else
    {
        self.bubbleView.frame = CGRectMake(0.0, 2.0, size.width + 28, size.height + 15);
        balloon = [[UIImage imageNamed:@"grey.png"] stretchableImageWithLeftCapWidth:24 topCapHeight:15];
        label.frame = CGRectMake(16, 8, size.width + 5, size.height);
    }
    
    self.bubbleView.image = balloon;
}

@end
