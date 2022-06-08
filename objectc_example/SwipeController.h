//
//  SwipeController.h
//  objectc_example
//
//  Created by Taesup Yoon on 2022/06/08.
//

#import <UIKit/UIKit.h>
 
@protocol BootpayRestProtocol

- (void) callbackRestToken:(NSDictionary*)resData;
- (void) callbackEasyCardUserToken:(NSDictionary*)resData;

@end

@interface SwipeController : UIViewController

- (NSLayoutYAxisAnchor *) safeTopAnchor;
- (NSLayoutYAxisAnchor *) safeBottomAnchor;

@end
 
