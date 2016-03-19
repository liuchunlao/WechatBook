//
//  MDRCoverView.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/20.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRCoverView.h"

#define MDRTitle    @"MDRTitle"
#define MDRIcon     @"MDRIcon"
#define MDRTargetVc @"MDRTargetVc"

@interface MDRCoverView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *listArr;


@end

@implementation MDRCoverView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 列表视图
        // 1.创建
        UITableView *tableView = [[UITableView alloc] init];
        
        // 2.设置圆角及cell不能够滚动
        tableView.layer.cornerRadius = 2;
        tableView.scrollEnabled = NO;
        
        // 3.设置数据源对象和代理对象
        tableView.dataSource = self;
        tableView.delegate = self;
        
        // 4.添加并赋值
        [self addSubview:tableView];
        self.tableView = tableView;
        
    }
    return self;
}


#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1.获取改行的目标控制器
    // 1.1 获取选中的内容
    NSDictionary *dict = self.listArr[indexPath.row];
    
    // 1.2 获取目标控制器字符串
    NSString *vcStr = dict[MDRTargetVc];
    
    // 1.3 转为类
    Class vcClass = NSClassFromString(vcStr);
    
    // 1.4 创建对象
    UIViewController *obj = [[vcClass alloc] init];
    
    // 2.让控制器执行跳转
    // 2.1 让控制器执行跳转
    
    // 如果跳转到block有值，就执行跳转
    if (self.jumpBlock) {
        self.jumpBlock(obj);
    }
    
    // 2.2 自己立即消失
    [self removeFromSuperview];
    
    


}


#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1.创建cell
    static NSString *ID = @"list";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = MDRRGBColor(223, 223, 223);
    }
    
    // 2.设置数据
    NSDictionary *dict = self.listArr[indexPath.row];
    cell.textLabel.text = dict[MDRTitle];
    cell.imageView.image = [UIImage imageNamed:dict[MDRIcon]];
    
    
    // 3.返回cell
    return cell;
}

#pragma mark - 布局子控件
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // 宽度固定
    self.tableView.width = 160;
    // 高度 = 行数 * 44
    self.tableView.height = 44 * self.listArr.count;
    
    // y = 70;
    self.tableView.y = 70;
    // x
    switch (self.direction) {
        case kPopDirectionLeft:
            self.tableView.x = 5;
            break;
            
        case kPopDirectionRight:
            self.tableView.x = self.width - self.tableView.width - 5;
            break;
            
        default:
            break;
    }
    
}


#pragma mark - 懒加载
- (NSArray *)listArr {
    if (!_listArr) {
        _listArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self.popListName ofType:@"plist"]];
    }
    return _listArr;
}


// 一旦触摸此视图变回从父控件中移除
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self removeFromSuperview];
}


@end
