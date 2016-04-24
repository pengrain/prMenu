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
    
    CGFloat w =    [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;

    
    PrMenuView *view = [[PrMenuView alloc] initWithCenter:CGPointMake(w-30, h-30) Diameter:40];
    view.delegate = self;
    [self.view addSubview:view];
}

- (void)menuViewBtnClick:(UIButton *)btn{
    NSLog(@"%ld", btn.tag);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
