//
//  MDRDialView.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/23.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRDialView.h"
#import "MDRNumberView.h"
@interface MDRDialView ()

@property (nonatomic, weak) MDRNumberView *numberView;

@end

@implementation MDRDialView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        // 1.拨号键盘视图
        MDRNumberView *numberView = [[MDRNumberView alloc] init];
        numberView.backgroundColor = [UIColor clearColor];
        
        // 2.添加视图
        [self addSubview:numberView];
        
        _numberView = numberView;
        
    }
    return self;
}


- (void)layoutSubviews {

    [super layoutSubviews];
    
    CGFloat height = [self.numberView numberHeight];
    
    self.numberView.frame = CGRectMake(0, self.height - height - 49, self.width, height);
}


@end

