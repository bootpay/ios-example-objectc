//
//  BootpayRest.h
//  objectc_example
//
//  Created by Taesup Yoon on 2022/06/08.
//

#import <Foundation/Foundation.h>
#import "Bootpay-swift.h"
 

@interface BootpayRest : NSObject

+ (void) getRestToken:(id)sendable :(NSString*)restApplicationId :(NSString*)privateKey;
+ (void) getEasyPayUserToken:(id)sendable :(NSString*)restToken :(BootUser*)user;

@end
 
