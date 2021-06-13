//
//  LSJMBProgressHUD.m
//  LSJProject
//
//  Created by Joy on 2021/6/13.
//  Copyright © 2021年 Joy. All rights reserved.
//

#import "LSJMBProgressHUD.h"
#import "UIImage+GIF.h"

@implementation LSJMBProgressHUD

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    hud.backgroundColor = [UIColor clearColor];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", icon]]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.0];
}

#pragma mark 展示自定义加载动图
+ (void)showImageHUDToView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    
    // 多张图片
    NSMutableArray *images = @[].mutableCopy;
    UIImage *image;
    for (int i = 0 ; i < 4; i++) {
        NSString *imageString = [NSString stringWithFormat:@"gif_car%i",i + 1];
        image = [UIImage imageNamed:imageString];
        if (image) {
            [images addObject:image];
        }
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];// 初始化必须要image，否则加载不到动画
    imageView.animationImages = images;
    imageView.animationDuration = 1.0;
    imageView.animationRepeatCount = 0;
    [imageView startAnimating];

    
//    //使用SDW 实现gif图片
//    UIImage *image = [UIImage sd_animatedGIFNamed:@"icon_yxzb_live"];
//    //自定义UIImageView
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    hud.customView = imageView;
    hud.minSize = CGSizeMake(100, 100);
    hud.color = [UIColor clearColor];
    
    hud.removeFromSuperViewOnHide = YES;
}

+ (void)showImageHUD {
    [self showImageHUDToView:nil];
}

+ (void)hideImageHUDToView:(UIView *)view {
    [self hideHUDForView:view];
}

+ (void)hideImageHUD {
    [self hideHUDForView:nil];
}

#pragma mark 显示信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

+ (MBProgressHUD *)showMessage:(NSString *)message {
    return [self showMessage:message toView:nil];
}

#pragma mark 隐藏信息
+ (void)hideHUDForView:(UIView *)view {
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [MBProgressHUD hideHUDForView:view animated:YES];
}

+ (void)hideHUD {
    [self hideHUDForView:nil];
}


@end
