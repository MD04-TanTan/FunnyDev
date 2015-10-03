//
//  Singleton.h
//  FunnyDev
//
//  Created by Andy Tran on 9/27/15.
//  Copyright (c) 2015 TanTan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseVC.h"

@interface Singleton : NSObject
@property NSString * urlDetail;
@property NSInteger iNumberPage;
+(id) getInstance;
- (void) parseNumberPage;
@end
