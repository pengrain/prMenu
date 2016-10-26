## PRMenu 动画菜单

#### `菜单 展开、收缩 动画`

```objc
    
    #import "PrMenuView.h"
    
    //viewDidLoad

    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;

    /**
    * 动画菜单
    *      Center  : 位于 屏幕 哪里 / Where is the screen
    *      Diameter: (+、x)按钮 大小 / (+、x) Button size
    */
    PrMenuView *view = [[PrMenuView alloc] initWithCenter:CGPointMake(w-30, h-30) Diameter:40];
    view.delegate = self;
    [self.view addSubview:view];

````
-

![image](https://github.com/pengrain/prMenu/raw/master/PRMenu.gif)

-

####谢谢观看

-
