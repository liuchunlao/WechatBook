//
//  MDRNumberButton.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/24.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRNumberButton.h"

@interface MDRNumberButton ()

// 2
@property (nonatomic, weak) IBOutlet UILabel *titleLbl;

// ABC
@property (nonatomic, weak) IBOutlet UILabel *subtitleLbl;


@end

@implementation MDRNumberButton


- (void)setItem:(NSDictionary *)item {

    _item = item;
    
    self.titleLbl.text = item[@"title"];
    if ([item[@"subtitle"] length] > 0) {
        self.subtitleLbl.text = item[@"subtitle"];
    } else {
        self.subtitleLbl.text = nil;
    }
    
}

@end
