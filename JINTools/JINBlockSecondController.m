//
//  JINBlockSecondController.m
//  JINTools
//
//  Created by itclimb on 12/06/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import "JINBlockSecondController.h"

@interface JINBlockSecondController ()

@property (weak, nonatomic) IBOutlet UITextField *contentTF;
@property(nonatomic, copy) JINSecondBlock block;

@end

@implementation JINBlockSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController popViewControllerAnimated:YES];
    if (self.block) {
        self.block(self.contentTF.text);
    }
}

- (void)setSecondBlock:(JINSecondBlock)block{
    self.block = block;
}

@end
