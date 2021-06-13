//
//  LSJPickerView.m
//  LSJProject
//
//  Created by Joy on 2021/5/9.
//  Copyright © 2021年 Joy. All rights reserved.
//

#import "LSJPickerView.h"
#import "Masonry.h"

static CGFloat const viewHeight = 300;
static CGFloat const topViewHeight = 40;
static CGFloat const cancelAndConfirmWidth = 100;

@interface LSJPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIButton *bgButton;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIView *cycanView;

@property (nonatomic, strong) UIPickerView *selectPickerView;

@property (nonatomic, copy) NSString *selectStr;

@property (nonatomic, assign) NSInteger currentSelectIndex;

@end

@implementation LSJPickerView

+ (void)showPickerWithTitle:(NSString *)title
              dataSourceArr:(NSArray *)dataSourceArr
                selectIndex:(NSInteger)selectIndex
                cancelTitle:(NSString *)cancelTitle
                cancelBlock:(CancelBlock)cancalBlock
               confirmBlock:(ConfirmBlock)confirmBlock {
    LSJPickerView *pickerView = [[LSJPickerView alloc] init];
    pickerView.title = title;
    pickerView.dataSourceArr = dataSourceArr;
    pickerView.selectIndex = selectIndex;
    pickerView.cancelTitle = cancelTitle;
    pickerView.cancelBlock = cancalBlock;
    pickerView.confirmBlock = confirmBlock;
    [pickerView show];
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUI];
        [self layout];
    }
    return self;
}

- (void)setUI {
    self.backgroundColor = [UIColor clearColor];
    
    UIButton *bgButton = [[UIButton alloc] init];
    bgButton.backgroundColor = [UIColor clearColor];
    [bgButton addTarget:self action:@selector(bgButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgButton];
    _bgButton = bgButton;
    
    UIView *containerView = [[UIView alloc] init];
    [self addSubview:containerView];
    containerView.layer.masksToBounds = YES;
    _containerView = containerView;
    
    UIView *cycanView = [[UIView alloc] init];
    cycanView.backgroundColor = [UIColor orangeColor];
    [containerView addSubview:cycanView];
    _cycanView = cycanView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [cycanView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    UIButton *cancelButton = [[UIButton alloc] init];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cycanView addSubview:cancelButton];
    _cancelButton = cancelButton;
    
    UIButton *confirmButton = [[UIButton alloc] init];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cycanView addSubview:confirmButton];
    _confirmButton = confirmButton;
    
    UIPickerView *selectPickerView = [[UIPickerView alloc] init];
    selectPickerView.backgroundColor = [UIColor whiteColor];
    selectPickerView.showsSelectionIndicator = NO;
    selectPickerView.delegate = self;
    selectPickerView.dataSource = self;
    selectPickerView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    [containerView addSubview:selectPickerView];
    _selectPickerView = selectPickerView;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
}

- (void)layout {
    __weak typeof(self) weakSelf = self;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.mas_offset(0);
    }];
    [_bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.bottom.equalTo(weakSelf.containerView.mas_top);
    }];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_equalTo(viewHeight);
    }];
    [_cycanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_offset(0);
        make.height.mas_equalTo(topViewHeight);
    }];
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(0);
        make.width.mas_equalTo(cancelAndConfirmWidth);
        make.height.equalTo(weakSelf.cycanView.mas_height);
    }];
    [_confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_offset(0);
        make.width.mas_equalTo(cancelAndConfirmWidth);
        make.height.equalTo(weakSelf.cycanView.mas_height);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_offset(0);
        make.left.equalTo(weakSelf.cancelButton.mas_right);
        make.right.equalTo(weakSelf.confirmButton.mas_left);
    }];
    [_selectPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.equalTo(weakSelf.cycanView.mas_bottom);
        make.height.mas_equalTo(viewHeight - topViewHeight);
    }];
    
}

- (void)show {
    // 填充
    _titleLabel.text = _title;
    NSString *cancelTitle = ([_cancelTitle isKindOfClass:[NSString class]] && _cancelTitle.length > 0) ? _cancelTitle : @"取消";
    [self.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
    
    // 动画
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    [self layoutIfNeeded];
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(viewHeight);
    }];
    
    // 滑动到指定位置
    [self.selectPickerView selectRow:self.selectIndex inComponent:0 animated:NO];
    [self didSelectActionWithSelectIndex:self.selectIndex];
    
    // 更新
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [weakSelf layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    __weak typeof(self) weakSelf = self;
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.backgroundColor = [UIColor clearColor];
        [weakSelf layoutIfNeeded];
    }completion:^(BOOL finished) {
        __weak typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf removeFromSuperview];
    }];
}

#pragma mark - 隐藏弹框
- (void)bgButtonAction:(UIButton *)sender{
    [self hide];
}

- (void)cancelButtonAction:(UIButton *)sender {
    if (_cancelBlock) {
        _cancelBlock(self.selectStr,_currentSelectIndex);
    }
    [self hide];
}
#pragma mark - 弹框确定按钮
- (void)confirmButtonAction:(UIButton *)sender{
    if (_confirmBlock) {
        _confirmBlock(self.selectStr,_currentSelectIndex);
    }
    [self hide];
}


- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _dataSourceArr.count;
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return CGRectGetWidth(self.bounds);
}

// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self didSelectActionWithSelectIndex:row];
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_dataSourceArr objectAtIndex:row];
}

//重写方法,改变字体大小
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.font = [UIFont systemFontOfSize:14];
        pickerLabel.textColor = [UIColor lightGrayColor];
        pickerLabel.textAlignment = 1;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(pickerView.frame)/2 - 20, CGRectGetWidth(self.bounds), 1.0)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [pickerView addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(pickerView.frame)/2 + 20, CGRectGetWidth(self.bounds), 1.0)];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [pickerView addSubview:lineView2];
    
    return pickerLabel;
}

- (void)didSelectActionWithSelectIndex:(NSInteger)selectIndex {
    self.selectStr = [NSString stringWithFormat:@"%@",[_dataSourceArr objectAtIndex:selectIndex]];
    _currentSelectIndex = selectIndex;
    NSLog(@"selectStr:%@",self.selectStr);
}


@end
