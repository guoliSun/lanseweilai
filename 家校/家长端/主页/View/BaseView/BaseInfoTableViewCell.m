//
//  BaseInfoTableViewCell.m
//  HomeSchool
//
//  Created by Ba by on 16/8/17.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "BaseInfoTableViewCell.h"
@interface BaseInfoTableViewCell()
{

}
@end
@implementation BaseInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _timeLabel.layer.masksToBounds = YES;
    _timeLabel.layer.cornerRadius = 5;
    _infoImageView.layer.masksToBounds = YES;
    _infoImageView.layer.cornerRadius = 5;
    _bgView.layer.borderWidth = 0.5;
    _bgView.layer.borderColor = [[UIColor colorWithRed:0.8 green:0.81 blue:0.81 alpha:1]CGColor];
}

- (void)setModel:(NotifyModel *)model{
    _model = model;
    _titleLabel.text = _model.titleName;
    NSArray  *array= [model.timeString componentsSeparatedByString:@" "];
    NSArray *month = [array[0] componentsSeparatedByString:@"-"];
    NSArray *time = [array[1] componentsSeparatedByString:@":"];
    NSString *timeString = [NSString stringWithFormat:@"%d月%d日 %d:%d",[month[1] intValue],[month[2] intValue],[time[0] intValue],[time[1] intValue]];
    _timeLabel.text = timeString;

    
   // [_infoImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:ImageURL,model.imageName]]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
