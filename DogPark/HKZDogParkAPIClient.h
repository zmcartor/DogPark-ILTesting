//
//  HKZDogParkAPIClient.h
//  DogPark
//
//  Created by zm on 2/23/13.
//  Copyright (c) 2013 Hackazach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface HKZDogParkAPIClient : NSObject

- (void)fetchProfile:(int)profileId block:(void(^)(NSDictionary *dog, NSError* error))clientBlock;
- (void)signup:(void(^)(NSDictionary *dog, NSError* error))clientBlock;

@end
