//
//  AddressListInfoTableViewCell.m
//  HomeSchool
//
//  Created by Ba by on 16/8/19.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "AddressListInfoTableViewCell.h"

@implementation AddressListInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(AddressListInfoModel *)model{
    _logImageView.image = model.logoImage;
    _nameLabel.text = model.titleLabel;
    _infoLabel.text = model.infoLabel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
