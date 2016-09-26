//
//  HomeViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/16.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "HomeViewController.h"
#import "NotifyViewController.h"//通知公告
#import "ARecordViewController.h"//考勤
#import "AskLeaveViewController.h"//请假申请
#import "SetUpViewController.h"//设置
#import "ExerciseViewController.h"
#import "WeekFoodViewController.h"//每周食谱
@interface HomeViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIView *_home_topView;//顶部的view
    UIImageView *_home_userImageView;//用户头像
    UILabel *_home_userName;//用户名称
    UIImageView *_home_schoolImageView;//学校名称图片
    UILabel*_home_schoolName;//学校名称
    UIImageView *_home_classImageView;//班级图片
    UILabel*_home_className;//班级
    UIView *_home_bannerView;//留个模块的view
    UICollectionView *_home_banner_collertionView;
    
}
@end

@implementation HomeViewController
static NSString *identifier = @"collection_cell";

- (instancetype)init{
    
    if (self = [super init]) {
        
        //设置控制器的 题目(导航栏) 标签图片(标签栏)
        self.title = @"主页";
        self.tabBarItem.image = [UIImage imageNamed:@"homechecked"];
        self.tabBarItem.title = @"主页";
        self.navigationController.navigationBarHidden = NO;
    }
    return self;
    
}


- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    [self createUserInfo];
    [self createBanner];
    [self createBottomLogo];
}

- (void)viewWillDisappear:(BOOL)animated{
    for(UIView *view in [self.view subviews])
    {
        [view removeFromSuperview];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor colorWithRed:0.941 green:0.945 blue:0.952 alpha:1];
    
    // Do any additional setup after loading the view.
}

#pragma mark ----头部用户信息
- (void)createUserInfo{
    
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfoDic = [accountDefaults objectForKey:@"userInfo"];
    NSDictionary *studentDic = [accountDefaults objectForKey:@"studentInfo"];
    
    _home_topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 107)];
    _home_topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_home_topView];
    
    //用户头像
    _home_userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(25 * ScaleWidth, 17.5, 72, 72)];
    _home_userImageView.image = [UIImage imageNamed:@"home_userimage"];
    _home_userImageView.layer.masksToBounds = YES;
    // [_home_userImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:ImageURL,[userInfoDic objectForKey:@"icon"]]]];
    _home_userImageView.layer.borderColor = [[UIColor blueColor] CGColor];
    _home_userImageView.layer.cornerRadius = 36;
    [_home_topView addSubview:_home_userImageView];
    
    //用户姓名
    _home_userName = [[UILabel alloc]initWithFrame:CGRectMake(95 + 20 * ScaleWidth, 32, 70, 20)];
    _home_userName.text = [studentDic objectForKey:@"studentName"];
    _home_userName.font = [UIFont systemFontOfSize:16 weight:5];
    _home_userName.textColor = [UIColor colorWithRed:0.26 green:0.75 blue:1 alpha:1];
    [_home_topView addSubview:_home_userName];
    
    //学校图片
    _home_schoolImageView = [[UIImageView alloc]initWithFrame:CGRectMake(92 + 20 * ScaleWidth, _home_userName.bottom + 10, 18, 18)];
    _home_schoolImageView.image = [UIImage imageNamed:@"kindergarten"];
    [_home_topView addSubview:_home_schoolImageView];
    //学校名称
    _home_schoolName = [[UILabel alloc]initWithFrame:CGRectMake(_home_schoolImageView.right , _home_userName.bottom + 10, 90 , 20)];
    _home_schoolName.text = [studentDic objectForKey:@"studentSchool"];
    //_home_schoolName.layer.borderWidth = 1;
    _home_schoolName.font = [UIFont systemFontOfSize:14];
    _home_schoolName.textColor = [UIColor colorWithRed:0.49 green:0.49 blue:0.49 alpha:1];
    [_home_topView addSubview:_home_schoolName];
    
    //班级图片
    _home_classImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_home_schoolName.right + 5 , _home_userName.bottom + 10, 18, 18)];
    _home_classImageView.image = [UIImage imageNamed:@"class"];
    [_home_topView addSubview:_home_classImageView];
    //班级名称
    _home_className = [[UILabel alloc]initWithFrame:CGRectMake(_home_classImageView.right  , _home_userName.bottom + 10, 100 , 20)];
    _home_className.text = [studentDic objectForKey:@"studentClass"];
    _home_className.textColor = [UIColor colorWithRed:0.49 green:0.49 blue:0.49 alpha:1];
    _home_className.font = [UIFont systemFontOfSize:14];
    [_home_topView addSubview:_home_className];
    
}

