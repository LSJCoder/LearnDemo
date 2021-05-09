//
//  LSJExampleListViewController.m
//  LSJProject
//
//  Created by Joy on 2021/5/9.
//  Copyright © 2021年 Joy. All rights reserved.
//

#import "LSJExampleListViewController.h"


static NSString * const kLSJCellReuseIdentifier = @"kLSJCellReuseIdentifier";

@interface LSJExampleListViewController ()

@property (nonatomic, strong) NSArray *exampleControllers;

@property (nonatomic, strong) NSArray *exampleControllersTitles;

@end

@implementation LSJExampleListViewController

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    self.title = @"Examples";
    
    self.exampleControllers = @[
                      @"LSJListViewViewController",
                      @"LSJPickerViewViewController"
                      ];
    
    self.exampleControllersTitles = @[
                                @"实现任何位置下拉列表",
                                @"简单底部pickerView实现"
                                ];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:kLSJCellReuseIdentifier];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.exampleControllers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *controllerTitle = self.exampleControllersTitles[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLSJCellReuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = controllerTitle;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *controllerString = self.exampleControllers[indexPath.row];
    UIViewController *viewController = (UIViewController *)[[NSClassFromString(controllerString) alloc] init];
    viewController.title = self.exampleControllersTitles[indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
