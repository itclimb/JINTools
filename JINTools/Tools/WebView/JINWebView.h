//
//  JINWebView.h
//  JINTools
//
//  Created by itclimb on 2017/7/26.
//  Copyright © 2017年 itclimb.yuancheng.com. All rights reserved.
//

#import <WebKit/WebKit.h>

typedef void(^CompleteBlock)(BOOL finished);
typedef void(^LoadStartBlock)(WKWebView *webview,WKNavigation *navigation);
typedef void(^LoadFinishBlock)(WKWebView *webview,WKNavigation *navigation);
typedef void(^LoadFailBlock)(WKWebView *webview,WKNavigation *navigation);

@interface JINWebView : WKWebView

/**
 替换url,并加载新的url

 @param url 要被替换的url
 @param newUrl 要加载的url
 @param complete 完成回调
 */
- (void)replace:(NSString *)url To:(NSString *)newUrl complete:(CompleteBlock)complete;


/**
 检测url,并加载

 @param url 要检测的url
 @param complete 完成回调
 */
- (void)check:(NSString *)url complete:(CompleteBlock)complete;


/**
 拦截url

 @param url 要拦截的url
 @param complete 完成回调
 */
- (void)intercept:(NSString *)url complete:(CompleteBlock)complete;


/**
 包含对应字符并停止加载

 @param url 包含字符
 @param complete 完成回调
 */
- (void)contain:(NSString *)url complete:(CompleteBlock)complete;

/**
 给block赋值

 @param start 开始回调
 @param finish 完成回调
 @param fail 失败回调
 */
- (void)webViewLoadStart:(LoadStartBlock)start finish:(LoadFinishBlock)finish fail:(LoadFailBlock)fail;


// 拦截其他初始化方法,只能使用指定的类方法实例化
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

@end
