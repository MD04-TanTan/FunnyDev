//
//  HomeVC.m
//  FunnyDev
//
//  Created by Tan Tan on 9/25/15.
//  Copyright © 2015 TanTan. All rights reserved.
//

#import "HomeVC.h"

@interface HomeVC (){
    NSMutableArray * dataSource;
}

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataSource = [[NSMutableArray alloc] init];
    [self.tbvMain reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return dataSource.count;
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cellId";
    CustomCell * cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        NSArray * arr = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell = [arr objectAtIndex:0];
    }
    cell.lblNameUser.text = @"Title 1";
    cell.lblNameUser.text = @"User 1";
    return cell;
}



@end
