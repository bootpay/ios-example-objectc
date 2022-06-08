//
//  PasswordUIController.m
//  objectc_example
//
//  Created by Taesup Yoon on 2022/06/08.
//

#import "PasswordUIController.h"
#import "BootpayUI-swift.h"

@interface PasswordUIController ()

@end

@implementation PasswordUIController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
    self.sendable = self;
//    self.send
    // Do any additional setup after loading the view.
}


- (void) setUI {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(0,
                             100,
                             [UIScreen mainScreen].bounds.size.width,
                             40)];
    [btn setTitle:@"정기결제 테스트" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goBootpay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void) goBootpay:(UIButton*)view {
    
    NSString *restApplicationId = @"5b8f6a4d396fa665fdc2b5ea";
    NSString *privateKey = @"rm6EYECr6aroQVG2ntW0A6LpWnkTgP4uQ3H18sDDUYw=";
//    [BootpayRest getRe]
    
    [BootpayRest getRestToken:self :restApplicationId :privateKey];
}

- (void) bootpayStart:(NSString*)userToken {
    BootBioPayload *payload = [[BootBioPayload alloc] init];
    payload.applicationId = @"5b8f6a4d396fa665fdc2b5e9";
    payload.price = 1000;
    
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
//    payload.orderId = [NSString stringWithFormat:@"%f", timeStamp];
    payload.orderId = [NSString stringWithFormat:@"%f", timeStamp];
    payload.pg = @"웰컴";
//    payload.method = @"카드자동";
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
    payload.user = [self getBootUser];
    payload.userToken = userToken;
    
    NSLog(@"requestBioPayment");
    
//
    [[[[[[[BootpayBio requestUIPasswordPayment:self
                               :payload
                               :true
                               :UIModalPresentationFormSheet]

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
 


- (void) callbackRestToken:(NSDictionary*)resData {
    NSString *restToken = [resData objectForKey:@"access_token"];
    [BootpayRest getEasyPayUserToken:self :restToken :[self getBootUser]];
}


- (void) callbackEasyCardUserToken:(NSDictionary*)resData {
    NSString *userToken = [resData objectForKey:@"user_token"];
    [self bootpayStart:userToken];
    
}

- (BootUser*) getBootUser {
    BootUser *user = [[BootUser alloc] init];
    user.id = @"123456abcdffffe2345678901234561324516789122";
    user.area = @"서울";
    user.gender = 1;
    user.email = @"test1234@gmail.com";
    user.phone = @"01012344567";
    user.birth = @"1988-06-10";
    user.username = @"홍길동";
    return user;
}



@end
