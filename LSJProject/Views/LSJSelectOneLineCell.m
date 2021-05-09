//
//  LSJSelectOneLineCell.m
//  LSJProject
//
//  Created by Joy on 2021/5/9.
//  Copyright © 2021年 Joy. All rights reserved.
//

#import "LSJSelectOneLineCell.h"

@interface LSJSelectOneLineCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation LSJSelectOneLineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

- (void)setSelect:(BOOL)select {
    _select = select;
    if (select) {
        _titleLabel.textColor = [UIColor blueColor];
        self.contentView.backgroundColor = [UIColor lightGrayColor];
    } else {
        _titleLabel.textColor = [UIColor grayColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

@end
