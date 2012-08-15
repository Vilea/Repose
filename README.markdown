# REPOSE
## Abstract
A light extension of [AFNetworking](https://github.com/AFNetworking/AFNetworking) for REST.
The aim of this library is to provide a smart and light extesion of AFNetworking to create apps using full REST server sides.

## Development
Repose is still in early development stage.

## Roadmap
- Basic calls (GET, POST, PUT, DELETE) ✓
- Basic object conversion/mapping ✓
- Basic authentication
- Support of XML and JSON calls/responses
- Smart object conversion
- Advanced authentications using OAuth 2.0 ✓ (using a fork of [AFOAuth2Client](https://github.com/bontoJR/AFOAuth2Client))
- Core Data integration and optimization
- [TouchDB](https://github.com/couchbaselabs/TouchDB-iOS) integration

## Usage
Import [AFNetworking](https://github.com/AFNetworking/AFNetworking) and then the files in 'Repose' folder inside your project.<br/>
Import the file in your class with `#import "Repose.h"` where needed.<br/>
Init the class with `initWithBaseURL:`. The base URL will be used to create the correct URL for calls, for example Twitter's URL is `https://api.twitter.com/1`.<br/>
Once the object has been initiliazied, simply use the following methods to send requests:

	- (void)get:(NSString *)path parameters:(NSDictionary *)params withBlock:(void (^)(ReposeResponseCode code, id responseObject))block
	- (void)post:(NSString *)path parameters:(NSDictionary *)params withBlock:(void (^)(ReposeResponseCode code, id responseObject))block
	- (void)put:(NSString *)path parameters:(NSDictionary *)params withBlock:(void (^)(ReposeResponseCode code, id responseObject))block
	- (void)delete:(NSString *)path parameters:(NSDictionary *)params withBlock:(void (^)(ReposeResponseCode code, id responseObject))block

Handle the response with a block.

### Example

	// Base URL: https://api.twitter.com/1
	// Complete Call URL: https://api.twitter.com/1/statuses/user_timeline.json?include_entities=false&include_rts=true&screen_name=VileaGmbH&count=100
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"false", @"include_entities", @"true", @"include_rts", @"VileaGmbH", @"screen_name", @"100", @"count", nil];
    [self.server get:@"statuses/user_timeline.json" parameters:params withBlock:^(ReposeResponseCode code, id responseObject){
        NSLog(@"responseObject -> %@", responseObject);
        _objects = responseObject;
        
        [self.tableView reloadData];
    }];

The previous call get the latest tweets for the user VileaGmbH.

### OAuth 2.0
OAuth 2.0 could be a pain in the 4$$ if not well implemented and sometimes it's needed to access third party services.<br/>
We implemented a first version of OAuth 2.0 authentication and authorization. Due to the complexity and the big differences of each implementation, we made 2 examples with GitHub (retrieving Repos) and Foursquare (retrieving checkins).

The system basically works with this method (from Foursquare example):

		[self.client authenticateUsingOAuthWithPath:@"/oauth2/authenticate"
	                                         parameters:@{ @"client_id" : kConsumerKey, @"response_type" : @"token", @"redirect_uri" : kCallbackURL}
	                                           callback:kCallbackURL
	                                      withWebViewIn:self
	                                           delegate:(id<AFOAuth2ClientDelegate>)self];

Once the user has authenticated and authorized, the system returns the token to use, using the delegate:

		@protocol AFOAuth2ClientDelegate <NSObject>
		- (void)client:(AFOAuth2Client *)client receivedToken:(NSString *)token;
		- (void)client:(AFOAuth2Client *)client failedToReceiveToken:(NSError *)error;
		@end

That could be saved and handled in this way:

		- (void)client:(AFOAuth2Client *)client receivedToken:(NSString *)token
		{
		    self.token = token;
		    [[NSUserDefaults standardUserDefaults] setObject:token forKey:NSStringFromClass([self class])];
		    [[NSUserDefaults standardUserDefaults] synchronize];
		    
		    [self.ai stopAnimating];
		}
*Note: this is and example, the best ways is saving the token in the keychain, an example is coming soon.*

### ReposeResponseCode
In Repose, to help readability and coding, we mapped the most commons http status codes in this way:

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

Please note that not all defined [status codes by W3](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html) have been implemented.

## Bubble Cell
The example comes with a class called `VIBubbleCell` that reproduces the bubble of the SMS app. Feel free to use this class (and eventually extends it) in any project.

#LICENSE
Copyright (c) 2012 Vilea GmbH

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

Under no circumstances shall be granted use of this software, source code, documentation or other related material. Persons dealing in the Software agree not to knowingly distribute these materials or any derivative works to .

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.