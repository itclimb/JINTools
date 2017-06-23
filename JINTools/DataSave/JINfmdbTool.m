//
//  JINfmdbTool.m
//  JINTools
//
//  Created by itclimb on 2017/6/22.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import "JINfmdbTool.h"
#import "FMDB.h"

@implementation JINfmdbTool

static FMDatabase *_db;

+ (void)initialize{
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"sqlite3.db"];
    _db = [FMDatabase databaseWithPath:filePath];
    BOOL result = [_db open];
    
    if (result) {
        NSLog(@"open database successful!");
        BOOL createTableResult = [_db executeUpdateWithFormat:@"create table if not exists t_model(modelNo integer primary key, modelName string not null, modelAge integer not null);"];
        if (createTableResult) {
            NSLog(@"create table successful!");
        }
    }
}

//#MARK: - 增加数据
+ (void)insert:(JINModel *)model
{
    BOOL result = [_db executeUpdateWithFormat:@"insert into t_model(modelNo, modelName, modelAge) values(%d,%@, %@);",model.no, model.name, model.age];
    if (result) {
        NSLog(@"add successful!");
    }
}

//MARK: - 删除数据
+ (void)deleteData:(JINModel *)model{
    BOOL result = [_db executeUpdateWithFormat:@"delete from t_model where modelNo = %d",model.no];
    if (result) {
        NSLog(@"delete successful!");
    }
}

//MARK: - 更新数据
+ (void)update:(JINModel *)model{
    BOOL result = [_db executeUpdateWithFormat:@"update t_model set modelAge = %@, modelName = %@ where modelNo = %d",model.age, model.name, model.no];
    if (result) {
        NSLog(@"update successful!");
    }
}

//MARK: - 模糊查询
+ (NSMutableArray *)queryWithKey:(NSString *)key{
    
    NSMutableArray *queryResult = [NSMutableArray array];
    FMResultSet *resultSet = [_db executeQuery:[NSString stringWithFormat:@"select * from t_model where modelName like '%%%@%%'",key]];
    while ([resultSet next]) {
        NSString *name = [resultSet stringForColumn:@"modelName"];
        NSString *age = [resultSet stringForColumn:@"modelAge"];
        int no = [resultSet intForColumn:@"modelNo"];
        JINModel *model = [[JINModel alloc] init];
        model.name = name;
        model.age = age;
        model.no = no;
        [queryResult addObject:model];
    }
    return queryResult;
}

//MARK: - 查询数据库所有数据
+ (NSMutableArray *)queryAll{
    NSMutableArray<JINModel *> *queryResult = [NSMutableArray array];
    FMResultSet *resultSet = [_db executeQueryWithFormat:@"select * from t_model"];
    while ([resultSet next]) {
        int no = [resultSet intForColumn:@"modelNo"];
        NSString *name = [resultSet stringForColumn:@"modelName"];
        NSString *age = [resultSet stringForColumn:@"modelAge"];
        JINModel *model = [[JINModel alloc] init];
        model.no = no;
        model.name = name;
        model.age = age;
        [queryResult addObject:model];
    }
    return queryResult;
}

@end
