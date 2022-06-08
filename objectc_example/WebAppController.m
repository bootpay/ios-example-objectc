//
//  WebAppController.m
//  objectc_example
//
//  Created by Taesup Yoon on 2022/06/08.
//

#import "WebAppController.h"
#import "Bootpay-swift.h"

@interface WebAppController ()

@end

@implementation WebAppController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUI];
}

- (void) setUI {
    BootpayWebView *webView = [[BootpayWebView alloc] init];
    [self.view addSubview:webView];
    
    NSArray *constrains = @[
        [webView.topAnchor constraintEqualToAnchor: [self safeTopAnchor]],
        [webView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
        [webView.bottomAnchor constraintEqualToAnchor: [self safeBottomAnchor]],
        [webView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor],

    ];
    [NSLayoutConstraint activateConstraints: constrains];
    
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString: @"https://d-cdn.bootapi.com/test/payment/"]]; //set your web doamin
    [webView.webview loadRequest:request];
}
 

@end
