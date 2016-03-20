//
//  MDRSettingBaseController.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/20.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRSettingBaseController.h"

@interface MDRSettingBaseController ()

// 所有组数据的集合
@property (nonatomic, strong) NSArray *groupArr;

@end

@implementation MDRSettingBaseController

#pragma mark - 分组样式
- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}


#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1.取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    // 2.获取选中行的所有数据
    // 2.1 组
    NSDictionary *group = self.groupArr[indexPath.section];
    // 2.2 行
    NSDictionary *item = group[@"MDRItems"][indexPath.row];
    
    
    // 3.跳转到目标控制器
    // 3.1 去字符串
    NSString *targetVcStr = item[@"MDRTargetVc"];
    if (targetVcStr.length <= 0) {
        return;
    }
    // 3.2 转为类
    Class className = NSClassFromString(targetVcStr);
    // 3.3 创建对象
    UIViewController *vc = [[className alloc] init];
    // 3.4 设置标题
    vc.navigationItem.title = item[@"MDRTitle"];
    
    
    // 4.跳转
    // 4.1 如果是设置base控制器类型的对象，需要设置加载的文件
    if ([vc isKindOfClass:[MDRSettingBaseController class]]) {
        
        // 1.墙砖
        MDRSettingBaseController *settingVc = (MDRSettingBaseController *)vc;
        
        // 2.设置加载文件名称
        settingVc.plistName = item[@"MDRPlistName"];
        // 3.跳转
        [self.navigationController pushViewController:settingVc animated:YES];
    } else {
    
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}

// 调整组与组之间的间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8;
}


#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.groupArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // 1.组的所有数据
    NSDictionary *group = self.groupArr[section];
    
    // 2.组内行数
    return [group[@"MDRItems"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // 1.创建cell
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    // 2.设置数据
    NSArray *items = self.groupArr[indexPath.section][@"MDRItems"];
    NSDictionary *item = items[indexPath.row];
    
    // 2.1 设置图片
    if ([item[@"MDRIcon"] length] > 0) {
        cell.imageView.image = [UIImage imageNamed:item[@"MDRIcon"]];
    }
    
    // 2.2 设置标题
    cell.textLabel.text = item[@"MDRTitle"];
    
    // 2.3 设置指示器
    // 1. 获取字符串
    NSString *accessoryStr = item[@"MDRAccessoryType"];
    // 2.转为OC的类
    if (accessoryStr.length == 0) {
        return cell;
    }
    Class className = NSClassFromString(accessoryStr);
    // 3.创建对象
    id obj = [[className alloc] init];
    
    // 4.判断
    if ([obj isKindOfClass:[UIImageView class]]) {
        UIImageView *imgView = (UIImageView *)obj;
        
        imgView.image = [UIImage imageNamed:item[@"MDRAccessoryName"]];
        [imgView sizeToFit];
        
        cell.accessoryView = imgView;
    }
    
    if ([obj isKindOfClass:[UISwitch class]]) {

        UISwitch *switcher = (UISwitch *)obj;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryView = switcher;
    }
    
    
    // 3.返回cell
    return cell;

}



#pragma mark - 懒加载
- (NSArray *)groupArr {
    if (!_groupArr) {
        _groupArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self.plistName ofType:@"plist"]];
    }
    return _groupArr;
}

@end
