//
//  LSJPickerViewViewController.m
//  LSJProject
//
//  Created by Joy on 2021/5/9.
//  Copyright © 2021年 Joy. All rights reserved.
//

#import "LSJPickerViewViewController.h"
#import "LSJPickerView.h"

@interface LSJPickerViewViewController ()

@property (nonatomic, strong)UIButton *tap1;

@property (nonatomic, assign)NSInteger currentSelectIndex;

@end

@implementation LSJPickerViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(80, 140, 70, 30)];
    [button setTitle:@"弹出框" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    _tap1 = button;
}

- (void)buttonAction {
    [LSJPickerView showPickerWithTitle:@"试试"
                         dataSourceArr:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"]
                           selectIndex:_currentSelectIndex ? : 0
                           cancelTitle:@""
                           cancelBlock:^(NSString * _Nonnull selectString, NSInteger currentSelectIndex) {
                               
                           } confirmBlock:^(NSString * _Nonnull selectString, NSInteger currentSelectIndex) {
                               self.currentSelectIndex = currentSelectIndex;
                               [self->_tap1 setTitle:selectString forState:UIControlStateNormal];
                           }];
}

@end
