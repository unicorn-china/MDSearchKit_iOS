//
//  ViewController.m
//  Demo
//
//  Created by 李永杰 on 2019/8/5.
//  Copyright © 2019 muheda. All rights reserved.
//

#import "ViewController.h"
#import "MDSearchDemoViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点击了" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(100, 100, 100, 30)];
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    // Do any additional setup after loading the view.
}

- (void)clickAction {
    MDSearchDemoViewController *demo = [MDSearchDemoViewController new];
    [self.navigationController pushViewController:demo animated:YES];
}

@end
