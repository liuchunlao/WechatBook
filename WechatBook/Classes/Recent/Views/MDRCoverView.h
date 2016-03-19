//
//  MDRCoverView.h
//  WechatBook
//
//  Created by 刘春牢 on 16/3/20.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 下拉菜单显示的位置
typedef enum{
    
    kPopDirectionLeft,
    kPopDirectionRight

} kPopDirection;


#pragma mark - 定义指向跳转的block
typedef void (^CoverBlock) (UIViewController *);


@interface MDRCoverView : UIView

// 弹窗数据的plist文件
@property (nonatomic, copy) NSString *popListName;

// 指向靠左的item，还是靠右的item
@property (nonatomic, assign) kPopDirection direction;

// block变量
@property (nonatomic, copy) CoverBlock jumpBlock;


@end
