//
//  CommonUseMacro.h
//  LSJProject
//
//  Created by Joy on 2021/5/22.
//  Copyright © 2021年 Joy. All rights reserved.
//

// 常用的宏

#ifndef CommonUseMacro_h
#define CommonUseMacro_h


// LOG
#ifdef DEBUG
//#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#   define DLog(FORMAT, ...) fprintf(stderr,"%s:%d\t  %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#   define DLog(...)
#endif


// 强弱引用
#define WeakType(type)             __weak typeof(type) weak##type = type;
#define StrongType(type)           __strong typeof(weak##type) strong##type = weak##type;
#define WeakSelf                   __weak typeof(self) weakSelf = self;
#define StrongSelf                 __strong typeof(weakSelf) strongSelf = weakSelf;

// 常用系统API调用
#define LSJImageName(name)         [UIImage imageNamed:name]
#define LSJFont(s)                 [UIFont systemFontOfSize:s]
#define LSJBoldFont(s)             [UIFont boldSystemFontOfSize:s]

//提示框
#define showMessage(TITLE,MESSAGE)\
UIAlertController *alertController = \
[UIAlertController alertControllerWithTitle:TITLE message:MESSAGE preferredStyle:UIAlertControllerStyleAlert];\
[alertController addAction:[UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:nil]];\
[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];

#endif /* CommonUseMacro_h */
