# REPOSE
## Abstract
A light extension of [AFNetworking](https://github.com/AFNetworking/AFNetworking) for REST.
The aim of this library is to provide a smart and light extesion of AFNetworking to create apps using REST server sides.

## Development
Repose is still in early development stage.

## Roadmap
- Basic calls (GET, POST, PUT, DELETE) ✓
- Basic object conversion/mapping ✓
- Basic authentication
- Support of XML and JSON calls/responses
- Smart object conversion
- Advanced authentications using OAuth 2.0
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

Please note that non all defined [status codes by W3](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html) have been implemented.

#LICENSE
Copyright (c) 2012 Vilea GmbH

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

Under no circumstances shall be granted use of this software, source code, documentation or other related material. Persons dealing in the Software agree not to knowingly distribute these materials or any derivative works to .

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.