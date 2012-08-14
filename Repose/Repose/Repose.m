//
//  Repose.m
//  Repose
//
//  Created by Junior Bontognali on 7/24/12.
//  Copyright (c) 2012 Vilea GmbH. All rights reserved.
//

#import "Repose.h"

@implementation Repose

- (id)initWithBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL:url]) {
        self.parameterEncoding = AFJSONParameterEncoding;
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    return self;
}

#pragma mark - Basic Requests

- (void)sendRequestWithMethod:(NSString*)method 
                         path:(NSString *)path 
                   parameters:(NSDictionary *)params 
                    withBlock:(void (^)(ReposeResponseCode code, id responseObject))block
{
    NSMutableURLRequest *request = [self requestWithMethod:method path:path parameters:params];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request 
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) 
                                         {
                                             if REPOSE_RESPONSE_OK(response.statusCode) {
                                                 block(response.statusCode, JSON);
                                             } else {
                                                 block(response.statusCode, nil);
                                             }
                                         } 
                                                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
                                         {
                                             block(ReposeResponseCodeRequestFailed, error);
                                         }];
    [operation start];
}

- (void)get:(NSString *)path parameters:(NSDictionary *)params withBlock:(void (^)(ReposeResponseCode code, id responseObject))block
{
    [self sendRequestWithMethod:@"GET" path:path parameters:params withBlock:block];
}

- (void)post:(NSString *)path parameters:(NSDictionary *)params withBlock:(void (^)(ReposeResponseCode code, id responseObject))block
{
    [self sendRequestWithMethod:@"POST" path:path parameters:params withBlock:block];
}

- (void)put:(NSString *)path parameters:(NSDictionary *)params withBlock:(void (^)(ReposeResponseCode code, id responseObject))block
{
    [self sendRequestWithMethod:@"PUT" path:path parameters:params withBlock:block];
}

- (void)delete:(NSString *)path parameters:(NSDictionary *)params withBlock:(void (^)(ReposeResponseCode code, id responseObject))block
{
    [self sendRequestWithMethod:@"DELETE" path:path parameters:params withBlock:block];
}

@end
