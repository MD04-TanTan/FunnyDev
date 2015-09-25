//
//  CustomCell.h
//  FunnyDev
//
//  Created by Tan Tan on 9/25/15.
//  Copyright © 2015 TanTan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblNameUser;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewMain;

@end
