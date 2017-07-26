//
//  JINWebView.m
//  JINTools
//
//  Created by itclimb on 2017/7/26.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import "JINWebView.h"

static const NSString *kSource = @"source";
static const NSString *kToUrl = @"toUrl";
static const NSString *kState = @"state";
static const NSString *kComplete = @"complete";

@interface JINWebView ()<WKNavigationDelegate>

//信息数据
@property(nonatomic, strong) NSMutableArray<NSDictionary *> *info;

//开始
@property(nonatomic, copy) LoadStartBlock start;
//完成
@property(nonatomic, copy) LoadFinishBlock finish;
//失败
@property(nonatomic, copy) LoadFailBlock fail;
//完成回调
@property(nonatomic, copy) CompleteBlock complete;

@end

@implementation JINWebView

- (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration{
    self = [super initWithFrame:frame configuration:configuration];
    if (self) {
        self.info = [NSMutableArray array];
        self.navigationDelegate = self;
    }
    return self;
}

//MARK: - 替换要跳转的url
- (void)replace:(NSString *)url To:(NSString *)newUrl complete:(CompleteBlock)complete{
    NSDictionary *urlDic = @{
                             kSource:url,
                             kToUrl:newUrl,
                             kState:@"0",
                             kComplete:complete
                             };
    [self.info addObject:urlDic];
}

//MARK: - 检测url
- (void)check:(NSString *)url complete:(CompleteBlock)complete{
    NSDictionary *urlDic = @{
                             kSource:url,
                             kToUrl:@"",
                             kState:@"1",
                             kComplete:complete
                             };
    [self.info addObject:urlDic];
}

//MARK: - 拦截url
- (void)intercept:(NSString *)url complete:(CompleteBlock)complete{
    NSDictionary *urlDic = @{
                             kSource:url,
                             kToUrl:@"",
                             kState:@"0",
                             kComplete:complete
                             };
    [self.info addObject:urlDic];
}

//MARK: - 包含字符拦截
- (void)contain:(NSString *)url complete:(CompleteBlock)complete{
    NSDictionary *urlDic = @{
                             kSource:url,
                             kToUrl:@"",
                             kState:@"0",
                             kComplete:complete
                             };
    [self.info addObject:urlDic];
}

//MARK: - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *url = navigationAction.request.URL.absoluteString;
    
    for (NSDictionary *dict in self.info) {
        
        NSString *sourceUrl = dict[kSource];
        
        if ([sourceUrl isEqualToString:url]) {
            if ([dict[kState] isEqualToString:@"0"]) {//拦截不加载
                decisionHandler(WKNavigationActionPolicyCancel);
            }else{//检测并加载
                decisionHandler(WKNavigationActionPolicyAllow);
            }
            //替换并加载
            NSString *newUrl = dict[kToUrl];
            if(newUrl.length != 0){
                NSURL *newURL = [NSURL URLWithString:dict[kToUrl]];
                [webView loadRequest:[NSURLRequest requestWithURL:newURL]];
            }
            
            self.complete = dict[kComplete];
            self.complete(YES);
            return;
        }
        
        if([url containsString:sourceUrl]){
            if ([dict[kState] isEqualToString:@"0"]) {
                decisionHandler(WKNavigationActionPolicyCancel);
            }else{
                decisionHandler(WKNavigationActionPolicyAllow);
            }
            NSString *newUrl = dict[kToUrl];
            if(newUrl.length != 0){
                NSURL *newURL = [NSURL URLWithString:dict[kToUrl]];
                [webView loadRequest:[NSURLRequest requestWithURL:newURL]];
            }
            
            self.complete = dict[kComplete];
            self.complete(YES);
            return;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    if (self.start) {
        self.start(webView, navigation);
    }
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    if (self.finish) {
        self.finish(webView, navigation);
    }
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    if (self.fail) {
        self.fail(webView, navigation);
    }
}


//MARK: - 给Block赋值
- (void)webViewLoadStart:(LoadStartBlock)start finish:(LoadFinishBlock)finish fail:(LoadFailBlock)fail{
    if (start) {
        _start = start;
    }
    if (finish) {
        _finish = finish;
    }
    if (fail) {
        _fail = fail;
    }
}

@end
