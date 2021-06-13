//
//  LSJTestDemoViewController.m
//  LSJProject
//
//  Created by Joy on 2021/5/22.
//  Copyright © 2021年 Joy. All rights reserved.
//

#import "LSJTestDemoViewController.h"
#import "LSJMineLiseModel.h"

static CGFloat const CellHeight = 44;

@interface LSJTestDemoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *titles;

@property (nonatomic, copy) NSArray *controllers;

@property (nonatomic, strong) NSMutableArray<LSJMineLiseModel *> *testDemoModels;

@end

@implementation LSJTestDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

#pragma mark - UI

- (void)createUI {
    WeakSelf
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

#pragma mark - Data

- (void)createData {
    self.controllers = @[
                         @"LSJListViewViewController",
                         @"LSJPickerViewViewController",
                         @"LSJLineChartViewController"
                         ];
    
    self.titles = @[
                    @"实现任何位置下拉列表",
                    @"简单底部pickerView实现",
                    @"折线波浪图的实现"
                    ];
    
    for (int i = 0; i < self.titles.count; i++) {
        NSString *title = self.titles[i];
        NSString *controllerString = self.controllers[i];
        
        LSJMineLiseModel *model = LSJMineLiseModel.new;
        model.title = title;
        model.controllerString = controllerString;
        
        [self.testDemoModels addObject:model];
    };
    
    [self.tableView reloadData];
}


#pragma mark - DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.testDemoModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    LSJMineLiseModel *model = self.testDemoModels[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}

#pragma mark - Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LSJMineLiseModel *model = self.testDemoModels[indexPath.row];
    UIViewController *vc = (UIViewController *)[[NSClassFromString(model.controllerString) alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = model.title;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - setter



#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 200;
        [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    return _tableView;
}

- (NSMutableArray<LSJMineLiseModel *> *)testDemoModels {
    if (!_testDemoModels) {
        _testDemoModels = NSMutableArray.new;
    }
    return _testDemoModels;
}

@end