#pragma mark ----创建中间的6个模块
- (void)createBanner{
    _home_bannerView = [[UIView alloc]initWithFrame:CGRectMake(0, 117 + 64, kScreenWidth, 174 * ScaleHeight)];
    _home_bannerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_home_bannerView];
    
    //创建collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kScreenWidth / 3 , 174 / 2 * ScaleHeight);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _home_banner_collertionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 174  * ScaleHeight) collectionViewLayout:layout];
    _home_banner_collertionView.backgroundColor = [UIColor whiteColor];
    _home_banner_collertionView.dataSource = self;
    _home_banner_collertionView.delegate = self;
    [_home_banner_collertionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    [_home_bannerView addSubview:_home_banner_collertionView];
}

#pragma mark ----创建底部的图片
- (void)createBottomLogo{
    UIImageView *bottomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _home_bannerView.bottom + 10 * ScaleHeight, kScreenWidth, kScreenHeight - (_home_bannerView.bottom + 10 * ScaleHeight))];
    [self.view addSubview:bottomImageView];
    bottomImageView.image = [UIImage imageNamed:@"home_bottom_image"];
}
#pragma mark ----collectionViewDataSouce
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}
//单元格内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //使用注册的单元格类 创建单元格
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    BannerView *bannerView = [[BannerView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    bannerView.index = indexPath.row;
    [cell addSubview:bannerView];
    NSArray *title = @[@"通知公告",@"考勤",@"请假申请",@"每周食谱",@"精彩活动",@"设置"];
    NSArray *imageName = @[@"noticedeclare",@"checkonwork",@"applicationforleave",@"dietmenu",@"excitingactivity",@"setting"];
    bannerView.label.text = title[indexPath.row];
    bannerView.imageView.image = [UIImage imageNamed:imageName[indexPath.row]];
    

    return cell;
}

#pragma mark ----CollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            NotifyViewController *notifyVC = [[NotifyViewController alloc]init];
            [self.navigationController pushViewController:notifyVC animated:YES];
        }
            break;
        case 1:
        {
            ARecordViewController *aRecordVC = [[ARecordViewController alloc]init];
            [self.navigationController pushViewController:aRecordVC animated:YES];
        }
            break;
        case 2:
        {
            AskLeaveViewController *askLeaveVC = [[AskLeaveViewController alloc]init];
            [self.navigationController pushViewController:askLeaveVC animated:YES];
        }
            break;
        case 3:
        {
            WeekFoodViewController *weekFoodVC = [[WeekFoodViewController alloc]init];
            [self.navigationController pushViewController:weekFoodVC animated:YES];
        }
            break;
        case 4:
        {
            ExerciseViewController *eVC = [[ExerciseViewController alloc]init];
            [self.navigationController pushViewController:eVC animated:YES];
        }
            break;
        case 5:
        {
            SetUpViewController *setUpVC = [[SetUpViewController alloc]init];
            [setUpVC setBlock:^(NSInteger index) {
                _block(index);
            }];
            [self.navigationController pushViewController:setUpVC animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

//-------------------BannerView-----------------
@implementation BannerView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setIndex:(NSInteger)index{
    
    if (index == 0) {
        [self createBannerView1];
    }
    if(index == 1){
        [self createBannerView];
    }
    else if (index == 2) {
        [self createBannerView2];
    }else if(index == 3 || index == 4){
        [self createBannerView3];
    }else{
        [self createBannerView4];
    }
}

#pragma mark -----创建单个view
- (void)createBannerView{
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - 32 * ScaleWidth) / 2, 15 * ScaleHeight, 32 * ScaleWidth,  32 * ScaleHeight)];
    [self addSubview:_imageView];
    //_imageView.transform = CGAffineTransformMakeScale(0.5,0.5);
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageView.bottom + 10 * ScaleHeight  , self.frame.size.width, 20)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:14];
    _label.textColor = [UIColor colorWithRed:127 / 255.0 green:127 / 255.0 blue:127 / 255.0 alpha:1];
    [self addSubview:_label];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 0.5)];
    bottomView.backgroundColor = [UIColor colorWithRed:0.25 green:0.7 blue:0.96 alpha:0.5];
    [self addSubview:bottomView];
    
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width, 5, 0.5, self.frame.size.height)];
    leftView.backgroundColor = [UIColor colorWithRed:0.25 green:0.7 blue:0.96 alpha:0.5];
    [self addSubview:leftView];
    
    
}


