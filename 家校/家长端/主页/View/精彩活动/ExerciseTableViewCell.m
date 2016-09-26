//
//  ExerciseTableViewCell.m
//  HomeSchool
//
//  Created by Ba by on 16/8/19.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "ExerciseTableViewCell.h"
@interface ExerciseTableViewCell()

@end
@implementation ExerciseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _timeLabel.layer.masksToBounds = YES;
    _timeLabel.layer.cornerRadius = 5;
    _timeLabel.backgroundColor = [UIColor colorWithRed:0.81 green:0.82 blue:0.82 alpha:1];
    _bgView.layer.borderWidth = 0.5;
    _bgView.layer.borderColor = [[UIColor colorWithRed:0.8 green:0.81 blue:0.81 alpha:1]CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
