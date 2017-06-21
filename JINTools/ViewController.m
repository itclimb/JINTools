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

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *datas;
@property(nonatomic, strong) NSDictionary *personDic;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    self.datas = @[
                   @"传值"
                   ];
    
    /**
    self.personDic = @{
                       @"name":@"张三",
                       @"age":@"22",
                       @"sex":@"girl",
                       @"height":@"50kg"
                       };
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"%@",docPath);
    NSString *filePath = [docPath stringByAppendingPathComponent:@"myfile.plist"];
    [self.personDic writeToFile:filePath atomically:YES];
    
    NSDictionary *myDoc = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSLog(@"%@",myDoc);
    
    //1.获得NSUserDefaults文件
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //2.向文件中写入内容
    [userDefaults setObject:@"AAA" forKey:@"a"];
    [userDefaults setBool:YES forKey:@"sex"];
    [userDefaults setInteger:21 forKey:@"age"];
    //2.1立即同步
    [userDefaults synchronize];
    */
    
    
    //1.获取文件路径
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"%@",docPath);
    //2、添加储存的文件名
    NSString *path  = [docPath stringByAppendingPathComponent:@"data.archiver"];
    //3、将一个对象保存到文件中
    BOOL flag = [NSKeyedArchiver archiveRootObject:@"name" toFile:path];
    
    //2.从文件中读取对象
    NSString *result = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"%zd----%@",flag,result);
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
