//
//  UIBezierPath+LSJ.h
//  LSJProject
//
//  Created by Joy on 2021/5/12.
//  Copyright © 2021年 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (LSJ)

- (UIBezierPath *)smoothedPathWithGranularity:(NSInteger)granularity;

@end

NS_ASSUME_NONNULL_END
