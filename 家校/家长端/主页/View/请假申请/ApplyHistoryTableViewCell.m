//
//  ApplyHistoryTableViewCell.m
//  HomeSchool
//
//  Created by Ba by on 16/8/18.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "ApplyHistoryTableViewCell.h"
@interface ApplyHistoryTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *applyTimeLabel;




@end
@implementation ApplyHistoryTableViewCell

-(void)setModel:(ApplyModel *)model{
    _model = model;
    _applyTimeLabel.text = _model.applyTime;
    _timeLabel.text = [NSString stringWithFormat:@"%@--%@",_model.startTime,_model.endTime];
    if ([_model.state integerValue] == 1) {
        _stateImageView.image = [UIImage imageNamed:@"permitting"];
    }
    if ([_model.state integerValue] == 2) {
        _stateImageView.image = [UIImage imageNamed:@"permitted"];
    }
    if ([_model.state integerValue] == 3) {
        _stateImageView.image = [UIImage imageNamed:@"nopermit"];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _stateImageView.layer.masksToBounds = YES;
    _stateImageView.layer.cornerRadius = 25;
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
