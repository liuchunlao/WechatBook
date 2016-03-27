//
//  MDRNumberView.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/24.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//  显示按键的视图

#import "MDRNumberView.h"
#import "MDRNumberButton.h"


@interface MDRNumberView ()

@property (nonatomic, strong) NSArray *contentsArr;

@property (nonatomic, strong) NSArray *imgsArr;

@property (nonatomic, strong) NSArray *addDeleteImgArr;

// 号码字符串
@property (nonatomic, copy) NSMutableString *numberStr;

// 添加和删除按钮
@property (nonatomic, strong) NSArray *addDeleteBtnArr;

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
            
            btn.type = kNumberButtonTypeNumber;
            
            // 2.设置按钮内容
            btn.item = self.contentsArr[i];
            
            // 3.添加按钮
            [self addSubview:btn];
            
        }
        
#pragma mark - * # 2个按钮
        for (int i = 0; i < 2; i++) {
            
            MDRNumberButton *btn = [MDRNumberButton buttonWithType:UIButtonTypeCustom];
            
            [btn setImage:self.imgsArr[i] forState:UIControlStateNormal];
            
            if (i == 0) {
                
                btn.type = kNumberButtonTypeMi;
            } else {
            
                btn.type = kNumberButtonTypeJing;
            }
            
            [self addSubview:btn];
        }
        
        
#pragma mark - 加号，delete按钮
        NSMutableArray *temp = [NSMutableArray array];
        for (int i = 0; i < 2; i++) {
            
            MDRNumberButton *btn = [MDRNumberButton buttonWithType:UIButtonTypeCustom];
            
            // +、delete 默认是隐藏的
            btn.hidden = YES;
            
            if (i == 0) {
                btn.type = kNumberButtonTypeAdd;
            } else {
                btn.type = kNumberButtonTypeDelete;
            }
            
            
            [btn setImage:self.addDeleteImgArr[i] forState:UIControlStateNormal];
            
            [self addSubview:btn];
            [temp addObject:btn];
        }
        self.addDeleteBtnArr = temp;
        
        
#pragma mark - 拨号按钮
        UIButton *callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [callBtn setImage:[UIImage imageNamed:@"icon_voip_free_call"] forState:UIControlStateNormal];
        [callBtn setImage:[UIImage imageNamed:@"icon_voip_free_call_press"] forState:UIControlStateHighlighted];
        [self addSubview:callBtn];
        
        
#pragma mark - 遍历所有按钮，设置图片和监听事件
        UIImage *bgImg = [MDRTool imageWithColor:MDRRGBColor(210, 210, 210)];
        
        [self.subviews enumerateObjectsUsingBlock:^(__kindof MDRNumberButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            // 1.监听事件
            [obj addTarget:self action:@selector(numberBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            // 2.拨号及添加删除按钮不需要设置图片，直接返回
            if (![obj isKindOfClass:[MDRNumberButton class]] || obj.type == kNumberButtonTypeAdd || obj.type == kNumberButtonTypeDelete) {
                return ;
            }
            obj.layer.cornerRadius = 40;
            obj.layer.masksToBounds = YES;
            
            [obj setBackgroundImage:bgImg forState:UIControlStateHighlighted];
            
            
        }];
    }
    return self;
}

#pragma mark - 点击按钮调用
- (void)numberBtnClick:(MDRNumberButton *)numberBtn {
    
    [self.addDeleteBtnArr makeObjectsPerformSelector:@selector(setHidden:) withObject:(id)NO];
    
    
    if (![numberBtn isKindOfClass:[MDRNumberButton class]]) {
        
        MDRLog(@"拨号键");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.numberStr] ]];
        
        return;
    }
    
    switch (numberBtn.type) {
            
        case kNumberButtonTypeNumber:
            
            MDRLog(@"号码键");
            [self append:numberBtn.item[@"title"]];
            break;
        case kNumberButtonTypeMi:
            
            MDRLog(@"*键");
            [self append:@"*"];
            break;
        case kNumberButtonTypeJing:
            
            MDRLog(@"#键");
            [self append:@"#"];
            break;
        case kNumberButtonTypeAdd:
            
            MDRLog(@"添加键--> 提示保存联系人");
            if ([self.delegate respondsToSelector:@selector(numberView:wantToSaveNumber:)]) {
                [self.delegate numberView:self wantToSaveNumber:self.numberStr];
            }
            
            break;
        case kNumberButtonTypeDelete:
            
            MDRLog(@"删除键--> 清除字符串");
            [self deleteStr];
            break;
            
        default:
            break;
    }

}

- (void)append:(NSString *)str {
    
    [self.numberStr appendFormat:@"%@", str];
    
    MDRLog(@"%@", self.numberStr);
    
    if ([self.delegate respondsToSelector:@selector(numberView:wantToCallNumber:)]) {
        [self.delegate numberView:self wantToCallNumber:self.numberStr];
    }
}

- (void)deleteStr {
    
    if (self.numberStr.length > 0) {
    
        [self.numberStr deleteCharactersInRange:NSMakeRange(self.numberStr.length - 1, 1)];
    }
    
    if (self.numberStr.length == 0) {
        [self.addDeleteBtnArr enumerateObjectsUsingBlock:^(UIButton *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            obj.hidden = YES;
        }];
    }
    
    if ([self.delegate respondsToSelector:@selector(numberView:wantToCallNumber:)]) {
        [self.delegate numberView:self wantToCallNumber:self.numberStr];
    }
    
    MDRLog(@"%@", self.numberStr);

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

- (NSMutableString *)numberStr {

    if (_numberStr == nil) {
        _numberStr = [NSMutableString string];

    }
    return _numberStr;
}

@end
