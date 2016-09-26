//
//  ParentInviteViewAddViewController.m
//  HomeSchool
//
//  Created by Ba by on 16/8/26.
//  Copyright © 2016年 com.cosinnet. All rights reserved.
//

#import "ParentInviteViewAddViewController.h"
@interface ParentInviteViewAddViewController ()<UIGestureRecognizerDelegate,CNPPopupControllerDelegate>
{
    UIScrollView *_scrollView;
    UITextField *_parentNameTextFiled;//家人姓名
    UILabel *_parentRelation;//家长关系
    UITextField *_phoneTextFiled;//电话号码
    UITextField *_verifyTextFiled;//验证码
    NSMutableArray *_buttonMArr;//存放所有的button按钮
    float _height;
    NSArray *_studenArr;//存放学生列表
}
@property (nonatomic, strong) CNPPopupController *popupController;
@end

@implementation ParentInviteViewAddViewController

-(instancetype)init{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"新增邀请";
        backButton *backBtn = [[backButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        //重新定义返回按钮
        
        [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    return self;
}

- (void)doBack:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _height = 0;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:_scrollView];
    _scrollView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    [self createNameView];
    [self createRelationView];
    [self createPhone];
    [self createAttractStudent];
}
#pragma mark ----家人姓名
- (void)createNameView{
    //1.创建手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    view.backgroundColor = [UIColor whiteColor];
    //图片
    [view addGestureRecognizer:tap];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 30, 30)];
    imageView.image = [UIImage imageNamed:@"family_name"];
    [view addSubview:imageView];
    [_scrollView addSubview:view];
    //标题名称
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(45 , 25, 70, 20)];
    nameLabel.text = @"家人姓名:";
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor  = [UIColor colorWithRed:180 / 255.0 green:180 / 255.0 blue: 180 / 255.0 alpha:1];
    [view addSubview:nameLabel];
    //名字文本框
    _parentNameTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(115, 15, 230 * ScaleWidth, 40)];
    _parentNameTextFiled.layer.borderWidth = 1;
    _parentNameTextFiled.layer.borderColor = [[UIColor colorWithRed:210 / 255.0 green:210 / 255.0 blue:210 / 255.0 alpha:1] CGColor];
    _parentNameTextFiled.font = [UIFont systemFontOfSize:14];
    _parentNameTextFiled.textColor  = [UIColor colorWithRed:180 / 255.0 green:180 / 255.0 blue: 180 / 255.0 alpha:1];
    _parentNameTextFiled.layer.masksToBounds = YES;
    _parentNameTextFiled.layer.cornerRadius = 5;
    [view addSubview:_parentNameTextFiled];
    _height += 71;
    [_scrollView addSubview:view];
}
#pragma mark -----亲戚关系
- (void)createRelationView{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _height, kScreenWidth, 70)];
    view.backgroundColor = [UIColor whiteColor];
    [view addGestureRecognizer:tap];
    //图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 30, 30)];
    imageView.image = [UIImage imageNamed:@"family_relation"];
    [view addSubview:imageView];
    [_scrollView addSubview:view];
    //标题名称
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(45 , 25, 70, 20)];
    nameLabel.text = @"亲戚关系:";
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor  = [UIColor colorWithRed:180 / 255.0 green:180 / 255.0 blue: 180 / 255.0 alpha:1];
    [view addSubview:nameLabel];
    //名字文本框
    _parentRelation = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 200 * ScaleWidth, 20)];
    _parentRelation.text = @"哥哥";
    _parentRelation.font = [UIFont systemFontOfSize:14];
    _parentRelation.textColor  = [UIColor colorWithRed:180 / 255.0 green:180 / 255.0 blue: 180 / 255.0 alpha:1];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(115, 20, 230 * ScaleWidth, 40)];
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = [[UIColor colorWithRed:210 / 255.0 green:210 / 255.0 blue:210 / 255.0 alpha:1] CGColor];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 5;
    [view addSubview:bgView];
    [bgView addSubview:_parentRelation];
    [_scrollView addSubview:view];
    
    UIButton *selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(210 * ScaleWidth, 15, 10, 10)];
    [selectBtn setBackgroundImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(selectAct:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:selectBtn];
    _height += 71;
    
    [self createBtn];
}

- (void)selectAct:(UIButton *)sender{
    NSLog(@"12321");
}

