//
//  JINRealmApplyController.m
//  JINTools
//
//  Created by itclimb on 2017/6/30.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import "JINRealmApplyController.h"
#import "JINPhoneModel.h"
#import <Realm/Realm.h>

@interface JINRealmApplyController ()

@property(nonatomic, strong) NSMutableArray<JINPhoneModel*> *datas;

@end

@implementation JINRealmApplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"my.realm"];
    NSLog(@"数据库地址:%@",filePath);
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [NSURL URLWithString:filePath];
    config.readOnly = NO;
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
//        [realm addObjects:self.datas];
        [realm addOrUpdateObjectsFromArray:self.datas];
        [realm commitWriteTransaction];
    }];
    
}

- (NSMutableArray<JINPhoneModel *> *)datas{
    if (!_datas) {
        NSArray *tempArr = @[
                             @{
                                 @"phoneID":@"0",
                                 @"phoneName":@"iPhonewww",
                                 @"phoneSize":@"4-inch",
                                 @"phoneColor":@"gold"
                                 },
                             @{
                                 @"phoneID":@"8",
                                 @"phoneName":@"iPhoneBBB",
                                 @"phoneSize":@"4-inch",
                                 @"phoneColor":@"gold"
                                 },
                             @{
                                 @"phoneID":@"1",
                                 @"phoneName":@"iPhone6",
                                 @"phoneSize":@"4.7-inch",
                                 @"phoneColor":@"black"
                                 },
                             @{
                                 @"phoneID":@"2",
                                 @"phoneName":@"iPhone6p",
                                 @"phoneSize":@"5.5-inch",
                                 @"phoneColor":@"green"
                                 },
                             @{
                                 @"phoneID":@"3",
                                 @"phoneName":@"iPhone7",
                                 @"phoneSize":@"4.7-inch",
                                 @"phoneColor":@"black"
                                 }
                             ];
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:tempArr.count];
        [tempArr enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            JINPhoneModel *model = [JINPhoneModel phoneModelWithDict:dict];
            [arrM addObject:model];
        }];
        _datas = arrM;
    }
    return _datas;
}

@end
