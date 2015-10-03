//
//  DetailVC.m
//  FunnyDev
//
//  Created by Andy Tran on 9/27/15.
//  Copyright (c) 2015 TanTan. All rights reserved.
//

#import "DetailVC.h"

@interface DetailVC ()

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _postObject = [Singleton getInstance];
    NSString * url = _postObject.urlDetail;
    NSURLRequest * req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webviewDetail loadRequest:req];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
