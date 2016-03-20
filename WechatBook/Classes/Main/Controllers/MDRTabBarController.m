//
//  MDRTabBarController.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/20.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRTabBarController.h"
#import "MDRNavigationController.h"

#define MDRNorImgName   @"MDRNorImgName"        // 普通图片名称
#define MDRSelImgName   @"MDRSelImgName"        // 选中图片名称
#define MDRTabbarTitle  @"MDRTabbarTitle"       // 标题
#define MDRRootVcName   @"MDRRootVcName"        // 控制器的名称字符串


@interface MDRTabBarController ()

@property (nonatomic, strong) NSArray *childVcsArr;


@end

@implementation MDRTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 添加子控制器
    [self setupChildControllers];
    
}


#pragma mark - 根据配置信息添加子控制器
- (void)setupChildControllers {
    
    // 1.创建临时数组
    NSMutableArray *tempArrM = [NSMutableArray array];
    
    // 2.遍历集合数据
    [self.childVcsArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 转为控制器对象
        // 2.1 去除控制器字符串
        NSString *vcName = obj[MDRRootVcName];
        
        // 2.2 转为类型
        Class vcClass = NSClassFromString(vcName);
        
        // 2.3 创建控制器对象
        UIViewController *vc = [[vcClass alloc] init];
        
//        vc.view.backgroundColor = [UIColor whiteColor];

        // 设置文字及图片
        // 2.4 设置标题 及普通状态时的文字颜色
        vc.tabBarItem.title = obj[MDRTabbarTitle];
        
        [vc.tabBarItem setTitleTextAttributes:@{
                                               NSForegroundColorAttributeName : MDRThemeColor
                                               } forState:UIControlStateSelected];
        
        // 2.5 设置普通、选中图片
#warning 普通状态的图片不要渲染为蓝色
        vc.tabBarItem.image = [[UIImage imageNamed:obj[MDRNorImgName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:obj[MDRSelImgName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        

        // 包成导航控制器
        // 2.6 包成导航控制器
        MDRNavigationController *nav = [[MDRNavigationController alloc] initWithRootViewController:vc];
        
        // 2.7 添加到临时数组
        [tempArrM addObject:nav];
        
    }];
    
    // 3.设置为标签控制器的子控制器
    self.viewControllers = tempArrM;

}


#pragma mark - 懒加载
- (NSArray *)childVcsArr {
    
    if (!_childVcsArr) {
        
        _childVcsArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MDRTabBarVcs.plist" ofType:nil]];
    }
    
    return _childVcsArr;
}


@end
