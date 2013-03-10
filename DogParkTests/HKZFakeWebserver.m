//
//  HKZFakeWebserver.m
//  DogPark
//
//  Created by zm on 2/18/13.
//  Copyright (c) 2013 Hackazach. All rights reserved.
//

#import "HKZFakeWebserver.h"
@implementation HKZFakeWebserver

// This function returns the correct JSON data, or whatever for the requested URL
// via the ILURLProtocol

- (NSData *)responseDataForClient:(id<NSURLProtocolClient>)client request:(NSURLRequest*)request {
	NSData *responseData = nil;
        
    // Dog profile information
    if ([request.URL.absoluteString isEqual:@"http://dogpark.net/api/profile?id=33"] &&
            [request.HTTPMethod isEqualToString:@"GET"]) {
                NSBundle *bundle = [NSBundle bundleForClass:[self class]];
                NSString *resource = [bundle pathForResource:@"profile" ofType:@"json"];
                responseData = [[NSData alloc] initWithContentsOfFile:resource];
            }
   
    // Error handling for DogPark signup 
    else if ([request.URL.absoluteString isEqual:@"http://dogpark.net/api/new"] &&
         [request.HTTPMethod isEqualToString:@"POST"]) {
        
            // Post data, if we need it is here
            // NSString *postString = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
        
            NSBundle *bundle = [NSBundle bundleForClass:[self class]];
            NSString *resource = [bundle pathForResource:@"signupError" ofType:@"json"];
            responseData = [[NSData alloc] initWithContentsOfFile:resource];
        }
	return responseData;
}
@end