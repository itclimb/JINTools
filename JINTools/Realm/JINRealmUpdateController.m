//
//  JINRealmUpdateController.m
//  JINTools
//
//  Created by itclimb on 2017/6/27.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import "JINRealmUpdateController.h"

@interface JINRealmUpdateController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property (weak, nonatomic) IBOutlet UITextField *sexTF;

@property(nonatomic, copy) JINRealmUpdateBlock block;
@end

@implementation JINRealmUpdateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameTF.text = self.model.name;
    self.sexTF.text = self.model.sex;
    self.ageTF.text = self.model.age;
}

- (void)setModel:(JINRealmPerson *)model{
    _model = model;
    
}

- (IBAction)updateClick:(UIButton *)sender {
    if (_block) {
        self.block(self.nameTF.text, self.ageTF.text, self.sexTF.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setRealmUpdateBlock:(JINRealmUpdateBlock)block{
    _block = block;
}
@end
