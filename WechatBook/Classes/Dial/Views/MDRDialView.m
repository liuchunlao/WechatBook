//
//  MDRDialView.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/23.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRDialView.h"
#import "MDRNumberView.h"
@interface MDRDialView () <MDRNumberViewDelegate>

@property (nonatomic, weak) MDRNumberView *numberView;

@property (nonatomic, weak) UILabel *numberLbl;

@end

@implementation MDRDialView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // MARK: - 显示号码的label
        UILabel *numberLbl = [[UILabel alloc] init];
        
        numberLbl.font = [UIFont systemFontOfSize:28];
        numberLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:numberLbl];
        numberLbl.backgroundColor = [UIColor clearColor];
        _numberLbl = numberLbl;
        

        // MARK: - 号码及拨号按钮
        // 1.拨号键盘视图
        MDRNumberView *numberView = [[MDRNumberView alloc] init];
        numberView.backgroundColor = [UIColor clearColor];
        
        numberView.delegate = self;
        // 2.添加视图
        [self addSubview:numberView];
        
        _numberView = numberView;
        
    }
    return self;
}


#pragma mark - MDRNumberViewDelegate
// 显示要呼叫的号码
- (void)numberView:(MDRNumberView *)numberView wantToCallNumber:(NSString *)numberStr {

    self.numberLbl.text = numberStr;

    
    // MARK: - 是否隐藏导航栏
    BOOL isContain;
    if (numberStr.length > 0) {
        isContain = YES;
    } else {
    
        isContain = NO;
    }
    
    if (self.hideNavBar) {
        self.hideNavBar(isContain);
    }
}

// 想要保存号码
- (void)numberView:(MDRNumberView *)numberView wantToSaveNumber:(NSString *)numberStr {
    
    if (self.addContact) {
        self.addContact(numberStr);
    }

}


- (void)layoutSubviews {

    [super layoutSubviews];
    
    
    // 显示号码的label
    self.numberLbl.frame = CGRectMake(0, 64, self.width, 50);
    
    
    // 拨号及号码视图
    CGFloat height = [self.numberView numberHeight];
    
    self.numberView.frame = CGRectMake(0, self.height - height - 49, self.width, height);
}


@end

