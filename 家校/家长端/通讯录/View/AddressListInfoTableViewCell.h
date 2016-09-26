//
//  AddressListInfoTableViewCell.h
//  HomeSchool
//
//  Created by Ba by on 16/8/19.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressListInfoModel.h"
@interface AddressListInfoTableViewCell : UITableViewCell
@property (nonatomic ,strong)AddressListInfoModel *model;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logImageView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@end
