//
//  ViewController.m
//  objectc_example
//
//  Created by Taesup Yoon on 2022/05/18.
//

#import "ViewController.h"

#import "Bootpay-swift.h"

@class DefaultController;
#import "DefaultController.h"

@class TotalController;
#import "TotalController.h"

@class SubscriptionController;
#import "SubscriptionController.h"

@class SubscriptionBootpayController;
#import "SubscriptionBootpayController.h"

@class AuthenticationController;
#import "AuthenticationController.h"

@class BioController;
#import "BioController.h"

@class PasswordController;
#import "PasswordController.h"

@class PasswordUIController;
#import "PasswordUIController.h"

@class WebAppController;
#import "WebAppController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
 
}

- (void) setUI {
    for(int i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.tag = i + 1;
        [btn setFrame:CGRectMake(0,
                                 100 + i * 50,
                                 [UIScreen mainScreen].bounds.size.width,
                                 40)];
        [btn addTarget:self action:@selector(goBootpay:) forControlEvents:UIControlEventTouchUpInside];
//        [btn setTitle:@"go bootpay" forState:UIControlStateNormal];
        
        if(i == 0) {
            [btn setTitle:@"1. PG일반 결제 테스트" forState:UIControlStateNormal];
        } else if(i == 1) {
            [btn setTitle:@"2. 통합결제 테스트" forState:UIControlStateNormal];
        } else if(i == 2) {
            [btn setTitle:@"3. 카드자동 결제 테스트 (인증)" forState:UIControlStateNormal];
        } else if(i == 3) {
            [btn setTitle:@"4. 카드자동 결제 테스트 (비인증)" forState:UIControlStateNormal];
        } else if(i == 4) {
            [btn setTitle:@"5. 본인인증 테스트" forState:UIControlStateNormal];
        } else if(i == 5) {
            [btn setTitle:@"6. 생체인증 결제 테스트" forState:UIControlStateNormal];
        } else if(i == 6) {
            [btn setTitle:@"7. 비밀번호 결제 테스트 - Bootpay" forState:UIControlStateNormal];
        } else if(i == 7) {
            [btn setTitle:@"8. 비밀번호 결제 테스트 - BootpayUI" forState:UIControlStateNormal];
        } else if(i == 8) {
            [btn setTitle:@"9. 웹앱으로 연동하기" forState:UIControlStateNormal];
        }
        
        [self.view addSubview:btn];
    }
}

- (void) goBootpay:(UIButton*)view {
    long tag = view.tag;
    if(tag == 1) {
        DefaultController *c = [[DefaultController alloc] init];
        [self.navigationController pushViewController:c animated:true];
    } else if(tag == 2) {
        TotalController *c = [[TotalController alloc] init];
        [self.navigationController pushViewController:c animated:true];
    } else if(tag == 3) {
        SubscriptionController *c = [[SubscriptionController alloc] init];
        [self.navigationController pushViewController:c animated:true];
    } else if(tag == 4) {
        SubscriptionBootpayController *c = [[SubscriptionBootpayController alloc] init];
        [self.navigationController pushViewController:c animated:true];
    } else if(tag == 5) {
        AuthenticationController *c = [[AuthenticationController alloc] init];
        [self.navigationController pushViewController:c animated:true];
    } else if(tag == 6) {
        BioController *c = [[BioController alloc] init];
        [self.navigationController pushViewController:c animated:true];
    } else if(tag == 7) {
        PasswordController *c = [[PasswordController alloc] init];
        [self.navigationController pushViewController:c animated:true];
    } else if(tag == 8) {
        PasswordUIController *c = [[PasswordUIController alloc] init];
        [self.navigationController pushViewController:c animated:true];
    } else if(tag == 9) {
        WebAppController *c = [[WebAppController alloc] init];
        [self.navigationController pushViewController:c animated:true];
    }
}
 

- (void) goBootpayTest {
    
    Payload *payload = [[Payload alloc] init];
    payload.applicationId = @"5b8f6a4d396fa665fdc2b5e9";
    payload.price = 1000;
    
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    payload.orderId = [NSString stringWithFormat:@"%f", timeStamp];
    payload.pg = @"나이스페이";
    payload.method = @"카드";
    payload.orderName = @"테스트 아이템";
//    payload.extra = [[BootExtra alloc] init];
//    payload.extra.quotas = [[NSMutableArray alloc] initWithObjects: 0, 2, 3, nil];
//    payload.extra.cardQuota = @"0,2,3";
    
    BootItem *item1 = [[BootItem alloc] init];
    item1.name = @"나는 아이템1";
    item1.qty = 1;
    item1.id = @"item_01";
    item1.price = 500;
    item1.cat1 = @"TOP";
    item1.cat2 = @"티셔츠";
    item1.cat3 = @"반팔티";
    
    BootItem *item2 = [[BootItem alloc] init];
    item2.name = @"나는 아이템2";
    item2.qty = 2;
    item2.id = @"item_02";
    item2.price = 250;
    item2.cat1 = @"TOP";
    item2.cat2 = @"데님";
    item2.cat3 = @"청자켓";
    payload.items = [[NSMutableArray alloc] initWithObjects:item1, item2, nil];
    
//
    [[[[[[[Bootpay requestPayment:self
                               :payload
                               :true
                            :UIModalPresentationFullScreen]

      onError:^(NSDictionary *data) {
        NSLog(@"-- onError: %@", data);

      }]
      onIssued:^(NSDictionary *data) {
        NSLog(@"-- onIssued: %@", data);
      }]
      onConfirm:^BOOL(NSDictionary *data) {
        NSLog(@"-- confirm: %@", data);
//        [Bootpay transactionConfirm];
        return true;
      }]
      onCancel:^(NSDictionary *data) {
        NSLog(@"-- onCancel: %@", data);

      }]
      onDone:^(NSDictionary *data) {
        NSLog(@"-- onDone: %@", data);
      }]
      onClose:^() {
        NSLog(@"-- onClose");
    }];
}

@end
