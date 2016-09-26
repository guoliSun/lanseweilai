//
//  SetUpTableViewCell.h
//  HomeSchool
//
//  Created by Ba by on 16/8/19.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetUpModel.h"
@interface SetUpTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectLabel;
@property (nonatomic,strong)SetUpModel *model;
@end
