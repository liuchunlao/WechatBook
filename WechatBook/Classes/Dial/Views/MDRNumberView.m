//
//  MDRNumberView.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/24.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//  显示按键的视图

#import "MDRNumberView.h"
#import "MDRNumberButton.h"

//#pragma mark - 定义拨号按钮的类型
//typedef enum {
//    
//    kNumberButtonTypeNumber,    // 号码
//    kNumberButtonTypeMi,        // * 键
//    kNumberButtonTypeJing,      // # 键
//    kNumberButtonTypeAdd,       // 加号键
//    kNumberButtonTypeDelete,    // 删除键
//    kNumberButtonTypePhoneCall  // 拨号键
//    
//
//} kNumberButtonType;
//
//@interface MDRNumberButton : UIButton
//
///** 按键类型 */
//@property (nonatomic, assign) kNumberButtonType type;
//
//@end
//
//@implementation MDRNumberButton
//
//
//
//@end


@interface MDRNumberView ()

@property (nonatomic, strong) NSArray *contentsArr;

@property (nonatomic, strong) NSArray *imgsArr;

@property (nonatomic, strong) NSArray *addDeleteImgArr;


@end

@implementation MDRNumberView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
#pragma mark - 10个拨号按钮
        // 0~9 共个按钮
        for (int i = 0; i < 10; i++) {
            
            // 1.创建按钮
            MDRNumberButton *btn = [[[NSBundle mainBundle] loadNibNamed:@"MDRNumberButton" owner:nil options:nil] lastObject];
            
            // 2.设置按钮内容
            btn.item = self.contentsArr[i];
            
            // 3.添加按钮
            [self addSubview:btn];
            
        }
        
#pragma mark - * # 2个按钮
        for (int i = 0; i < 2; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [btn setImage:self.imgsArr[i] forState:UIControlStateNormal];
            
            [self addSubview:btn];
        }
        
        
#pragma mark - 加号，delete按钮
        for (int i = 0; i < 2; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            // +、delete 默认是隐藏的
            btn.hidden = YES;
            
            
            [btn setImage:self.addDeleteImgArr[i] forState:UIControlStateNormal];
            
            [self addSubview:btn];
        }
        
        
#pragma mark - 拨号按钮
        UIButton *callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [callBtn setImage:[UIImage imageNamed:@"icon_voip_free_call"] forState:UIControlStateNormal];
        [callBtn setImage:[UIImage imageNamed:@"icon_voip_free_call_pressed"] forState:UIControlStateHighlighted];
        [self addSubview:callBtn];
    }
    return self;
}

#pragma mark - 布局按钮
- (void)layoutSubviews {
    
    [super layoutSubviews];
    

    // 0.数字按钮的宽 高
    int col = 3;
    
    CGFloat width = 80;
    CGFloat height = width;
    CGFloat colMargin = (self.width - col * width) / (col + 1); // 列间距
    CGFloat rowMargin = 2;
    CGFloat rowMargin2 = 10; // 拨号按钮与其他按钮的距离
    
    // 1.遍历所有的子控件
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 2.行的索引，列的索引
        CGFloat colums = idx % col; // 0, 0 , 1,1 2,2
        CGFloat row = idx / col;    // 0, 0 1,0, 2,0
        
        // 0~9 及 * #  按钮
        if (idx < 10) {
            
            obj.x = colMargin + (width + colMargin) * colums;
            if (idx == 9) {
                
                obj.x = colMargin + width + colMargin;
            }
            obj.y = (height + rowMargin) * row;
            obj.width = width;
            obj.height = height;
            
            MDRLog(@"%@", NSStringFromCGRect(obj.frame));
            
        } else if (idx < 12) {
            
            [obj sizeToFit];
            
            if (idx == 10) {
                
                obj.frame = CGRectMake(colMargin, (height + rowMargin) * row, width, height);
            } else {
            
                
                obj.frame = CGRectMake(self.width - width - colMargin, (height + rowMargin) * row, width, height);
            }
          
            
            // 添加、删除
        } else if (idx < 14) {
           
            // 自适应大小
            [obj sizeToFit];
            
            if (idx == 12) {
                
                // 调整位置
                obj.centerX = colMargin + width * 0.5;
            
            } else {
                
                obj.centerX = self.width - colMargin - width * 0.5;
            
            }
            obj.centerY = 4 * height + 3 * rowMargin + rowMargin2 + 33.5;
          
            // 拨号按钮
        } else if (idx < 15) {
            
            [obj sizeToFit];
            
            obj.centerY = [self.subviews[12] centerY];
            obj.centerX = [self.subviews[1] centerX];
        }
        
        
    }];
    
}

- (CGFloat)numberHeight {

    return 4 * 80 + 3 * 2 + 67 + 5 + 20;
    
}


#pragma mark - 懒加载
- (NSArray *)contentsArr {
    if (!_contentsArr) {
        _contentsArr = @[
                         @{
                             @"title" : @"1",
                             @"subtitle" : @"",
                             },
                         @{
                             @"title" : @"2",
                             @"subtitle" : @"ABC",
                             },
                         @{
                             @"title" : @"3",
                             @"subtitle" : @"DEF",
                             },
                         @{
                             @"title" : @"4",
                             @"subtitle" : @"GHI",
                             },
                         @{
                             @"title" : @"5",
                             @"subtitle" : @"JKL",
                             },
                         @{
                             @"title" : @"6",
                             @"subtitle" : @"MNO",
                             },
                         @{
                             @"title" : @"7",
                             @"subtitle" : @"PQRS",
                             },
                         @{
                             @"title" : @"8",
                             @"subtitle" : @"TUV",
                             },
                         @{
                             @"title" : @"9",
                             @"subtitle" : @"WXYZ",
                             },
                         @{
                             @"title" : @"0",
                             @"subtitle" : @"＋",
                             }
                         
                         ];
    }
    return _contentsArr;
}

#pragma mark - 懒加载
- (NSArray *)imgsArr {
    if (!_imgsArr) {
        _imgsArr = @[
                     [UIImage imageNamed:@"icon_call_mi"],
                     [UIImage imageNamed:@"icon_call_jin"]
                     ];
    }
    return _imgsArr;
}

- (NSArray *)addDeleteImgArr {

    if (!_addDeleteImgArr) {
        _addDeleteImgArr = @[
                             [UIImage imageNamed:@"icon_call_add"],
                             [UIImage imageNamed:@"icon_call_delete"]
                             ];
    }
    return _addDeleteImgArr;
    
    
}

@end
