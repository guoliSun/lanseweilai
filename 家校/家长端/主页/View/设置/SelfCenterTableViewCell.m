//
//  SelfCenterTableViewCell.m
//  HomeSchool
//
//  Created by Ba by on 16/8/22.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "SelfCenterTableViewCell.h"
@interface SelfCenterTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@end

@implementation SelfCenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(SelfCenterModel *)model{
    _model = model;
    
    if (_model.userimage) {
        _userImage.image = _model.userimage;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
