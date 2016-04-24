//
//  PrMenuView.h
//  PRMenu
//
//  Created by pengrun on 15/11/15.
//  Copyright © 2015年 pengrun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PrMenuViewDelegate <NSObject>

- (void)menuViewBtnClick:(UIButton *)btn;

@end



@interface PrMenuView : UIView
@property(nonatomic, weak) id <PrMenuViewDelegate> delegate;

- (instancetype)initWithCenter:(CGPoint)center Diameter:(CGFloat)diameter;

- (void)menuTapped;

@end
