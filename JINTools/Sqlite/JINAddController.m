//
//  JINAddController.m
//  JINTools
//
//  Created by itclimb on 2017/6/23.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import "JINAddController.h"

@interface JINAddController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property(nonatomic, copy) AddBlock block;

@end

@implementation JINAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加数据";
    
}

- (IBAction)save:(UIButton *)sender {
    if (self.block) {
        self.block(self.nameTF.text, self.ageTF.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setAddBlock:(AddBlock)block{
    _block = block;
}

@end
