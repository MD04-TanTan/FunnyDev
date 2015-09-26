//
//  HomeVC.h
//  FunnyDev
//
//  Created by Tan Tan on 9/25/15.
//  Copyright © 2015 TanTan. All rights reserved.
//

#import "BaseVC.h"
#import "TFHpple.h"
#import "PostObject.h"

@interface HomeVC : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tbvMain;
@property NSMutableArray * dataSource;
@property NSMutableArray * arrURL;
@property NSMutableData * data;
@property PostObject * object;
@end
