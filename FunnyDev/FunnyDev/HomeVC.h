//
//  HomeVC.h
//  FunnyDev
//
//  Created by Tan Tan on 9/25/15.
//  Copyright © 2015 TanTan. All rights reserved.
//

#import "BaseVC.h"

@interface HomeVC : UIViewController <UITableViewDataSource,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tbvMain;

@end
