//
//  JsCoreViewController.m
//  JSCoreDemo
//
//  Created by 侑夕 on 2018/3/13.
//  Copyright © 2018年 侑夕. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>
#import "JsCoreViewController.h"
#import "Person.h"


@interface JsCoreViewController () <UIWebViewDelegate>

@end

@implementation JsCoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建webview事例
    UIWebView *myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    myWebView.delegate = self;
    //加添webview实图到控制器视图
    [self.view addSubview:myWebView];
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [myWebView loadHTMLString:html baseURL:baseURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //网页加载之前会调用此方法
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    //开始加载网页调用此方法
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //网页加载完成调用此方法

    // 在 iOS 里面执行 JS 代码
    JSContext *jsContext = [[JSContext alloc] init];
    [jsContext evaluateScript:@"var num = 500"];
    [jsContext evaluateScript:@"var computePrice = function(value){ return value * 2 }"];
    JSValue *value = [jsContext evaluateScript:@"computePrice(num)"];
    int intVal = [value toInt32];
    NSLog(@"========在 iOS 里面执行 JS 代码========");
    NSLog(@"计算结果为 %d", intVal);

     
    // 在 iOS 里面调用 JS 中方法
    jsContext = [webView valueForKeyPath:
                 @"documentView.webView.mainFrame.javaScriptContext"];
    JSValue *jsMethod = jsContext[@"nativeCallJS"];
    [jsMethod callWithArguments:@[ @"Hello JS, I am iOS" ]];
    
    
    //在 JS 里面调用 iOS 中方法
    jsContext[@"jsCallNative"] = ^() {
        NSArray *args = [JSContext currentArguments];
        NSLog(@"========在 JS 里面调用 iOS 中方法========");
        for (JSValue *obj in args) {
            NSLog(@"%@", obj);
        }
    };
    
   
    jsContext[@"log"] = ^() {
        NSArray *args = [JSContext currentArguments];
        for (id obj in args) {
            NSLog(@"%@",obj);
        }
    };

    // 通过 JSExport 暴露 iOS 方法属性给 JS
    Person *person = [[Person alloc] init];
    jsContext[@"p"] = person;
    person.firstName = @"Fei";
    person.lastName = @"Zhu";
    NSLog(@"========通过 JSExport 暴露 iOS 方法属性给 JS========");
    [jsContext evaluateScript:@"log(p.fullName());"];
    [jsContext evaluateScript:@"log(p.firstName);"];
    
    //在iOS里面处理 JS 异常
    jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        NSLog(@"JS Error: %@", exception);
    };
    NSLog(@"========在iOS里面处理 JS 异常========");
    [jsContext evaluateScript:@"(function errTest(){ return a+1; })();"];
     

}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    //网页加载失败调用此方法
}

@end
