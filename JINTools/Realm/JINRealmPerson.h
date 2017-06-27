//
//  JINRealmPerson.h
//  JINTools
//
//  Created by itclimb on 2017/6/27.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import <Realm/Realm.h>

@interface JINRealmPerson : RLMObject

@property(nonatomic, assign) NSInteger ID;

@property(nonatomic, copy) NSString *name;

@property(nonatomic, copy) NSString *age;

@property(nonatomic, copy) NSString *sex;

+ (instancetype)realmPersonWithDict:(NSDictionary *)dict;

@end
