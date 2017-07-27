//
//  JINWebViewController.m
//  JINTools
//
//  Created by itclimb on 2017/7/27.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import "JINWebViewController.h"
#import "JINWebView.h"

@interface JINWebViewController ()<WKUIDelegate>

@property(nonatomic, strong) JINWebView *webView;

@end

@implementation JINWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"网页";
    //进行配置控制器
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    //实例化对象
    configuration.userContentController = [WKUserContentController new];
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    configuration.preferences = preferences;
    
    self.webView =[[JINWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)configuration:configuration];
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [self.view addSubview:_webView];
    _webView.backgroundColor = [UIColor clearColor];
    
    NSString *urlString = @"https://www.baidu.com";
    _webView.UIDelegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    
    [_webView webViewLoadStart:^(WKWebView *webview, WKNavigation *navigation) {
        NSLog(@"开始加载");
    } finish:^(WKWebView *webview, WKNavigation *navigation) {
        NSLog(@"加载完成");
    } fail:^(WKWebView *webview, WKNavigation *navigation) {
        NSLog(@"加载失败");
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"title"]) {
        NSLog(@"title");
    }
}

- (void)dealloc{
    [_webView removeObserver:self forKeyPath:@"title"];
}

@end
