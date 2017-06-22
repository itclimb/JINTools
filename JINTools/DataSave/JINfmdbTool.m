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
    BOOL result = [_db executeUpdateWithFormat:@"insert into t_model(modelName,modelAge) values(%@,%@);",model.name, model.age];
    if (result) {
        NSLog(@"新增成功");
    }
}

//MARK: - 模糊查询
+ (NSArray *)queryWithKey:(NSString *)key{
    NSMutableArray *queryResult = [NSMutableArray array];
    FMResultSet *resultSet = [_db executeQuery:[NSString stringWithFormat:@"select * from t_model where modelName like '%%%@%%'",key]];
    while ([resultSet next]) {
        NSString *name = [resultSet stringForColumn:@"studentName"];
        int age = [resultSet intForColumn:@"studentAge"];
        JINModel *model = [[JINModel alloc] init];
        model.name = name;
        model.age = [NSString stringWithFormat:@"%zd",age];
        [queryResult addObject:model];
    }
    return queryResult.copy;
}

@end
