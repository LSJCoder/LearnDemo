//
//  LSJPickerView.h
//  LSJProject
//
//  Created by Joy on 2021/5/9.
//  Copyright © 2021年 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CancelBlock)(NSString *selectString, NSInteger currentSelectIndex);
typedef void(^ConfirmBlock)(NSString *selectString, NSInteger currentSelectIndex);

@interface LSJPickerView : UIView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic,copy) NSArray *dataSourceArr;

@property (nonatomic,assign) NSInteger selectIndex;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *cancelTitle;

@property (nonatomic,copy) CancelBlock cancelBlock;

@property (nonatomic,copy) ConfirmBlock confirmBlock;

+ (void)showPickerWithTitle:(NSString *)title
              dataSourceArr:(NSArray *)dataSourceArr
                selectIndex:(NSInteger)selectIndex
                cancelTitle:(NSString *)cancelTitle
                cancelBlock:(CancelBlock)cancalBlock
               confirmBlock:(ConfirmBlock)confirmBlock;

@end

NS_ASSUME_NONNULL_END
