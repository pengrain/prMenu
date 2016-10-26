//
//  ViewController.m
//  PRMenu
//
//  Created by pengrun on 15/11/15.
//  Copyright © 2015年 pengrun. All rights reserved.
//

#import "ViewController.h"
#import "PrMenuView.h"

@interface ViewController ()<PrMenuViewDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;

    /**
     * 动画菜单
     *      Center  : 位于 屏幕(center) 哪里 / Where is the screen center
     *      Diameter: (+、x)按钮 大小 / (+、x) Button size
     */
    PrMenuView *view = [[PrMenuView alloc] initWithCenter:CGPointMake(w-30, h-30) Diameter:40];
    view.delegate = self;
    [self.view addSubview:view];
}

- (void)menuViewBtnClick:(UIButton *)btn{
    NSLog(@"%zd", btn.tag);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
