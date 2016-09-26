//
//  DaysCollectionViewCell.m
//  DaysSelectDemo
//
//  Created by Ba by on 16/9/5.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "DaysCollectionViewCell.h"

@implementation DaysCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setDay:(NSString *)day{
    if ([day integerValue] != 0) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height - 10)];
        _imageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_imageView];
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = self.frame.size.width / 2 - 5;
        
        _dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height / 2 - 10, self.frame.size.width, 20)];
        _dayLabel.text = day;
        _dayLabel.font = [UIFont systemFontOfSize:16];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_dayLabel];
    }
    
   
    
}

- (void)createImage{
    
}

@end
