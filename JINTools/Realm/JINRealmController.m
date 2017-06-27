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

@interface JINRealmController ()

@property(nonatomic, strong) NSMutableArray<JINRealmPerson *> *datas;

@end

@implementation JINRealmController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",filePath);
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        [realm addObjects:self.datas];
        [realm commitWriteTransaction];
    }];
}

//MARK: - lazy load
- (NSMutableArray *)datas{
    if (!_datas) {
        NSArray *arr = @[
                         @{
                             @"ID":@"2012",
                             @"name":@"xiaohong",
                             @"age":@"13",
                             @"sex":@"女"
                             },
                         @{
                             @"ID":@"2013",
                             @"name":@"小王",
                             @"age":@"13",
                             @"sex":@"男"
                             },
                         @{
                             @"ID":@"2014",
                             @"name":@"小米",
                             @"age":@"13",
                             @"sex":@"女"
                             },
                         @{
                             @"ID":@"2015",
                             @"name":@"小强",
                             @"age":@"13",
                             @"sex":@"男"
                             },
                         @{
                             @"ID":@"2033",
                             @"name":@"xiaohong",
                             @"age":@"13",
                             @"sex":@"男"
                             },
                         ];
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        [arr enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            JINRealmPerson *person = [JINRealmPerson realmPersonWithDict:dict];
            [arrM addObject:person];
        }];
        _datas = arrM;
    }
    return _datas;
}


@end
