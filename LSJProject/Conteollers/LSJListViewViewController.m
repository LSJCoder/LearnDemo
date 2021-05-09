//
//  LSJListViewViewController.m
//  LSJProject
//
//  Created by Joy on 2021/5/9.
//  Copyright © 2021年 Joy. All rights reserved.
//

#import "LSJListViewViewController.h"
#import "LSJSelectListView.h"

static NSString * const kLSJCellReuseIdentifier = @"kLSJCellReuseIdentifier";
static CGFloat const MagicCellNum = 8;

@interface LSJListViewViewController ()

@property (nonatomic, strong) NSArray *examples;

@property (nonatomic, assign) CGFloat currentSelectIndex;

@end

@implementation LSJListViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.examples = [self getSubjectArray];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:kLSJCellReuseIdentifier];
    
    

}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *example = self.examples[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLSJCellReuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = example;
    if (indexPath.row == MagicCellNum) {
        cell.textLabel.text = @"点我有奇迹！！！！！！！！！！";
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.examples.count;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == MagicCellNum) {
        UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
        CGRect buttonRect = [cell convertRect:cell.bounds toView:window];
        CGFloat topY = CGRectGetMaxY(buttonRect);
        NSArray *testArray = [self getSubjectArray];
        NSInteger selectIndex = _currentSelectIndex > testArray.count ? testArray.count - 1 : _currentSelectIndex;
        __weak typeof(cell) weakCell = cell;
        __weak typeof(self) weakSelf = self;
        [LSJSelectListView createViewWithArray:testArray
                                          topY:topY
                                   selectIndex:selectIndex
                       maskViewBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]
                    listViewLeftAndRightMargin:0
                                   selectBlock:^(NSString * _Nonnull selectString, NSInteger selectIndex) {
                                       __strong typeof(weakCell) strongCell = weakCell;
                                       weakSelf.currentSelectIndex = selectIndex;
                                       strongCell.textLabel.text = selectString;
                                   }];
    }
}

- (NSArray *)getSubjectArray {
    NSMutableArray *array = NSMutableArray.new;
    NSInteger arrayCount = (arc4random() % 256);
    arrayCount = 50;
    for (int i = 0; i < arrayCount; i++) {
        [array addObject:[NSString stringWithFormat:@"科目%d",i + 1]];
    }
    return [array copy];
}


@end
