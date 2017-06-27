//
//  JINRealmAddController.m
//  JINTools
//
//  Created by itclimb on 2017/6/27.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import "JINRealmAddController.h"

@interface JINRealmAddController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *sexTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;

@property(nonatomic, copy) JINRealmAddBlock block;

@end

@implementation JINRealmAddController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (IBAction)addClick:(UIButton *)sender {
    if (self.block) {
        self.block(self.nameTF.text, self.ageTF.text, self.sexTF.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setRealmAddBlock:(JINRealmAddBlock)block{
    _block = block;
}

@end
