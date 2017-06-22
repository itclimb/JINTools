//
//  JINDataTestController.m
//  JINTools
//
//  Created by itclimb on 2017/6/22.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import "JINDataTestController.h"
#import "JINModel.h"
#import "JINfmdbTool.h"

@interface JINDataTestController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *datas;

@end

@implementation JINDataTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self.datas enumerateObjectsUsingBlock:^(JINModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        [JINfmdbTool insert:model];
    }];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(0, 0, 100, 35);
    tableView.tableHeaderView = searchBar;
}

//MARK: - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"%@",searchText);
    [self.tableView reloadData];
}

//MARK: - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    JINModel *model = self.datas[indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.age;
    return cell;
}

//MARK: - lazy load
- (NSMutableArray *)datas{
    if (!_datas) {
        NSArray *array = @[
                           @{
                               @"name":@"zhangsan",
                               @"age":@"15"
                               },
                           @{
                               @"name":@"lisi",
                               @"age":@"17"
                               },
                           @{
                               @"name":@"wangwu",
                               @"age":@"11"
                               },
                           @{
                               @"name":@"xiaoming",
                               @"age":@"22"
                               }
                           ];
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:array.count];
        [array enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            JINModel *model = [JINModel modelWithDict:dict];
            [arrM addObject:model];
        }];
        _datas = arrM;
    }
    return _datas;
}

@end
