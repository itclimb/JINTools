//
//  JINUpdataController.m
//  JINTools
//
//  Created by itclimb on 2017/6/23.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import "JINUpdataController.h"

@interface JINUpdataController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;

@property(nonatomic, copy) UpdateBlock block;

@end

@implementation JINUpdataController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改";
}

- (IBAction)update:(UIButton *)sender {
    if (self.block) {
        self.block(self.nameTF.text, self.ageTF.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUpdateBlock:(UpdateBlock)block{
    _block = block;
}
@end
