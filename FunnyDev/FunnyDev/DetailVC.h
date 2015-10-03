//
//  DetailVC.h
//  FunnyDev
//
//  Created by Andy Tran on 9/27/15.
//  Copyright (c) 2015 TanTan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"

@interface DetailVC : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webviewDetail;
@property PostObject * postObject;
@end
