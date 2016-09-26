//
//  BaseInfoTableViewCell.h
//  HomeSchool
//
//  Created by Ba by on 16/8/17.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotifyModel.h"
@interface BaseInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *infoImageView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic,strong)NotifyModel *model;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
