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
#import "JINAddController.h"
#import "JINUpdataController.h"

#define kTableViewCellH 60

@interface JINDataTestController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *datas;

@end

@implementation JINDataTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"数据列表";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
    [tableView registerClass:[JINDataTestCell class] forCellReuseIdentifier:@"identifier"];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorInset = UIEdgeInsetsZero;
    tableView.rowHeight = kTableViewCellH;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.datas = [JINfmdbTool queryAll];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(0, 0, 100, 35);
    tableView.tableHeaderView = searchBar;
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addClick:)];
    self.navigationItem.rightBarButtonItem = addItem;
}

//MARK: - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"%@",searchText);
    self.datas =  [JINfmdbTool queryWithKey:searchText];
    [self.tableView reloadData];
}

//MARK: - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JINDataTestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    JINModel *model = self.datas[indexPath.row];
    cell.first.text = [NSString stringWithFormat:@"%d",model.no];
    cell.title.text = [NSString stringWithFormat:@"姓名: %@",model.name];
    cell.detail.text = [NSString stringWithFormat:@"年龄: %@",model.age];
    return cell;
}

//MARK: - 修改数据
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JINUpdataController *vc = [[JINUpdataController alloc] init];
    
    [vc setUpdateBlock:^(NSString *name, NSString *age) {
        
        JINModel *currentModel = self.datas[indexPath.row];
        currentModel.name = name;
        currentModel.age = age;
        [JINfmdbTool update:currentModel];
        [self.tableView reloadData];
        
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

//MARK: - 删除数据
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        JINModel *model = self.datas[indexPath.row];
        [self.datas removeObjectAtIndex:indexPath.row];
        [JINfmdbTool deleteData:model];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

//MARK: - 增添数据
- (void)addClick:(UIBarButtonItem *)item {
    JINAddController *addVc = [[JINAddController alloc] init];
    __weak __typeof__(self)weakSelf = self;
    [addVc setAddBlock:^(NSString *name, NSString *age) {
        JINModel *model = [[JINModel alloc] init];
        model.name = name;
        model.age = age;
        JINModel *lastModel = [self.datas lastObject];
        if (lastModel) {
            model.no = lastModel.no + 1;
        }
        [weakSelf.datas addObject:model];
        [JINfmdbTool insert:model];
        [weakSelf.tableView reloadData];
    }];
    [self.navigationController pushViewController:addVc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

//MARK: - lazy load
- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

@end

@implementation JINDataTestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _first = [[UILabel alloc] init];
        CGFloat first_w = 50;
        CGFloat first_h = first_w;
        CGFloat first_x = 10;
        CGFloat first_y = (kTableViewCellH - first_h) * 0.5;
        _first.textAlignment = NSTextAlignmentCenter;
        _first.frame = CGRectMake(first_x, first_y, first_w, first_h);
        _first.layer.masksToBounds = YES;
        _first.layer.cornerRadius = _first.frame.size.width/2;
        _first.layer.borderWidth = 1;
        _first.layer.borderColor = [UIColor greenColor].CGColor;
        [self.contentView addSubview:_first];
        
        _title = [[UILabel alloc] init];
        CGFloat title_w = 150;
        CGFloat title_h = 21;
        CGFloat title_x = first_x + first_w + 30;
        CGFloat title_y = (kTableViewCellH - title_h) * 0.5;
        _title.frame = CGRectMake(title_x, title_y, title_w , title_h);
        [self.contentView addSubview:_title];
        
        _detail = [[UILabel alloc] init];
        CGFloat detail_w = 100;
        CGFloat detail_h = 21;
        CGFloat detail_x = title_x + title_w + 20;
        CGFloat detail_y = title_y;
        _detail.frame = CGRectMake(detail_x, detail_y, detail_w, detail_h);
        [self.contentView addSubview:_detail];
        
    }
    return self;
}


@end
