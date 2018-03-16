//
//  ViewController.m
//  JSPatchDemo
//
//  Created by 侑夕 on 2018/3/11.
//  Copyright © 2018年 侑夕. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak,nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label.font= [UIFont systemFontOfSize:40];
    self.label.numberOfLines = 10;
    [self simpleTest];
}

- (void)simpleTest {
    self.label.text = @"Hello World";
    self.label.textColor = [UIColor blueColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
