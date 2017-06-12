//
//  JINBlockViewController.m
//  JINTools
//
//  Created by itclimb on 12/06/2017.
//  Copyright © 2017 itclimb.yuancheng.com. All rights reserved.
//

#import "JINBlockViewController.h"
#import "JINBlockSecondController.h"

@interface JINBlockViewController ()

@property(nonatomic, strong) UILabel *showLabel;

@end

@implementation JINBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *showLabel = [[UILabel alloc] init];
    showLabel.backgroundColor = [UIColor grayColor];
    showLabel.width = 100;
    showLabel.height = 30;
    showLabel.center = self.view.center;
    self.showLabel = showLabel;
    [self.view addSubview:showLabel];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    JINBlockSecondController *vc = [[JINBlockSecondController alloc] init];
    [vc setSecondBlock:^(NSString *content) {
        self.showLabel.text = content;
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
