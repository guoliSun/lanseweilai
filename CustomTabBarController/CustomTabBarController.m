//
//  CustomTabBarController.m
//  CustomTabBarController
//
//  Created by CORYIL on 15/10/15.
//  Copyright (c) 2015年 CORYIL. All rights reserved.
//

#import "CustomTabBarController.h"
#import "SchoolStatusSelectViewController.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface CustomTabBarController ()<UIGestureRecognizerDelegate>
{
    //选中图片
    UIImage *_selectImg;
    
    //标签栏背景图片
    UIImage *_tabBarImg;
    
    NSInteger _index;
    
    NSArray *_parentArr1;
    NSArray *_parentArr2;
    NSArray *_schoolArr1;
    NSArray *_schoolArr2;
}

@end

@implementation CustomTabBarController

-(instancetype)initWithSelectImage:(UIImage *)selectImage
                       tabBarImage:(UIImage *)tabBarImage WithIndex:(NSInteger)index{

    if (self = [super init]) {
        _index = index;
        _selectImg = selectImage;
        _tabBarImg = tabBarImage;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //视图即将出现时 删除原生tabbarbutton
    [self removeTabBarButton];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    SchoolStatusSelectViewController *sssVC = [[SchoolStatusSelectViewController alloc]initWithNibName:@"SchoolStatusSelectViewController" bundle:nil];
    _parentArr1 = @[@"home",@"news",@"contact",@""];
    _schoolArr1 = @[@"news",@"contact",@"checkonwork_school",@"more_school"];
    
    _parentArr2 = @[@"homechecked",@"newschecked",@"contactcheck"];
    _schoolArr2 = @[@"newschecked",@"contactcheck",@"checkonworked_school",@"morechecked_school"];
    /*
     1.去除原生的tabbar上的button
     2.创建新的tabbar添加到self.tabbar上
     3.创建自定义的tabbar button-->子类化
     4.添加button事件,添加选中图片动画
     */
//    [self createTabBar];

}

- (void)setViewControllers:(NSArray *)viewControllers{

    [super setViewControllers:viewControllers];
    
    [self createTabBar];
    //设置视图控制器时 获取个数
    [self createTabBarButton];

}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    
    [super setSelectedIndex:selectedIndex];
    
    NSInteger count = self.viewControllers.count;
    
    [UIView animateWithDuration:.25 animations:^{
        
        _selectedImage.hidden = NO;
        //计算选中图的坐标
        //        [_selectedImage setFrame:CGRectMake(i*(kScreenW/count), 0, kScreenW/count, 45)];
        [_selectedImage setFrame:CGRectMake(selectedIndex*(kScreenW/count)+7, 5, kScreenW/count-14, 40)];
        
    }];
}


#pragma mark 1.移除原生tabbar上的TabBarButton

- (void)removeTabBarButton{

    //获取tabbar上的所有子视图
    for (UIView *subview in self.tabBar.subviews) {
        
        //删除所有的UITabBarButton类的子视图
        //UITabBarButton类无法直接使用,要手动输入字符串,再转化为Class类型
        if ([subview isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            [subview removeFromSuperview];
        }
        
    }

}

#pragma mark 1.创建并添加自定义的TabBar

- (void)createTabBar{

    _customTabBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 49)];
    
    [_customTabBar setBackgroundColor:[UIColor colorWithPatternImage:[_tabBarImg stretchableImageWithLeftCapWidth:1 topCapHeight:20]]];
    
    [self.tabBar addSubview:_customTabBar];

}

#pragma mark 2.创建并添加自定义的TabBarButton

