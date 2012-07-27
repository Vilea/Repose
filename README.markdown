# REPOSE
## Abstract
A light extension of [AFNetworking](https://github.com/AFNetworking/AFNetworking) for REST.
The aim of this library is to provide a smart and light extesion of AFNetworking to create apps using REST server sides.

## Development
Repose is still in early development stage.

## Roadmap
- Basic calls (GET, POST, PUT, DELETE)
- Basic object conversion/mapping
- Basic authentication
- Support of XML and JSON calls/responses
- Smart object conversion
- Advanced authentications using OAuth 2.0
- Core Data integration and optimization
- [TouchDB](https://github.com/couchbaselabs/TouchDB-iOS) integration

## Usage
Import [AFNetworking](https://github.com/AFNetworking/AFNetworking) and then the files in 'Repose' folder inside your project.
Import the file in your class with `#import "Repose.h"` where needed.
Init the class with `initWithBaseURL:`. The base URL will be used to create the correct URL for calls, for example Twitter's URL is `https://api.twitter.com/1`.
Once the object has been initiliazied, simply use the methods:

		- (void)get:(NSString *)path parameters:(NSDictionary *)params withBlock:(void (^)(ReposeResponseCode code, id responseObject))block
		- (void)post:(NSString *)path parameters:(NSDictionary *)params withBlock:(void (^)(ReposeResponseCode code, id responseObject))block
		- (void)put:(NSString *)path parameters:(NSDictionary *)params withBlock:(void (^)(ReposeResponseCode code, id responseObject))block
		- (void)delete:(NSString *)path parameters:(NSDictionary *)params withBlock:(void (^)(ReposeResponseCode code, id responseObject))block

To send requests.
Hanlde the response with a block.

### ReposeResponseCode
In repose, to help readability and coding, we mapped the most commons code in this way:

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