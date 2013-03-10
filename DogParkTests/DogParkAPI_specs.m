#import "Kiwi.h"
#import "ILCannedURLProtocol.h"
#import "HKZFakeWebserver.h"
#import "HKZDogParkAPIClient.h"

SPEC_BEGIN(DogParkAPI)

describe(@"DogPark API", ^{

    beforeEach(^{
        [NSURLProtocol registerClass:[ILCannedURLProtocol class]];
       
        [ILCannedURLProtocol setCannedStatusCode:200];
        [ILCannedURLProtocol setSupportedMethods:[[NSArray alloc] initWithObjects:@"GET",@"POST", @"PUT", nil]];
        NSMutableDictionary *headers = [[NSMutableDictionary alloc] init];
        [headers setObject:@"application/json; charset=utf-8" forKey:@"Content-Type"];
        [ILCannedURLProtocol setCannedHeaders: headers];
    });
    
    afterEach(^{
        [NSURLProtocol unregisterClass:[ILCannedURLProtocol class]];
    });
   
   
    it(@"fetches a dog profile", ^{
        
        HKZDogParkAPIClient *client = [[HKZDogParkAPIClient alloc] init];
        
        __block NSString *dogName = @"dunno";
        
        void (^callback)(NSDictionary *dog, NSError *error) = ^(NSDictionary *dog, NSError *error){
            // Put in the dog name
            dogName = [dog objectForKey:@"Name"];
        };
       
        NSNumber *profile = [NSNumber numberWithInt:33];
        [client fetchProfile:[profile intValue]  block:callback];
        
        [[expectFutureValue(dogName) shouldEventually] equal:@"Ollie"];
    });
     
    it(@"handles a signup error", ^{
      
        HKZFakeWebserver *delegate = [[HKZFakeWebserver alloc] init];
        [ILCannedURLProtocol setDelegate:delegate];
       
        HKZDogParkAPIClient *client = [[HKZDogParkAPIClient alloc] init];
        
        __block NSError *testError = [[NSError alloc] initWithDomain:@"none" code:nil userInfo:nil];
        
        void (^callback)(NSDictionary *dog, NSError *error) = ^(NSDictionary *dog, NSError *error){
           // Get the NSError name
            testError = error;
        };
        
        // todo make signup actually take some info
        [client signup:callback];
        
        [[expectFutureValue(testError.localizedDescription) shouldEventually] equal:@"missistuffion"];

        
        
    });
    
});
SPEC_END