//
//  HomeVC.m
//  FunnyDev
//
//  Created by Tan Tan on 9/25/15.
//  Copyright © 2015 TanTan. All rights reserved.
//

#import "HomeVC.h"

@interface HomeVC ()
    

@end

@implementation HomeVC
@synthesize dataSource,data,object,arrURL;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataSource = [[NSMutableArray alloc] init];
    
    [self initURLwithNumberPage:100];
    [self loadPost];
    [self.tbvMain reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 255;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cellId";
    
    CustomCell * cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
       [tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:cellId];
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    }
    object = [dataSource objectAtIndex:indexPath.row];
    
    cell.lblTitle.text = object.title;
    
    cell.lblNameUser.text = object.nameUser;
    
//    NSData * imgData = [NSData dataWithContentsOfFile:object.urlImage];
//    UIImage * image= [UIImage sd_animatedGIFWithData:imgData];
//    [cell.imageViewMain setImage:image];
    
    //[cell.imageViewMain sd_setImageWithURL:[NSURL URLWithString:object.urlImage] placeholderImage:nil];
    [cell.imageViewMain sd_setImageWithURL:[NSURL URLWithString:object.urlImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"image");
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void) initURLwithNumberPage:(NSInteger) numberPage{
    arrURL = [[NSMutableArray alloc] init];
    NSString * url;
    for (int i = 1; i <= numberPage; i++) {

        url = [NSString stringWithFormat:@"%@%i",kURL,i];
        [arrURL addObject:url];
    }
    NSLog(@"%@",arrURL);
}

- (void) loadPost{
    for (int i = 0; i < arrURL.count; i++) {
        [self parsePostHTML:[arrURL objectAtIndex:i]];
        
    }
}

-(void)parsePostHTML:(NSString *) url{
    //1
    NSURL * posURL = [NSURL URLWithString:url];
    NSData * posHTMLData = [NSData dataWithContentsOfURL:posURL];

    //2
    TFHpple * posParser = [TFHpple hppleWithHTMLData:posHTMLData];
    //3
    
    //NSString * posXpathQueryString = @"//ul[@class='nav navbar-nav navHeader']/li[1]/div/div[@class='production']/ul/li/a";
    NSString * posXpathQueryString = @"//div[@class='post-content']";
    NSArray * posNodes = [posParser searchWithXPathQuery:posXpathQueryString];
    //NSLog(@"%li node",posNodes.count);
    //4
    //NSMutableArray * newProductions = [[NSMutableArray alloc] initWithCapacity:0];
    for (TFHppleElement * element in posNodes) {
        object = [[PostObject alloc ] init];
        //Title
        NSString* query = @"//h2/a";
        NSArray * array = [ element searchWithXPathQuery:query];
        TFHppleElement * posElement = [array firstObject];
        object.title = [[posElement firstChild] content];
        //NSLog(@"title %@",object.title);
        
        //UserName
        query = @"//span";
        array = [ element searchWithXPathQuery:query];
        posElement = [array firstObject];
        object.nameUser = [[posElement firstChild] content];
       // NSLog(@"name  %@",object.nameUser);
        //Image
        query = @"//img";
        array = [ element searchWithXPathQuery:query];
        posElement = [array firstObject];
        object.urlImage = [posElement objectForKey:@"src"];
        //NSLog(@"image %@",object.urlImage);
        
        [dataSource addObject:object];
    }

}




@end
