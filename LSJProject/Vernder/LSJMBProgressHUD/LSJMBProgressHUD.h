//
//  LSJMBProgressHUD.h
//  LSJProject
//
//  Created by Joy on 2021/6/13.
//  Copyright © 2021年 Joy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>


@interface LSJMBProgressHUD : NSObject

+ (void)showImageHUDToView:(UIView *)view;
+ (void)showImageHUD;

+ (void)hideImageHUDToView:(UIView *)view;
+ (void)hideImageHUD;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end

