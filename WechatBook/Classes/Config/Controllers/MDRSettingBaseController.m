//
//  MDRSettingBaseController.m
//  WechatBook
//
//  Created by 刘春牢 on 16/3/20.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRSettingBaseController.h"
#import "MDRSettingBaseCell.h"


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
    NSDictionary *item = group[MDRItems][indexPath.row];
    
    
    // 3.跳转到目标控制器
    // 3.1 去字符串
    NSString *targetVcStr = item[MDRTargetVc];
    if (targetVcStr.length <= 0) {
        return;
    }
    // 3.2 转为类
    Class className = NSClassFromString(targetVcStr);
    // 3.3 创建对象
    UIViewController *vc = [[className alloc] init];
    // 3.4 设置标题
    vc.navigationItem.title = item[MDRTitle];
    
    
    // 4.跳转
    // 4.1 如果是设置base控制器类型的对象，需要设置加载的文件
    if ([vc isKindOfClass:[MDRSettingBaseController class]]) {
        
        // 1.墙砖
        MDRSettingBaseController *settingVc = (MDRSettingBaseController *)vc;
        
        // 2.设置加载文件名称
        settingVc.plistName = item[MDRPlistName];
        // 3.跳转
        [self.navigationController pushViewController:settingVc animated:YES];
    } else {
    
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return self.groupArr[section][MDRHeader];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
    return self.groupArr[section][MDRFooter];
}


#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.groupArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // 1.组的所有数据
    NSDictionary *group = self.groupArr[section];
    
    // 2.组内行数
    return [group[MDRItems] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // 1.创建cell
    MDRSettingBaseCell *cell = [MDRSettingBaseCell cellWithTableView:tableView];

    // 2.设置数据
    // 2.1 取出每行的数据
    NSArray *items = self.groupArr[indexPath.section][MDRItems];
    NSDictionary *item = items[indexPath.row];
    // 2.2 设置给cell
    cell.item = item;
    
    
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
