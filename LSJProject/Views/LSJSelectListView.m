//
//  LSJSelectListView.m
//  LSJProject
//
//  Created by Joy on 2021/5/9.
//  Copyright © 2021年 Joy. All rights reserved.
//

#import "LSJSelectListView.h"
#import "Masonry.h"
#import "LSJSelectOneLineCell.h"

static const CGFloat maxTableViewHeight = 300;
static const CGFloat oneLineHeight = 44;
static const CGFloat contenInset = 10;

@interface LSJSelectListView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) CGFloat tableViewHeight;

@property (nonatomic, strong) UIView *maskView;


@end

@implementation LSJSelectListView
+ (void)createViewWithArray:(NSArray *)array
                       topY:(CGFloat)topY
                selectIndex:(CGFloat)selectIndex
    maskViewBackgroundColor:(UIColor *)maskViewBackgroundColor
 listViewLeftAndRightMargin:(CGFloat)listViewLeftAndRightMargin
                selectBlock:(SelectBlock)selectBlock {
    LSJSelectListView *listView = [[LSJSelectListView alloc] init];
    listView.array = array;
    listView.topY = topY;
    listView.selectIndex = selectIndex;
    listView.maskViewBackgroundColor = maskViewBackgroundColor;
    listView.listViewLeftAndRightMargin = listViewLeftAndRightMargin;
    listView.selectBlock = selectBlock;
    [listView show];
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
    self.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([UIApplication sharedApplication].keyWindow);
    }];
    
    [self addSubview:self.maskView];
    
    [self.maskView addSubview:self.tableView];
    
    
}

- (void)layout {
    __weak typeof(self) weakSelf = self;
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.maskView);
        make.top.equalTo(weakSelf.maskView.mas_top).with.mas_offset(-contenInset);
        make.height.mas_equalTo(maxTableViewHeight);
    }];
}


#pragma mark - DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSJSelectOneLineCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LSJSelectOneLineCell class]) forIndexPath:indexPath];
    cell.title = _array[indexPath.row];
    cell.select = indexPath.row == _selectIndex;
    return cell;
}

#pragma mark - Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return oneLineHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hide];
    if (self.selectBlock) {
        self.selectBlock(_array[indexPath.row], indexPath.row);
    }
}

#pragma mark - action
- (void)reloadDataWithArray:(NSArray *)array {
    CGFloat height = array.count * oneLineHeight;
    if (height > maxTableViewHeight) {
        height = maxTableViewHeight;
    }
    self.tableViewHeight = height + contenInset;
    
    __weak typeof(self) weakSelf = self;
    [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.tableViewHeight);
    }];
    [self layoutIfNeeded];
    [self.tableView reloadData];
    
}

- (void)show {
    self.hidden = NO;
    __weak typeof(self) weakSelf = self;
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(weakSelf.topY);
        make.height.mas_equalTo([UIApplication sharedApplication].keyWindow.frame.size.height - weakSelf.topY);
    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (weakSelf.listViewLeftAndRightMargin > 0) {
            make.left.right.equalTo(weakSelf.maskView).insets(UIEdgeInsetsMake(0, weakSelf.listViewLeftAndRightMargin, 0, weakSelf.listViewLeftAndRightMargin));
        }
        make.top.mas_equalTo(- weakSelf.tableViewHeight);
    }];
    [self layoutIfNeeded];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.maskView.mas_top).with.mas_offset(-contenInset);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        // 背景颜色
        if (weakSelf.maskViewBackgroundColor) {
            weakSelf.maskView.backgroundColor = weakSelf.maskViewBackgroundColor;
        }
        [weakSelf layoutIfNeeded];
    } completion:^(BOOL finished) {}];
}

- (void)hide {
    __weak typeof(self) weakSelf = self;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(- weakSelf.tableViewHeight);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.maskView.backgroundColor = [UIColor clearColor];
        [weakSelf layoutIfNeeded];
    }completion:^(BOOL finished) {
        weakSelf.hidden = YES;
    }];
}

- (void)tapMaskViewAction:(UITapGestureRecognizer *)tap {
    [self hide];
}

#pragma mark  - getter and setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = false;
        _tableView.estimatedRowHeight = 200;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.contentInset = UIEdgeInsetsMake(contenInset, 0, 0, 0);
        _tableView.layer.cornerRadius = contenInset;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LSJSelectOneLineCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LSJSelectOneLineCell class])];
        
    }
    return _tableView;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = UIView.new;
        _maskView.backgroundColor = [UIColor clearColor];
        _maskView.layer.masksToBounds = YES;
    }
    return _maskView;
}

- (void)setArray:(NSArray *)array {
    _array = array;
    [self reloadDataWithArray:array];
}

#pragma mark  - other
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hide];
    if (self.hideBlock) {
        self.hideBlock();
    }
}

@end
