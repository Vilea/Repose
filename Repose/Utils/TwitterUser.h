//
//  TwitterUser.h
//  
//
//  Created by Junior B. on 7/25/12.
//  Copyright (c) 2012 Vilea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+JSON.h"

@interface TwitterUser : NSObject

@property (nonatomic, strong) NSNumber *contributorsEnabled;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSNumber *defaultProfile;
@property (nonatomic, strong) NSNumber *defaultProfileImage;
@property (nonatomic, strong) NSString *descriptionText;
@property (nonatomic, strong) NSNumber *favouritesCount;
@property (nonatomic, strong) NSString *followRequestSent;
@property (nonatomic, strong) NSNumber *followersCount;
@property (nonatomic, strong) NSString *following;
@property (nonatomic, strong) NSNumber *friendsCount;
@property (nonatomic, strong) NSNumber *geoEnabled;
@property (nonatomic, strong) NSNumber *myClassId;
@property (nonatomic, strong) NSNumber *idStr;
@property (nonatomic, strong) NSNumber *isTranslator;
@property (nonatomic, strong) NSString *lang;
@property (nonatomic, strong) NSNumber *listedCount;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *notifications;
@property (nonatomic, strong) NSNumber *profileBackgroundColor;
@property (nonatomic, strong) NSString *profileBackgroundImageUrl;
@property (nonatomic, strong) NSString *profileBackgroundImageUrlHttps;
@property (nonatomic, strong) NSNumber *profileBackgroundTile;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *profileImageUrlHttps;
@property (nonatomic, strong) NSString *profileLinkColor;
@property (nonatomic, strong) NSString *profileSidebarBorderColor;
@property (nonatomic, strong) NSString *profileSidebarFillColor;
@property (nonatomic, strong) NSNumber *profileTextColor;
@property (nonatomic, strong) NSNumber *profileUseBackgroundImage;
@property (nonatomic, strong) NSNumber *protected;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSNumber *showAllInlineMedia;
@property (nonatomic, strong) NSNumber *statusesCount;
@property (nonatomic, strong) NSString *timeZone;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSNumber *utcOffset;
@property (nonatomic, strong) NSNumber *verified;

+ (TwitterUser *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
