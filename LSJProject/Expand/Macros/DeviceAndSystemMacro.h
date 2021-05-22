//
//  DeviceAndSystemMacro.h
//  LSJProject
//
//  Created by Joy on 2021/5/22.
//  Copyright © 2021年 Joy. All rights reserved.
//

// 设备和系统相关的宏

#ifndef DeviceAndSystemMacro_h
#define DeviceAndSystemMacro_h


// 判断手机类型
#define isPad   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad   ? YES : NO)
#define isPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? YES : NO)
#define isRetina ([[UIScreen mainScreen] scale] > 1 ? YES : NO)

// 屏幕
#define ScreenWidth       [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight      [[UIScreen mainScreen] bounds].size.height
#define LSJMinX(A)        CGRectGetMinX(A)
#define LSJMinY(A)        CGRectGetMinY(A)
#define LSJMaxX(A)        CGRectGetMaxX(A)
#define LSJMaxY(A)        CGRectGetMaxY(A)
#define LSJMidY(A)        CGRectGetMidY(A)
#define LSJWidth(A)       CGRectGetWidth(A)
#define LSJHeight(A)      CGRectGetHeight(A)

// 根据屏幕比列获取控件宽高（以iPhone6尺寸为准）
#define ScreenWidthOrHeightWithWidth(width)     width *(ScreenWidth / 375.0) // 以宽度换算
#define ScreenWidthOrHeightWithHeight(height)   height *(ScreenHeight / 667.0)// 以高度换算


// iphoneX的适配
#pragma mark - iPhoneX出现后
#define GKStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height //状态栏高度，iPhone X之前是20，之后是44
#define isiPhone4 ([UIScreen mainScreen].bounds.size.height <= 480 && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
// 判断是否为IphoneXSeries:包括iPhone X,iPhone XS,iPhone XS Max,iPhone XR
#define isIPhonoX                      (GKStatusBarHeight > 30.0f)//iPhone X之前是20，之后是44
// 导航栏高度
#define NavBarHeight                   (isIPhoneX ? 88 : 64)
// 没有状态栏的导航栏
#define NavBarNoStatusBarHeight        44
// 底部Tabbar 高度
#define TabBarHeight                   (isIPhoneX ? 83 : 49)
// 状态栏高度
#define StatusBarHeight                (isIPhoneX ? 44 : 20)
// 获取tabbar比之前iPhone的tabbar高出的高度
#define IPhoneXDifferHeight            (isIPhoneX ? 34 : 0)
// 获取StatusBar比之前iPhone的StatusBar高出的高度
#define IPhoneXStatusBarDifferHeight   (isIPhoneX ? 24 : 0)
// 手机全局的leading
#define Leading 16
// 手机全局的trailing
#define Trailing 16


#endif /* DeviceAndSystemMacro_h */
