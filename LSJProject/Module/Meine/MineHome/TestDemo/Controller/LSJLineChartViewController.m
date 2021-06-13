//
//  LSJLineChartViewController.m
//  LSJProject
//
//  Created by Joy on 2021/5/12.
//  Copyright © 2021年 Joy. All rights reserved.
//

#import "LSJLineChartViewController.h"
#import "LSJLineChartView.h"

@interface LSJLineChartViewController ()

@end

@implementation LSJLineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    LSJLineChartView *lineView = [[LSJLineChartView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 190)];
    lineView.titleForYArr = @[@"0",@"1",@"2",@"3",@"4",@"5"];
    lineView.titleForXArr = @[@"2013年",@"",@"",@"",@"",@"",@"",@"",@"2017年",@"",@"",@"",@"",@"",@"",@"",@"2017年",@"",@"",@"",@"",@"",@"",@"",@"2017年",@"",@"",@"",@"",@"",@"",@"",@"2017年",@"",@"",@"",@"",@"",@"",@"",@"2017年"];
    lineView.valueArr = @[@"0.8",@"1.9",@"4.0",@"1.3",@"2.5",@"1.9",@"4.0",@"1.3",@"2.5",@"1.9",@"4.0",@"1.3",@"2.5",@"1.9",@"4.0",@"1.3",@"2.5",@"1.9",@"4.0",@"1.3",@"2.5",@"1.9",@"4.0",@"1.3",@"2.5",@"1.9",@"4.0",@"1.3",@"2.5",@"1.9",@"4.0",@"1.3",@"2.5",@"1.9",@"4.0",@"1.3",@"2.5",@"1.9",@"4.0",@"1.3",@"2.5"];
    
    lineView.lineColor = [UIColor redColor];
    [self.view addSubview:lineView];
    
    [lineView startDraw];
    lineView.titleForYArr = @[@"0",@"1",@"2",@"3",@"4",@"5"];
    lineView.titleForXArr = @[@"2013年",@"",@"",@"",@"",@"",@"",@"",@"2017年",@"",@"",@"",@"",@"",@"",@"",@"2017年",@"",@"",@"",@"",@"",@"",@"",@"2017年",@"",@"",@"",@"",@"",@"",@"",@"2017年",@"",@"",@"",@"",@"",@"",@"",@"2017年"];
    lineView.valueArr = @[@"0.8",@"1.9",@"4.0",@"1.3",@"2.5",@"1.9",@"4.0",@"1.3",@"2.5",@"1.9",@"4.0",@"1.3",@"2.5",@"1.9",@"4.0",@"1.3",@"2.5",@"1.9",@"4.0",@"1.3",@"2.5",@"1.9",@"4.0",@"1.3",@"2.5",@"1.9",@"4.0",@"1.3",@"2.5",@"1.9",@"4.0",@"1.3",@"2.5",@"1.9",@"4.0",@"1.3",@"2.5",@"1.9",@"4.0",@"1.3",@"2.5"];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
