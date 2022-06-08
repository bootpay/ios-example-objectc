//
//  BootpayRest.m
//  objectc_example
//
//  Created by Taesup Yoon on 2022/06/08.
//

#import "BootpayRest.h"
#import "AFNetworking.h"

@class SwipeController;
#import "SwipeController.h"
//#import "Ala"

//@protocol BootpayRestProtocol
//
//- (void) callbackRestToken:(NSDictionary*)resData;
//- (void) callbackEasyCardUserToken:(NSDictionary*)resData;
//
//@end

@implementation BootpayRest

+ (void) getRestToken:(id<BootpayRestProtocol>)sendable :(NSString*)restApplicationId :(NSString*)privateKey
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *url = @"https://api.bootpay.co.kr/v2/request/token.json";
        
    [manager POST:url
       parameters:@{@"application_id": restApplicationId, @"private_key": privateKey}
          headers:@{}
         progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
//        NSLog(@"responseObject: %@", responseObject);
        [sendable callbackRestToken:responseObject];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
    }];
}

+ (void) getEasyPayUserToken:(id)sendable :(NSString*)restToken :(BootUser*)user
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *url = @"https://api.bootpay.co.kr/v2/request/user/token";
    
    NSDictionary *params = @{
        @"user_id": user.id,
        @"email": user.email,
        @"username": user.username,
        @"gender": [NSString stringWithFormat:@"%ld", (long)user.gender],
        @"birth": user.birth,
        @"phone": user.phone
    };
        
    [manager POST:url
       parameters:params
          headers:@{
            @"Authorization": [NSString stringWithFormat:@"Bearer %@", restToken],
            @"Accept": @"application/json"
        }
         progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
//        NSLog(@"responseObject: %@", responseObject);
        
        [sendable callbackEasyCardUserToken:responseObject];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
    }];
}

@end