#pragma mark ----联系电话
- (void)createPhone{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _height, kScreenWidth, 120)];
    view.backgroundColor = [UIColor whiteColor];
    [view addGestureRecognizer:tap];
    //图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 30, 30)];
    imageView.image = [UIImage imageNamed:@"family_contactphone"];
    [view addSubview:imageView];
    [_scrollView addSubview:view];
    //标题名称
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(45 , 25, 70, 20)];
    nameLabel.text = @"联系电话:";
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor  = [UIColor colorWithRed:180 / 255.0 green:180 / 255.0 blue: 180 / 255.0 alpha:1];
    [view addSubview:nameLabel];
    //电话本框
    _phoneTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(115, 15, 230 * ScaleWidth, 40)];
    _phoneTextFiled.layer.borderWidth = 1;
    _phoneTextFiled.layer.borderColor = [[UIColor colorWithRed:210 / 255.0 green:210 / 255.0 blue:210 / 255.0 alpha:1] CGColor];
    _phoneTextFiled.layer.masksToBounds = YES;
    _phoneTextFiled.layer.cornerRadius = 5;
    _phoneTextFiled.font = [UIFont systemFontOfSize:14];
    _phoneTextFiled.textColor  = [UIColor colorWithRed:180 / 255.0 green:180 / 255.0 blue: 180 / 255.0 alpha:1];
    [view addSubview:_phoneTextFiled];
    
    _verifyTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(_phoneTextFiled.left, _phoneTextFiled.bottom + 15, _phoneTextFiled.width - 80 - 5, 40)];
    _verifyTextFiled.layer.borderWidth = 1;
    _verifyTextFiled.layer.borderColor = [[UIColor colorWithRed:210 / 255.0 green:210 / 255.0 blue:210 / 255.0 alpha:1] CGColor];
    _verifyTextFiled.font = [UIFont systemFontOfSize:14];
    _verifyTextFiled.textColor  = [UIColor colorWithRed:180 / 255.0 green:180 / 255.0 blue: 180 / 255.0 alpha:1];
    _verifyTextFiled.placeholder = @"请输入验证码";
    _verifyTextFiled.font = [UIFont systemFontOfSize:14];
    _verifyTextFiled.layer.masksToBounds = YES;
    _verifyTextFiled.layer.cornerRadius = 5;
    [view addSubview:_verifyTextFiled];
    
    UIButton *verifyButton = [[UIButton alloc]initWithFrame:CGRectMake(_phoneTextFiled.right - 80, _phoneTextFiled.bottom + 15, 80, 40)];
    [verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [verifyButton setTintColor:[UIColor whiteColor]];
    [verifyButton setBackgroundColor:[UIColor colorWithRed:0 green:181 / 255.0 blue:242 / 255.0 alpha:1]];
    verifyButton.titleLabel.font = [UIFont systemFontOfSize:14];
    verifyButton.layer.masksToBounds = YES;
    verifyButton.layer.cornerRadius = 5;
    [view addSubview:verifyButton];
    
    
    _height += 121;
    
    
    [_scrollView addSubview:view];
}

#pragma mark ----可关注的学生
- (void)createAttractStudent{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _height, kScreenWidth, 35)];
    view.backgroundColor = [UIColor whiteColor];
    [view addGestureRecognizer:tap];
    //图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 30, 30)];
    imageView.image = [UIImage imageNamed:@"family_careabout"];
    [view addSubview:imageView];
    [_scrollView addSubview:view];
    //标题名称
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(45 , 10, kScreenWidth - 45, 20)];
    nameLabel.text = @"选择被邀请人可关注的学生:";
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor  = [UIColor colorWithRed:180 / 255.0 green:180 / 255.0 blue: 180 / 255.0 alpha:1];
    [view addSubview:nameLabel];
    _height += 35;
    [_scrollView addSubview:view];
    
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [accountDefaults objectForKey:@"userInfo"];
    NSString *url = [NSString stringWithFormat:StudentListUrl,[userInfo objectForKey:@"parentId"]];
    [AFNetManager postRequestWithURL:url withParameters:nil success:^(id response) {
        NSLog(@"%@",response);
        _studenArr = [response objectForKey:@"results"];
        _buttonMArr = [[NSMutableArray alloc]init];
        float height = nameLabel.bottom + 10;
        for (int i  = 0; i < _studenArr.count; i++) {
            NSInteger row = i / 3;
            NSInteger len = i % 3;
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(len * 75 + nameLabel.left, row * 30 + height, 15, 15)];
            [btn setBackgroundImage:[UIImage imageNamed:@"juxing"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"juxing"] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(attractStudentAct:) forControlEvents:UIControlEventTouchUpInside];
            [btn setImage:[UIImage imageNamed:@"duihao"] forState:UIControlStateSelected];
            btn.imageEdgeInsets = UIEdgeInsetsMake(- 5, 0, 0, 0);
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(btn.right+10, height - 2.5 + row * 30, 50, 20)];
            btn.tag = 100 + i;
            nameLabel.text = [_studenArr[i] objectForKey:@"studentName"];
            nameLabel.textColor = [UIColor colorWithRed:180 / 255.0 green:180 / 255.0 blue:182 / 255.0 alpha:1];
            nameLabel.font = [UIFont systemFontOfSize:14];
            [_buttonMArr addObject:btn];
            
            [view addSubview:btn];
            [view addSubview:nameLabel];
        }
        NSInteger hang = _studenArr.count / 3;//完整的行数
        NSInteger yuhang = _studenArr.count % 3;//对于的不足三个的
        if(yuhang != 0){
            CGRect frame = view.frame;
            frame.size.height +=  (hang + 1) * 30;
            view.frame = frame;
            _height += (hang + 1) * 30;
        }else{
            CGRect frame = view.frame;
            frame.size.height +=  hang  * 30;
            view.frame = frame;
            _height += hang  * 30;
        }
        
    }];
}

