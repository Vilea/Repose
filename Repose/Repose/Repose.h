//
//  Repose.h
//  Repose
//
//  Created by Junior Bontognali on 7/24/12.
//  Copyright (c) 2012 Vilea GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFOAuth2Client.h"

#define REPOSE_RESPONSE_OK(c) (c == ReposeResponseCodeOK || c == ReposeResponseCodeCreated || c == ReposeResponseCodeAccepted)
#define REPOSE_RESPONSE_NOT_OK(c) !ReposeResponseOK(c)

typedef enum {
    ReposeResponseCodeOK = 200,
    ReposeResponseCodeCreated = 201,
    ReposeResponseCodeAccepted = 202,
    
    ReposeResponseCodeMovedPermanently = 301,
    ReposeResponseCodeTemporaryRedirect = 307,
    
    ReposeResponseCodeBadRequest = 400,
    ReposeResponseCodeUnauthorized = 401,
    ReposeResponseCodeForbidden = 403,
    ReposeResponseCodeNotFound = 404,
    ReposeResponseCodeMethodNotAllowed = 405,
    ReposeResponseCodeNotAcceptable = 406,
    ReposeResponseCodeRequestTimeout = 408,
    
    ReposeResponseCodeInternalServerError = 500,
    ReposeResponseCodeBadGateway = 502,
    ReposeResponseCodeServiceUnavailable = 503,
    ReposeResponseCodeGatewayTimeout = 504,
    ReposeResponseCodeHTTPVersionNotSupported = 505,
    
    ReposeResponseCodeRequestFailed = 0
} ReposeResponseCode;

#ifdef AFOAuth2ClientImported
@interface Repose : AFOAuth2Client
#else
@interface Repose : AFHTTPClient
#endif

- (void)sendRequestWithMethod:(NSString*)method 
                         path:(NSString *)path 
                   parameters:(NSDictionary *)params 
                    withBlock:(void (^)(ReposeResponseCode code, id responseObject))block;

- (void)get:(NSString *)path parameters:(NSDictionary *)params withBlock:(void (^)(ReposeResponseCode code, id responseObject))block;
- (void)post:(NSString *)path parameters:(NSDictionary *)params withBlock:(void (^)(ReposeResponseCode code, id responseObject))block;
- (void)put:(NSString *)path parameters:(NSDictionary *)params withBlock:(void (^)(ReposeResponseCode code, id responseObject))block;
- (void)delete:(NSString *)path parameters:(NSDictionary *)params withBlock:(void (^)(ReposeResponseCode code, id responseObject))block;

@end