#pragma mark -----创建第一个view
- (void)createBannerView1{
   _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - 32 * ScaleWidth) / 2, 15 * ScaleHeight, 32 * ScaleWidth,  32 * ScaleHeight)];
    [self addSubview:_imageView];
    //_imageView.transform = CGAffineTransformMakeScale(0.5,0.5);
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageView.bottom + 10 * ScaleHeight, self.frame.size.width, 20)];
    _label.font = [UIFont systemFontOfSize:14];
    _label.textAlignment = NSTextAlignmentCenter;
   _label.textColor = [UIColor colorWithRed:127 / 255.0 green:127 / 255.0 blue:127 / 255.0 alpha:1];
    [self addSubview:_label];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(10, self.frame.size.height, self.frame.size.width - 10, 0.5)];
    bottomView.backgroundColor = [UIColor colorWithRed:0.25 green:0.7 blue:0.96 alpha:0.5];
    [self addSubview:bottomView];
    
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width, 5, 0.5, self.frame.size.height - 5)];
    leftView.backgroundColor = [UIColor colorWithRed:0.25 green:0.7 blue:0.96 alpha:0.5];
    [self addSubview:leftView];
    
    
}


#pragma mark -----创建第三个view
- (void)createBannerView2{
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - 32 * ScaleWidth) / 2, 15 * ScaleHeight, 32 * ScaleWidth,  32 * ScaleHeight)];
    [self addSubview:_imageView];
    //_imageView.transform = CGAffineTransformMakeScale(0.5,0.5);
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageView.bottom + 10 * ScaleHeight, self.frame.size.width, 20)];
    _label.font = [UIFont systemFontOfSize:14];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor colorWithRed:127 / 255.0 green:127 / 255.0 blue:127 / 255.0 alpha:1];
    [self addSubview:_label];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width - 10, 0.5)];
    bottomView.backgroundColor = [UIColor colorWithRed:0.25 green:0.7 blue:0.96 alpha:0.5];
    [self addSubview:bottomView];
    
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width, 0, 0.5, self.frame.size.height)];
    leftView.backgroundColor = [UIColor colorWithRed:0.25 green:0.7 blue:0.96 alpha:0.5];
    [self addSubview:leftView];
    
    
}

#pragma mark -----创建单个view3
- (void)createBannerView3{
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - 32 * ScaleWidth) / 2, 15 * ScaleHeight, 32 * ScaleWidth,  32 * ScaleHeight)];
    [self addSubview:_imageView];
    //_imageView.transform = CGAffineTransformMakeScale(0.5,0.5);
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageView.bottom + 10 * ScaleHeight, self.frame.size.width, 20)];
    _label.font = [UIFont systemFontOfSize:14];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor colorWithRed:127 / 255.0 green:127 / 255.0 blue:127 / 255.0 alpha:1];
    [self addSubview:_label];
    
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width, 0, 0.5, self.frame.size.height - 5)];
    leftView.backgroundColor = [UIColor colorWithRed:0.25 green:0.7 blue:0.96 alpha:0.5];
    [self addSubview:leftView];
    
    
}

#pragma mark -----创建单个view4
- (void)createBannerView4{
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - 32 * ScaleWidth) / 2, 15 * ScaleHeight, 32 * ScaleWidth,  32 * ScaleHeight)];
    [self addSubview:_imageView];
    //_imageView.transform = CGAffineTransformMakeScale(0.5,0.5);
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageView.bottom + 10 * ScaleHeight, self.frame.size.width, 20)];
    _label.font = [UIFont systemFontOfSize:14];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor lightGrayColor];
    _label.textColor = [UIColor colorWithRed:127 / 255.0 green:127 / 255.0 blue:127 / 255.0 alpha:1];
    [self addSubview:_label];
    
    
    
    
}





@end
