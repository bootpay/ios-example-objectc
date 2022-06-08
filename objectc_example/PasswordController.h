//
//  PasswordController.h
//  objectc_example
//
//  Created by Taesup Yoon on 2022/06/08.
//

#import <UIKit/UIKit.h>
 
@class SwipeController;
#import "SwipeController.h"


@class BootpayRest;
#import "BootpayRest.h"

@interface PasswordController : SwipeController

@property (weak) id<BootpayRestProtocol> sendable;

@end
 
