//
//  SetUpTableViewCell.m
//  HomeSchool
//
//  Created by Ba by on 16/8/19.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "SetUpTableViewCell.h"

@implementation SetUpTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(SetUpModel *)model{
    
    _model = model;
    _logoImage.image = model.logoImage;
    _titleLabel.text = model.titleLabel;
    _selectLabel.text = model.selectLabel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
