//
//  LSJLineChartView.h
//  LSJProject
//
//  Created by Joy on 2021/5/12.
//  Copyright © 2021年 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSJLineChartView : UIView

@property (nonatomic, strong) NSArray *titleForYArr;

@property (nonatomic, strong) NSArray *titleForXArr;

@property (nonatomic, strong) NSArray *valueArr;

@property (nonatomic, strong) UIColor *lineColor;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)startDraw;


@end

NS_ASSUME_NONNULL_END
