//
//  TwitterUser.m
//  
//
//  Created by Junior B. on 7/25/12.
//  Copyright (c) 2012 Vilea. All rights reserved.
//

#import "TwitterUser.h"

@implementation TwitterUser

@synthesize contributorsEnabled;
@synthesize createdAt;
@synthesize defaultProfile;
@synthesize defaultProfileImage;
@synthesize descriptionText;
@synthesize favouritesCount;
@synthesize followRequestSent;
@synthesize followersCount;
@synthesize following;
@synthesize friendsCount;
@synthesize geoEnabled;
@synthesize myClassId;
@synthesize idStr;
@synthesize isTranslator;
@synthesize lang;
@synthesize listedCount;
@synthesize location;
@synthesize name;
@synthesize notifications;
@synthesize profileBackgroundColor;
@synthesize profileBackgroundImageUrl;
@synthesize profileBackgroundImageUrlHttps;
@synthesize profileBackgroundTile;
@synthesize profileImageUrl;
@synthesize profileImageUrlHttps;
@synthesize profileLinkColor;
@synthesize profileSidebarBorderColor;
@synthesize profileSidebarFillColor;
@synthesize profileTextColor;
@synthesize profileUseBackgroundImage;
@synthesize protected;
@synthesize screenName;
@synthesize showAllInlineMedia;
@synthesize statusesCount;
@synthesize timeZone;
@synthesize url;
@synthesize utcOffset;
@synthesize verified;


+ (TwitterUser *)instanceFromDictionary:(NSDictionary *)aDictionary {

    TwitterUser *instance = [[TwitterUser alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    [self setValuesForKeysWithDictionary:aDictionary];

}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    if ([key isEqualToString:@"contributors_enabled"]) {
        [self setValue:value forKey:@"contributorsEnabled"];
    } else if ([key isEqualToString:@"created_at"]) {
        [self setValue:value forKey:@"createdAt"];
    } else if ([key isEqualToString:@"default_profile"]) {
        [self setValue:value forKey:@"defaultProfile"];
    } else if ([key isEqualToString:@"default_profile_image"]) {
        [self setValue:value forKey:@"defaultProfileImage"];
    } else if ([key isEqualToString:@"description"]) {
        [self setValue:value forKey:@"descriptionText"];
    } else if ([key isEqualToString:@"favourites_count"]) {
        [self setValue:value forKey:@"favouritesCount"];
    } else if ([key isEqualToString:@"follow_request_sent"]) {
        [self setValue:value forKey:@"followRequestSent"];
    } else if ([key isEqualToString:@"followers_count"]) {
        [self setValue:value forKey:@"followersCount"];
    } else if ([key isEqualToString:@"friends_count"]) {
        [self setValue:value forKey:@"friendsCount"];
    } else if ([key isEqualToString:@"geo_enabled"]) {
        [self setValue:value forKey:@"geoEnabled"];
    } else if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"myClassId"];
    } else if ([key isEqualToString:@"id_str"]) {
        [self setValue:value forKey:@"idStr"];
    } else if ([key isEqualToString:@"is_translator"]) {
        [self setValue:value forKey:@"isTranslator"];
    } else if ([key isEqualToString:@"listed_count"]) {
        [self setValue:value forKey:@"listedCount"];
    } else if ([key isEqualToString:@"profile_background_color"]) {
        [self setValue:value forKey:@"profileBackgroundColor"];
    } else if ([key isEqualToString:@"profile_background_image_url"]) {
        [self setValue:value forKey:@"profileBackgroundImageUrl"];
    } else if ([key isEqualToString:@"profile_background_image_url_https"]) {
        [self setValue:value forKey:@"profileBackgroundImageUrlHttps"];
    } else if ([key isEqualToString:@"profile_background_tile"]) {
        [self setValue:value forKey:@"profileBackgroundTile"];
    } else if ([key isEqualToString:@"profile_image_url"]) {
        [self setValue:value forKey:@"profileImageUrl"];
    } else if ([key isEqualToString:@"profile_image_url_https"]) {
        [self setValue:value forKey:@"profileImageUrlHttps"];
    } else if ([key isEqualToString:@"profile_link_color"]) {
        [self setValue:value forKey:@"profileLinkColor"];
    } else if ([key isEqualToString:@"profile_sidebar_border_color"]) {
        [self setValue:value forKey:@"profileSidebarBorderColor"];
    } else if ([key isEqualToString:@"profile_sidebar_fill_color"]) {
        [self setValue:value forKey:@"profileSidebarFillColor"];
    } else if ([key isEqualToString:@"profile_text_color"]) {
        [self setValue:value forKey:@"profileTextColor"];
    } else if ([key isEqualToString:@"profile_use_background_image"]) {
        [self setValue:value forKey:@"profileUseBackgroundImage"];
    } else if ([key isEqualToString:@"screen_name"]) {
        [self setValue:value forKey:@"screenName"];
    } else if ([key isEqualToString:@"show_all_inline_media"]) {
        [self setValue:value forKey:@"showAllInlineMedia"];
    } else if ([key isEqualToString:@"statuses_count"]) {
        [self setValue:value forKey:@"statusesCount"];
    } else if ([key isEqualToString:@"time_zone"]) {
        [self setValue:value forKey:@"timeZone"];
    } else if ([key isEqualToString:@"utc_offset"]) {
        [self setValue:value forKey:@"utcOffset"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }

}


@end
