//
//  LSJCategoryViewController.m
//  LSJProject
//
//  Created by Joy on 2021/5/22.
//  Copyright © 2021年 Joy. All rights reserved.
//

#import "LSJCategoryViewController.h"

@interface LSJCategoryViewController ()

@end

@implementation LSJCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tempAppearance];
}

- (void)tempAppearance {
    UILabel *tipsLabel = UILabel.new;
    tipsLabel.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    tipsLabel.text = @"敬请期待~";
    tipsLabel.font = LSJBoldFont(15);
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipsLabel];
}

@end
