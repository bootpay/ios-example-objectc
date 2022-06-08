//
//  SwipeController.m
//  objectc_example
//
//  Created by Taesup Yoon on 2022/06/08.
//

#import "SwipeController.h"

@interface SwipeController ()

@end

@implementation SwipeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationController.navigationBarHidden = true;
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    [self.navigationController.interactivePopGestureRecognizer setEnabled:self.navigationController.viewControllers.count > 1];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    
    [self.navigationController.interactivePopGestureRecognizer setEnabled:self.navigationController.viewControllers.count > 1];
}


- (NSLayoutYAxisAnchor *) safeTopAnchor {
   if (@available(iOS 11.0, *)) {
        return self.view.safeAreaLayoutGuide.topAnchor;
   }
    return self.view.topAnchor;
}


- (NSLayoutYAxisAnchor *) safeBottomAnchor {
   if (@available(iOS 11.0, *)) {
        return self.view.safeAreaLayoutGuide.bottomAnchor;
   }
    return self.view.bottomAnchor;
}
 
@end