- (void)createTabBarButton{

    //1.获取当前有几个视图控制器
    
    NSInteger itemsCount = self.viewControllers.count;
    
    
    //2.设置选中图片
    
        //(1).创建
    _selectedImage = [[UIImageView alloc]initWithFrame:CGRectMake(0+7, 5, kScreenW/itemsCount-14, 40)];
    
    //缩小选中的图片
//    _selectedImage.transform = CGAffineTransformMakeScale(0.8, 0.8);
    
        //(2).拉伸
    [_selectedImage setImage:[_selectImg stretchableImageWithLeftCapWidth:2 topCapHeight:21]];
    
        //(3).添加
    [_customTabBar addSubview:_selectedImage];
    
    
    
    //3.创建与控制器个数相同数量的tabbarButton
    
    for (int i = 0; i<itemsCount; i++) {
        
        //获取视图控制器
        UIViewController *viewController = [self.viewControllers objectAtIndex:i];
        
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
        UISwipeGestureRecognizer *swipe1 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
        
        //设置轻扫方向
        swipe.direction = UISwipeGestureRecognizerDirectionLeft;
        swipe1.direction = UISwipeGestureRecognizerDirectionRight;
        [viewController.view addGestureRecognizer:swipe];
        [viewController.view addGestureRecognizer:swipe1];
        viewController.view.tag = 1000+i;
        //计算尺寸 + 传入VC的tabBarItem
        CustomTabBarItem *item = [[CustomTabBarItem alloc]initWithFrame:CGRectMake((kScreenW/itemsCount)*i, 0, kScreenW/itemsCount, 49) tabbarItem:viewController.tabBarItem];
        
        //添加事件
        [item addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
        //设置tag值
        item.tag = 100+i;
        //添加到自定义的tabbar上
        [_customTabBar addSubview:item];
    }
    
}

- (void)swipeAction:(UISwipeGestureRecognizer *)swipe{
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        //1.切换视图控制器
        self.selectedIndex = [swipe view].tag-1000 + 1;
        if (_index == 0) {
            for (int i = 0; i < _parentArr1.count; i++) {
                CustomTabBarItem *item1= (CustomTabBarItem *)[_customTabBar viewWithTag:100+i];
                item1.imageView.image = [UIImage imageNamed:_parentArr1[i]];
            }
            if ([swipe view].tag-1000 < 2) {
                CustomTabBarItem *item= (CustomTabBarItem *)[_customTabBar viewWithTag:[swipe view].tag-1000 + 100 + 1];
                item.imageView.image = [UIImage imageNamed:_parentArr2[[swipe view].tag-1000 + 1]];
            }
        }else{
            if (_index == 1) {
                for (int i = 0; i < _schoolArr1.count; i++) {
                    CustomTabBarItem *item1= (CustomTabBarItem *)[_customTabBar viewWithTag:100+i];
                    item1.imageView.image = [UIImage imageNamed:_schoolArr1[i]];
                }
                if ([swipe view].tag-1000 < 3) {
                    CustomTabBarItem *item= (CustomTabBarItem *)[_customTabBar viewWithTag:[swipe view].tag-1000 + 100 + 1];
                    item.imageView.image = [UIImage imageNamed:_schoolArr2[[swipe view].tag-1000 + 1]];
                }
            }
        }
    }

    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        //1.切换视图控制器
        self.selectedIndex = [swipe view].tag-1000 - 1;
        if (_index == 0) {
            for (int i = 0; i < _parentArr1.count; i++) {
                CustomTabBarItem *item1= (CustomTabBarItem *)[_customTabBar viewWithTag:100+i];
                item1.imageView.image = [UIImage imageNamed:_parentArr1[i]];
            }
            if ([swipe view].tag-1000 > 0) {
                CustomTabBarItem *item= (CustomTabBarItem *)[_customTabBar viewWithTag:[swipe view].tag-1000 + 100 - 1];
                item.imageView.image = [UIImage imageNamed:_parentArr2[[swipe view].tag-1000 - 1]];
            }
        }else{
            if (_index == 1) {
                for (int i = 0; i < _schoolArr1.count; i++) {
                    CustomTabBarItem *item1= (CustomTabBarItem *)[_customTabBar viewWithTag:100+i];
                    item1.imageView.image = [UIImage imageNamed:_schoolArr1[i]];
                }
                if ([swipe view].tag-1000 > 0) {
                    CustomTabBarItem *item= (CustomTabBarItem *)[_customTabBar viewWithTag:[swipe view].tag-1000 + 100 - 1];
                    item.imageView.image = [UIImage imageNamed:_schoolArr2[[swipe view].tag-1000 - 1]];
                }
            }
        }
    }
}




//点击事件

- (void)selectItem:(CustomTabBarItem *)sender{

    //1.切换视图控制器
    self.selectedIndex = sender.tag-100;
    if (_index == 0) {
        for (int i = 0; i < _parentArr1.count; i++) {
            CustomTabBarItem *item1= (CustomTabBarItem *)[_customTabBar viewWithTag:100+i];
            item1.imageView.image = [UIImage imageNamed:_parentArr1[i]];
        }
        sender.imageView.image = [UIImage imageNamed:_parentArr2[sender.tag - 100]];
    }else{
        if (_index == 1) {
            for (int i = 0; i < _schoolArr1.count; i++) {
                CustomTabBarItem *item1= (CustomTabBarItem *)[_customTabBar viewWithTag:100+i];
                item1.imageView.image = [UIImage imageNamed:_schoolArr1[i]];
            }
            sender.imageView.image = [UIImage imageNamed:_schoolArr2[sender.tag - 100]];
        }
    }

}

@end

#pragma mark -----------------CustomTabBarItem----------------------------------

@implementation CustomTabBarItem

//子类化的TabBarItem

-(id)initWithFrame:(CGRect)frame tabbarItem:(UITabBarItem *)item{


    if (self = [super initWithFrame:frame]) {
        
        //创建大小为19*20的item图片
         _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-19)/2, 8, 19, 20)];
        
        //设置图片内容模式 防止被拉伸
        _imageView.contentMode = UIViewContentModeCenter;
        
        //设置图片
        _imageView.image = item.image;
        
        /*__________________________________________________________________________*/
        
        //label
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageView.frame.origin.y+_imageView.frame.size.height, frame.size.width, 20)];
        
        label.text = item.title;
        
        label.backgroundColor = [UIColor clearColor];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.textColor = [UIColor whiteColor];
        
        label.font = [UIFont systemFontOfSize:11];
        
        //根据item的图片和标题信息 决定是否添加标题
        
        if (item.title) {
            
            [self addSubview:_imageView];
            
            [self addSubview:label];
            _imageView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        }else{
        
            _imageView.frame = CGRectMake((frame.size.width-40)/2, 5, 40, 40);
            
            //缩小我们的按钮图片
            _imageView.transform = CGAffineTransformMakeScale(0.5, 0.5);
            
            [self addSubview:_imageView];
        
        }
    }
    
    return self;
}
@end










