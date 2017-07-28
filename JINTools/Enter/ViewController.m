//
//  ViewController.m
//  JINTools
//
//  Created by itclimb on 12/06/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import "ViewController.h"
#import "JINBlockViewController.h"
#import "JINTestView.h"
#import "JINDataTestController.h"
#import "JINRealmController.h"
#import "JINRealmApplyController.h"
#import "JINAutoLayoutController.h"
#import "JINWebViewController.h"
#import "JINAudioController.h"
#import "JINVideoController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *datas;
@property(nonatomic, strong) NSDictionary *personDic;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = @"Demo";
    
    self.datas = @[
                   @"传值",
                   @"fmdb",
                   @"Realm",
                   @"Realm应用",
                   @"自动布局",
                   @"网页加载",
                   @"音频",
                   @"视频"
                   ];
    
}

//MARK: - UITableViewDataSource,
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.datas[indexPath.row];
    
    //设置分割线从视图最左边开始
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            JINBlockViewController *vc = [[JINBlockViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:
        {
            JINDataTestController *vc = [[JINDataTestController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:
        {
            JINRealmController *vc = [[JINRealmController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:
        {
            JINRealmApplyController *vc = [[JINRealmApplyController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4:
        {
            JINAutoLayoutController *vc = [[JINAutoLayoutController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 5:
        {
            JINWebViewController *vc = [[JINWebViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 6:
        {
            JINAudioController *vc = [[JINAudioController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 7:
        {
            JINVideoController *vc = [[JINVideoController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}


//MARK: - lazy load
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}


@end
