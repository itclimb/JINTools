//
//  JINRealmController.m
//  JINTools
//
//  Created by itclimb on 2017/6/27.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import "JINRealmController.h"
#import <Realm/Realm.h>
#import "JINRealmPerson.h"
#import "JINRealmUpdateController.h"
#import "JINRealmAddController.h"

@interface JINRealmController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray<JINRealmPerson *> *datas;

@end

@implementation JINRealmController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    self.datas = [self query];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addClick:)];
    self.navigationItem.rightBarButtonItem = item;
    
    
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"数据库地址:%@",filePath);
}

//MARK: - 查
- (NSMutableArray *)query{
    
    RLMResults *tempArray = [JINRealmPerson allObjects];
    return (NSMutableArray *)tempArray;
}

//MARK: - 增
- (void)addClick:(UIBarButtonItem *)item{
    JINRealmAddController *vc = [[JINRealmAddController alloc] init];
    __weak __typeof__(self)weakSelf = self;
    [vc setRealmAddBlock:^(NSString *name, NSString *age, NSString *sex) {
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            JINRealmPerson *person = [[JINRealmPerson alloc] init];
            person.name = name;
            person.age = age;
            person.sex = sex;
            [realm addObject:person];
            [realm commitWriteTransaction];
            weakSelf.datas = [weakSelf query];
            [weakSelf.tableView reloadData];
        }];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JINRealmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    
    JINRealmPerson *model = self.datas[indexPath.row];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        model.name = @"test";
    }];
    cell.nameLabel.text = model.name;
    cell.ageLabel.text = model.age;
    cell.sexLabel.text = model.sex;
    
    return cell;
}

//MARK: - 改
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JINRealmUpdateController *vc = [[JINRealmUpdateController alloc] init];
    
    JINRealmPerson *model = self.datas[indexPath.row];
    vc.model = model;
    
    __weak __typeof__(self)weakSelf = self;
    [vc setRealmUpdateBlock:^(NSString *name, NSString *age, NSString *sex) {
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^(){
            RLMResults *result = [JINRealmPerson allObjects];
            //获得当前行的数据
            JINRealmPerson *currentModel = [result objectAtIndex:indexPath.row];
            currentModel.name = name;
            currentModel.age = age;
            currentModel.sex = sex;
            
            //提交事务，即被修改
            [realm commitWriteTransaction];
            
        }];

        weakSelf.datas = [weakSelf query];
        [weakSelf.tableView reloadData];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

//MARK: - 删
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    __weak __typeof__(self)weakSelf = self;
    [realm transactionWithBlock:^{
        RLMResults *results = [JINRealmPerson allObjects];
        //从数据库删除数据
        [realm deleteObject:[results objectAtIndex:indexPath.row]];
        weakSelf.datas = [weakSelf query];
        [weakSelf.tableView reloadData];
    }];
    
}

//MARK: - lazy load

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.rowHeight = 80;
        [_tableView registerClass:[JINRealmCell class] forCellReuseIdentifier:@"identifier"];
    }
    return _tableView;
}

- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

@end



@implementation JINRealmCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"icon"];
        _icon.layer.masksToBounds = YES;
        _icon.layer.borderWidth = 1;
        _icon.layer.borderColor = [UIColor yellowColor].CGColor;
        [self.contentView addSubview:_icon];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_nameLabel];
        
        _ageLabel = [[UILabel alloc] init];
        _ageLabel.textColor = [UIColor darkGrayColor];
        _ageLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_ageLabel];
        
        _sexLabel = [[UILabel alloc] init];
        _sexLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_sexLabel];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat margin = 10;
    CGFloat contentViewW = self.contentView.bounds.size.width;
    CGFloat contentViewH = self.contentView.bounds.size.height;
    
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    CGFloat iconH = contentViewH - 2 * margin;
    CGFloat iconW = iconH;
    _icon.frame = CGRectMake(iconX, iconY, iconW, iconH);
    _icon.layer.cornerRadius = _icon.bounds.size.width/2;
    
    CGFloat nameX = iconX + iconW + margin;
    CGFloat nameY = margin;
    CGFloat nameW = 100;
    CGFloat nameH = 21;
    _nameLabel.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat sexX = nameX;
    CGFloat sexY = nameY + nameH + margin;
    CGFloat sexW = 100;
    CGFloat sexH = 21;
    _sexLabel.frame = CGRectMake(sexX, sexY, sexW, sexH);
    
    CGFloat ageW = 100;
    CGFloat ageH = 21;
    CGFloat ageX = contentViewW - ageW;
    CGFloat ageY = (contentViewH - ageH)/2;
    _ageLabel.frame = CGRectMake(ageX, ageY, ageW, ageH);
}

@end
