//
//  LSJLineChartView.m
//  LSJProject
//
//  Created by Joy on 2021/5/12.
//  Copyright © 2021年 Joy. All rights reserved.
//

#import "LSJLineChartView.h"
#import "UIBezierPath+LSJ.h"

@interface LSJLineChartView()<CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *lineChartLayer;

@end

@implementation LSJLineChartView {
    CGFloat width;
    CGFloat height;
}

static CGFloat edgeLeft = 30;
static CGFloat edgeRight = 20;

static CGFloat edgeUp = 50;
static CGFloat edgeDown = 30;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        width = frame.size.width - edgeLeft - edgeRight;
        height = frame.size.height - edgeUp - edgeDown;
    }
    return self;
}
// 画出坐标轴
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGContextSetRGBStrokeColor(context, 0.6, 0.6, 0.6, 1);
    CGContextMoveToPoint(context, edgeLeft, edgeUp);
    CGContextAddLineToPoint(context, edgeLeft, edgeUp + height);
    CGContextAddLineToPoint(context,edgeLeft + width, edgeUp + height);
    CGContextStrokePath(context);
}


#pragma mark 画折线图
- (void)dravLine{
    
    NSInteger yearNum = self.titleForXArr.count;
    if (yearNum <= 0) {
        return;
    }
    CGFloat widthForX = width / yearNum;
    CGFloat maxValue = [[self.titleForYArr lastObject] floatValue];
    
    if (maxValue <= 0) {
        return;
    }
    
    UIBezierPath *pathLine = [[UIBezierPath alloc] init];
    [pathLine moveToPoint:CGPointMake(edgeLeft + widthForX * 0.5, ((maxValue - [self.valueArr[0] floatValue]) / maxValue) * height + edgeUp)];
    
    // 创建折线点标记
    CGPoint pointCenter;
    for (NSInteger i = 1; i < self.valueArr.count; i++) {
        
        pointCenter = CGPointMake(edgeLeft + widthForX * (i + 0.5), (maxValue - [self.valueArr[i] floatValue]) / maxValue * height + edgeUp);
        
        [pathLine addLineToPoint:pointCenter];
    }
    // 实现波浪线
    pathLine = [pathLine smoothedPathWithGranularity:20];
    
    [pathLine addLineToPoint:CGPointMake(edgeLeft + width - widthForX * 0.5, height + edgeUp)];
    [pathLine addLineToPoint:CGPointMake(edgeLeft + widthForX * 0.5, height + edgeUp)];
    
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(edgeLeft, edgeUp, width, height);
    gradientLayer.colors = @[(id)[UIColor blueColor].CGColor, (id)[UIColor whiteColor].CGColor];
    gradientLayer.locations = @[@(0.0), @(1)];
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    [self.layer addSublayer:gradientLayer];
    
//    CAShapeLayer * lineLayer = [CAShapeLayer layer];
//    lineLayer.strokeColor = [UIColor redColor].CGColor;
//    lineLayer.fillColor = nil;
//    lineLayer.path = pathLine.CGPath;
//    lineLayer.lineJoin = kCALineJoinRound;
//    lineLayer.lineCap = kCALineCapRound;
//    [self.layer addSublayer:lineLayer];
    
//    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
//    shapeLayer.anchorPoint = CGPointMake(1, 0.5);
//    shapeLayer.strokeColor = [UIColor redColor].CGColor;
//    shapeLayer.fillColor = [UIColor redColor].CGColor;
//    shapeLayer.path = pathLine.CGPath;
//    shapeLayer.lineJoin = kCALineJoinRound;
//    shapeLayer.lineCap = kCALineCapRound;
////    shapeLayer.opacity = _opacity;
//    self.layer.mask = shapeLayer;
    
    
    CAShapeLayer  *lineChartLayer = [CAShapeLayer layer];
    lineChartLayer.path = pathLine.CGPath;
    lineChartLayer.strokeColor = _lineColor.CGColor;
    lineChartLayer.fillColor = [UIColor greenColor].CGColor;
    lineChartLayer.lineWidth = 2.0;
    lineChartLayer.lineCap = kCALineCapRound;
    lineChartLayer.lineJoin = kCALineJoinBevel;
    lineChartLayer.lineDashPhase = 5.0;
    lineChartLayer.miterLimit = 10.0;
    
    self.layer.mask = lineChartLayer;
//    [self.layer addSublayer:lineChartLayer];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(edgeLeft + widthForX * 0.5 - 1, edgeUp + height - 2, width - widthForX, 5)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(pointCenter.x - 1,pointCenter.y, 2, edgeUp + height - pointCenter.y + 2)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
}

#pragma mark 创建x轴的数据
- (void)setTitleForXArr:(NSArray *)titleForXArr {
    _titleForXArr = titleForXArr;
    [self createLabelX];
}
- (void)createLabelX{
    
    NSInteger yearNum = self.titleForXArr.count;
    if (yearNum <= 0) {
        return;
    }
    CGFloat widthForX = width / yearNum;
    
    for (NSInteger i = 0; i < yearNum; i++) {
        if (i == 0 || i == yearNum - 1) {
            UILabel *labelYear = [[UILabel alloc] initWithFrame:CGRectMake(edgeLeft + widthForX * i, height + edgeUp, 100, edgeDown)];
            labelYear.tag = 1000 + i;
            labelYear.text = self.titleForXArr[i];
            labelYear.font = [UIFont systemFontOfSize:14];
            labelYear.textAlignment = NSTextAlignmentCenter;
            [labelYear sizeToFit];
            [self addSubview:labelYear];
            [self insertSubview:labelYear atIndex:0];
        }
        
    }
}
#pragma mark 创建y轴数据及虚线
- (void)setTitleForYArr:(NSArray *)titleForYArr {
    _titleForYArr = titleForYArr;
    [self createLabelY];
//    [self setLineDash];
}
- (void)createLabelY{
    
    NSInteger numForY = _titleForYArr.count;
    if (numForY <= 1) {
        return;
    }
    CGFloat widthForY = edgeLeft;
    CGFloat heightForY = height / (numForY - 1);
    
    for (NSInteger i = 0; i < numForY; i++) {
        
        UILabel *labelForY = [[UILabel alloc] initWithFrame:CGRectMake(0, edgeUp + (i - 0.5) * heightForY, widthForY, heightForY)];
        
        labelForY.tag = 2000 + i;
        labelForY.text = _titleForYArr[numForY - i - 1];
        labelForY.font = [UIFont systemFontOfSize:12];
        labelForY.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labelForY];
    }
}
#pragma mark - 添加虚线
- (void)setLineDash {
    
    NSInteger numForY = _titleForYArr.count - 1;
    if (numForY <= 0) {
        return;
    }
    CGFloat heightForY = height / numForY;
    
    for (NSInteger i = 0; i < numForY; i++) {
        
        CAShapeLayer *dashLayer = [CAShapeLayer layer];
        dashLayer.strokeColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1].CGColor;
        dashLayer.lineWidth = 1.0;
        
        UIBezierPath *path = [[UIBezierPath alloc] init];
        path.lineWidth = 1.0;
        
        [path moveToPoint:CGPointMake(edgeLeft, edgeUp + i * heightForY)];
        [path addLineToPoint:CGPointMake(edgeLeft + width, edgeUp + i * heightForY)];
        CGFloat dash[] = {10,10};
        [path setLineDash:dash count:2 phase:10];
        [path stroke];
        dashLayer.path = path.CGPath;
        [self.layer addSublayer:dashLayer];
    }
}
#pragma mark - 开始画折线
- (void)startDraw {
    [self dravLine];
}

@end