- (void)tapAction:(UIGestureRecognizer *)gesture{
    [self.view endEditing:YES];
}

- (void)createBtn{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(40, 340 + 64 + 30, kScreenWidth - 80, 40)];
    [button setTitle:@"确认邀请" forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    [button addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.textColor = [UIColor whiteColor];
    [button setBackgroundColor:[UIColor colorWithRed:0 green:181 / 255.0 blue:242 / 255.0 alpha:1]];
    [self.view addSubview:button];
    
}

- (void)btnAct:(UIButton *)sender{
    NSMutableString *studentString = [[NSMutableString alloc]init];
    for (UIButton *btn in _buttonMArr) {
        if (btn.selected == 1) {
            if (studentString.length > 0) {
                [studentString insertString:[NSString stringWithFormat:@",%@",[_studenArr[btn.tag - 100] objectForKey:@"studentId"]] atIndex:studentString.length];
            }else{
                [studentString insertString:[_studenArr[btn.tag - 100] objectForKey:@"studentId"] atIndex:0];
            }
        }
    }
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [accountDefaults objectForKey:@"userInfo"];
    NSString *url = [NSString stringWithFormat:InviteAdd,_parentNameTextFiled.text,[userInfo objectForKey:@"userId"],_parentRelation.text,_phoneTextFiled.text,studentString];
    NSString * encodingString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",url);
    [AFNetManager postRequestWithURL:encodingString withParameters:nil success:^(id response) {
        [self.view endEditing:YES];
        if ([[response objectForKey:@"code"] integerValue] == 100) {
            [self showPopupWithStyle:CNPPopupStyleCentered WithSuccess:[response objectForKey:@"msg"]];
        }else{
            [self showPopupWithStyle:CNPPopupStyleCentered WithNumber:[response objectForKey:@"msg"]];
        }
    }];
    
}

- (void)attractStudentAct:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    [_buttonMArr replaceObjectAtIndex:sender.tag - 100 withObject:sender];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark  ----- 自定义提示框
- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle WithNumber:(NSString *)info {
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"新增关注提示" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:info attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSParagraphStyleAttributeName : paragraphStyle}];
    
    CNPPopupButton *button = [[CNPPopupButton alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0];
    button.layer.cornerRadius = 4;
    button.selectionHandler = ^(CNPPopupButton *button){
        [self.popupController dismissPopupControllerAnimated:YES];
        
    };
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.attributedText = title;
    
    UILabel *lineOneLabel = [[UILabel alloc] init];
    lineOneLabel.numberOfLines = 0;
    lineOneLabel.attributedText = lineOne;
    self.popupController = [[CNPPopupController alloc] initWithContents:@[titleLabel, lineOneLabel, button]];
    self.popupController.theme = [CNPPopupTheme defaultTheme];
    self.popupController.theme.popupStyle = popupStyle;
    self.popupController.delegate = self;
    [self.popupController presentPopupControllerAnimated:YES];
}

- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle WithSuccess:(NSString *)info {
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"新增关注提示" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:info attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSParagraphStyleAttributeName : paragraphStyle}];
    
    CNPPopupButton *button = [[CNPPopupButton alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0];
    button.layer.cornerRadius = 4;
    button.selectionHandler = ^(CNPPopupButton *button){
        [self.popupController dismissPopupControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.attributedText = title;
    
    UILabel *lineOneLabel = [[UILabel alloc] init];
    lineOneLabel.numberOfLines = 0;
    lineOneLabel.attributedText = lineOne;
    self.popupController = [[CNPPopupController alloc] initWithContents:@[titleLabel, lineOneLabel, button]];
    self.popupController.theme = [CNPPopupTheme defaultTheme];
    self.popupController.theme.popupStyle = popupStyle;
    self.popupController.delegate = self;
    [self.popupController presentPopupControllerAnimated:YES];
}

@end
