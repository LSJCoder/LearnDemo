//
//  LSJBaseNavigationViewController.m
//  LSJProject
//
//  Created by Joy on 2021/5/22.
//  Copyright © 2021年 Joy. All rights reserved.
//

#import "LSJBaseNavigationViewController.h"

@interface LSJBaseNavigationViewController ()

@end

@implementation LSJBaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTintColor:NavigationColor];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"首页_蓝色底色"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    UINavigationBar *bar = [UINavigationBar appearance];
    NSMutableDictionary *barAttrs = [NSMutableDictionary dictionary];
    [barAttrs setObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    [bar setTitleTextAttributes:barAttrs];
    
}


//页面push的时候隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
