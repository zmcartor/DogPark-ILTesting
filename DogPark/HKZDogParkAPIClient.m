
//
//  HKZDogParkAPIClient.m
//  DogPark
//
//  Created by zm on 2/23/13.
//  Copyright (c) 2013 Hackazach. All rights reserved.
//

#import "HKZDogParkAPIClient.h"

typedef void (^networkSuccessBlock)(NSURLRequest *request, NSHTTPURLResponse *response,id JSON);
typedef void (^networkFailBlock)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON);

@implementation HKZDogParkAPIClient

- (void)fetchProfile:(int)profileId block:(void (^)(NSDictionary *, NSError *))clientBlock {
    
    NSURL *latestURL = [NSURL URLWithString:
                        [NSString stringWithFormat:@"http://dogpark.net/api/profile?id=%i",profileId]];
    
    NSMutableURLRequest *profileReq = [NSMutableURLRequest requestWithURL:latestURL];
    [profileReq setHTTPMethod:@"GET"];
    [profileReq setValue:@"application/json" forHTTPHeaderField:@"accepts"];
    
    networkSuccessBlock successBlock = ^(NSURLRequest *request, NSHTTPURLResponse *response,id JSON) {
        // process the response, call the client block.
    };
    
    networkFailBlock failBlock = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        // set error test, call client block
    };
    
    AFJSONRequestOperation *requestOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:profileReq
                                                                                               success:successBlock failure:failBlock];
    [requestOperation start];
};

- (void)signup:(void (^)(NSDictionary *, NSError *))clientBlock {
    
    NSURL *signupURL = [NSURL URLWithString:@"http://dogpark.net/api/new"];
    
    NSMutableURLRequest *signupReq = [NSMutableURLRequest requestWithURL:signupURL];
    [signupReq setHTTPMethod:@"POST"];
    [signupReq setValue:@"application/json" forHTTPHeaderField:@"accepts"];
    
    networkSuccessBlock successBlock = ^(NSURLRequest *request, NSHTTPURLResponse *response,id JSON) {
        // process the response, call the client block.
        NSLog(@"%@", response);
    };
    
    networkFailBlock failBlock = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@", response);
 
        // set error test, call client block
    };
    
    AFJSONRequestOperation *requestOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:signupReq
                                                                                               success:successBlock failure:failBlock];
    [requestOperation start];
};

@end
