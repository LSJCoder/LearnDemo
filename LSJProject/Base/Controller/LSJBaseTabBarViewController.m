//
//  LSJBaseTabBarViewController.m
//  LSJProject
//
//  Created by Joy on 2021/5/22.
//  Copyright © 2021年 Joy. All rights reserved.
//

#import "LSJBaseTabBarViewController.h"
#import "LSJHomeViewController.h"
#import "LSJCategoryViewController.h"
#import "LSJFoundViewController.h"
#import "LSJMineViewController.h"
#import "LSJBaseNavigationViewController.h"

@interface LSJBaseTabBarViewController ()

@end

@implementation LSJBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加所有子控制器
    [self setUpAllChildViewController];

//    self.tabBar.tintColor=NavigationColor;


}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

-(void)setUpAllChildViewController{
    // 首页
    LSJHomeViewController * home = [[LSJHomeViewController alloc] init];
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"首页01"] selectedImage:[UIImage imageNamed:@"首页01"] title:@"首页" tag:1];

    // 分类
    LSJCategoryViewController * category = [[LSJCategoryViewController alloc] init];
    [self setUpOneChildViewController:category image:[UIImage imageNamed:@"项目推荐_未选中"] selectedImage:[UIImage imageNamed:@"项目推荐_选中"] title:@"分类" tag:2];
    
    // 发现
    LSJFoundViewController * found = [[LSJFoundViewController alloc] init];
    [self setUpOneChildViewController:found image:[UIImage imageNamed:@"基金使用_未选中"] selectedImage:[UIImage imageNamed:@"基金使用_选中"] title:@"发现" tag:3];

    // 我的
    LSJMineViewController *mine = [[LSJMineViewController alloc] init];
    [self setUpOneChildViewController:mine image:[UIImage imageNamed:@"我的01"] selectedImage:[UIImage imageNamed:@"我的02"] title:@"我的" tag:4];

}

- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title tag:(NSInteger)tag{
    vc.title = title;
    vc.view.backgroundColor=[UIColor whiteColor];
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    LSJBaseNavigationViewController *nav = [[LSJBaseNavigationViewController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}




@end




