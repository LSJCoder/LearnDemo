//
//  LSJSelectListView.h
//  LSJProject
//
//  Created by Joy on 2021/5/9.
//  Copyright © 2021年 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HideBlock)(void);
typedef void(^SelectBlock)(NSString *selectString, NSInteger selectIndex);

@interface LSJSelectListView : UIView
@property (nonatomic,copy) HideBlock hideBlock;
@property (nonatomic,copy) SelectBlock selectBlock;
@property (nonatomic,copy) NSArray *array;
@property (nonatomic,strong) UIColor *maskViewBackgroundColor;
@property (nonatomic,assign) CGFloat listViewLeftAndRightMargin;
@property (nonatomic,assign) CGFloat topY;
@property (nonatomic,assign) CGFloat selectIndex;

// 其中一种定制，还可以根据属性定制其他的
+ (void)createViewWithArray:(NSArray *)array
                       topY:(CGFloat)topY
                selectIndex:(CGFloat)selectIndex
    maskViewBackgroundColor:(UIColor *)maskViewBackgroundColor
 listViewLeftAndRightMargin:(CGFloat)listViewLeftAndRightMargin
                selectBlock:(SelectBlock)selectBlock;

// 注意：一定要在属性赋值完后调用
- (void)show;
@end

NS_ASSUME_NONNULL_END
