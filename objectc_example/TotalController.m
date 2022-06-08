//
//  TotalController.m
//  objectc_example
//
//  Created by Taesup Yoon on 2022/06/08.
//

#import "TotalController.h"
#import "Bootpay-swift.h"

@interface TotalController ()

@end

@implementation TotalController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void) setUI {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(0,
                             100,
                             [UIScreen mainScreen].bounds.size.width,
                             40)];
    [btn setTitle:@"통합결제 테스트" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goBootpay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void) goBootpay:(UIButton*)view {
    
    Payload *payload = [[Payload alloc] init];
    payload.applicationId = @"5b8f6a4d396fa665fdc2b5e9";
    payload.price = 1000;
    
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    payload.orderId = [NSString stringWithFormat:@"%f", timeStamp];
//    payload.pg = @"나이스페이";
//    payload.method = @"카드";
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
