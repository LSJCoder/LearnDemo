//
//  LSJMBProgressHUDCustomViewController.m
//  LSJProject
//
//  Created by Joy on 2021/6/13.
//  Copyright © 2021年 Joy. All rights reserved.
//

#import "LSJMBProgressHUDCustomViewController.h"

@interface LSJMBProgressHUDCustomViewController ()

@end

@implementation LSJMBProgressHUDCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self MBProgressHUDDemo];
}

- (void)MBProgressHUDDemo {
    WeakSelf
    [LSJMBProgressHUD showImageHUDToView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LSJMBProgressHUD hideImageHUDToView:weakSelf.view];
    });
}

@end
