//
//  PrMenuView.m
//  PRMenu
//
//  Created by pengrun on 15/11/15.
//  Copyright © 2015年 pengrun. All rights reserved.
//

#import "PrMenuView.h"
//#import "HomeViewController.h"

#define kTimeInterval 0.4
#define btnCount 5

@interface PrMenuView ()

@property (nonatomic, assign) BOOL               show;
@property (nonatomic, assign) CGPoint            origin;
@property (nonatomic, assign) CGPoint            BtnCenter;
@property (nonatomic, assign) CGFloat            diameter;
@property (nonatomic, strong) UIView             *backGroundView;
@property (nonatomic, strong) UIButton           *centerBtn;
@property (nonatomic, strong) UIView             *sha;
@property (nonatomic, strong) NSMutableArray     *subBtnArray;


@end

@implementation PrMenuView


- (instancetype)initWithCenter:(CGPoint)center Diameter:(CGFloat)diameter{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    //(0, 64)
    self              = [self initWithFrame:CGRectMake(0, 0, diameter, diameter)];
    self.center       = center;
    if (self) {
        [self subBtnArrayInit];

        
        _show = NO;
        _BtnCenter    = center;
        _diameter     = diameter;
        
        
        _centerBtn       = [[UIButton  alloc] init];
        _centerBtn.frame = CGRectMake(0, 0, diameter, diameter);

        
        [_centerBtn setImage:[UIImage imageNamed:@"btn_Initial"] forState:UIControlStateNormal];
        _centerBtn.layer.cornerRadius  = diameter / 2 ;
        _centerBtn.layer.masksToBounds = YES;
        [_centerBtn setEnabled:YES];
        [_centerBtn addTarget:self action:@selector(menuTapped) forControlEvents:UIControlEventTouchUpInside];
        
        
        _sha                     =[[UIView alloc] initWithFrame:CGRectMake(0, 0, diameter, diameter)];
        _sha.backgroundColor     = [UIColor colorWithRed:0/255.f green:191/255.f blue:184/255.f alpha:1];
        _sha.center              = center;
        _sha.layer.cornerRadius  = diameter / 2  ;
        _sha.layer.masksToBounds = YES;
        
        
        [self addSubview:_centerBtn];
        
        _backGroundView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
        _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        _backGroundView.userInteractionEnabled = YES;
        _backGroundView.opaque                 = NO;//透明
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelResign)];
        [_backGroundView addGestureRecognizer:tapGesture];
        [_backGroundView addSubview:_sha];
    
        
    }
    
    return self;
}

- (void)cancelResign {

    [self animateBackGroundView:self.backGroundView show:NO complete:^{
       
        _show = !_show;
        
    }];


}

- (void) subBtnArrayInit {
    _subBtnArray = [NSMutableArray array];
    
    for (int i = 0; i < btnCount; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.bounds = CGRectMake(0, 0, 75, 75);
        btn.layer.cornerRadius = 75/2;
        NSString *string = [NSString stringWithFormat:@"btn_Menu_1_%d",i];
        [btn setImage:[UIImage imageNamed:string] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(subBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_subBtnArray addObject:btn];
    }
    
}

- (void)menuTapped{ // 中间标点的按钮被点击了

    [self animateBackGroundView:self.backGroundView show:!_show complete:^{
        
        _show = !_show;
        
    }];
}


#pragma mark - animation

- (void)animateBackGroundView:(UIView *)view show:(BOOL)show complete:(void(^)())complete {
    
    if (show) {
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
        animation.fromValue         = @(_sha.layer.cornerRadius);
        animation.toValue           = @(_diameter*7/2);
        animation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.duration          = kTimeInterval;
        
        [_centerBtn setImage:[UIImage imageNamed:@"btn_Click"] forState:UIControlStateNormal];
       
        [UIView animateWithDuration:kTimeInterval animations:^{
            [_sha.layer addAnimation:animation forKey:@"cornerRadius"];
            _sha.bounds             = CGRectMake(0, 0, _diameter*7, _diameter*7);
            _sha.layer.cornerRadius = _diameter*7/2;
            _sha.center             = _BtnCenter;
            //NSLog(@"放大");
        } completion:^(BOOL finished) {
            CGFloat r               =  _centerBtn.bounds.size.width*2+5;
            CGFloat r_out           =  _centerBtn.bounds.size.width*3;
            for (int i = 0; i < btnCount; i++) {
                UIButton *btn = _subBtnArray[i];
                CGFloat x = r_out - r * sin((90/5*i*3.1415/108));
                CGFloat y = r_out - r * cos((90/5*i*3.1415/108))-10;
                btn.center = CGPointMake(x, y);
                switch (i) {
                    case 0:
                        btn.center           = CGPointMake(x+30, y-5);
                        break;
                    case 1:
                        btn.center           = CGPointMake(x+25, y-8);
                        break;
                    case 2:
                        btn.center           = CGPointMake(x+13, y-15);
                        break;
                    case 3:
                        btn.center           = CGPointMake(x-5, y-20);
                        break;
                    case 4:
                        btn.center           = CGPointMake(x-25, y-10);
                        break;
                    default:
                        break;
                }
                [_sha addSubview:btn];
            }
            
        }];
        [UIView animateWithDuration:kTimeInterval animations:^{
            [self.superview addSubview:view];
            [view.superview addSubview:self];
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
        }];
        
        
        
    } else {
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
        animation.fromValue         = @(_sha.layer.cornerRadius);
        animation.toValue           = @(_diameter/2);
        animation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.duration          = kTimeInterval;
        [_centerBtn setImage:[UIImage imageNamed:@"btn_Initial"] forState:UIControlStateNormal];
        [UIView animateWithDuration:kTimeInterval animations:^{
            [_sha.layer addAnimation:animation forKey:@"cornerRadius"];
            _sha.bounds = CGRectMake(0, 0, _diameter, _diameter);
            _sha.center = _BtnCenter;

            //NSLog(@"缩小");
        } ];
        
        
        [UIView animateWithDuration:kTimeInterval animations:^{
            
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
            
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
        
        
    }
    complete();
}


- (void)subBtnClick:(UIButton *)btn {
    
//    [SharedApp.mainTabBarController setSelectedIndex:btn.tag];
    [self menuTapped];

   
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
