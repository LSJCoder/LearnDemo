//
//  LSJMineViewController.m
//  LSJProject
//
//  Created by Joy on 2021/5/22.
//  Copyright © 2021年 Joy. All rights reserved.
//

#import "LSJMineViewController.h"
#import "LSJMineCell.h"
#import "LSJMineListModel.h"

static CGFloat const CellHeight = 44;
static NSString const *VCName = @"VCName";
static NSString const *VCTitle = @"VCTitle";

@interface LSJMineViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *controllerMessages;

@property (nonatomic, strong) NSMutableArray<LSJMineListModel *> *mineListModels;

@end

@implementation LSJMineViewController

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
    self.controllerMessages = @[
                                @{
                                    VCName : @"LSJTestDemoViewController",
                                    VCTitle : @"testDemo"
                                    },
                                @{
                                    VCName : @"LSJCustomEncapsulationController",
                                    VCTitle : @"custom Encapsulation"
                                    },
                                @{
                                    VCName : @"LSJSystemEncapsulationController",
                                    VCTitle : @"system Encapsulation"
                                    },
                                @{
                                    VCName : @"LSJVenderEncapsulationController",
                                    VCTitle : @"vender Encapsulation"
                                    }
                                ];
    
    
    for (int i = 0; i < self.controllerMessages.count; i++) {
        NSDictionary *controllerMessage = self.controllerMessages[i];
        
        LSJMineListModel *model = LSJMineListModel.new;
        model.title = controllerMessage[VCTitle];
        model.controllerString = controllerMessage[VCName];
        
        [self.mineListModels addObject:model];
    };

    [self.tableView reloadData];
}


#pragma mark - DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mineListModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSJMineCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(LSJMineCell.class) forIndexPath:indexPath];
    LSJMineListModel *model = self.mineListModels[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}

#pragma mark - Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LSJMineListModel *model = self.mineListModels[indexPath.row];
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
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(LSJMineCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(LSJMineCell.class)];
    }
    return _tableView;
}

- (NSMutableArray<LSJMineListModel *> *)mineListModels {
    if (!_mineListModels) {
        _mineListModels = NSMutableArray.new;
    }
    return _mineListModels;
}

@end

