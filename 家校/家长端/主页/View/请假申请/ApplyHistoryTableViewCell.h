//
//  ApplyHistoryTableViewCell.h
//  HomeSchool
//
//  Created by Ba by on 16/8/18.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplyModel.h"
@interface ApplyHistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic,strong)ApplyModel *model;

@end
