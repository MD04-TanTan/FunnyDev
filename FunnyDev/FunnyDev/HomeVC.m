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
    
    [[Singleton getInstance] parseNumberPage];
    NSInteger number = [[Singleton getInstance] iNumberPage];
    [self initURLwithNumberPage:number];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        //thread moi de load data
        
        [self loadPost];
        dispatch_async(dispatch_get_main_queue(), ^{
            //tra du lieu ve main thread
            [self.tbvMain reloadData];
            self.indicatorProcess.hidden = YES;

        });
    });
    
    //[self loadPost];
//    [self.tbvMain reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"%i",dataSource.count);
    return dataSource.count;
    //return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cellId";
    
    CustomCell * cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:cellId ];
    if (cell==nil) {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = [nib firstObject];
        NSLog(@"aaaa");
    }
    object = [dataSource objectAtIndex:indexPath.row];
    
    cell.lblTitle.text = object.title;
    
    cell.lblNameUser.text = object.nameUser;
 
    
    [cell.imageViewMain sd_setImageWithURL:[NSURL URLWithString:object.urlImage] placeholderImage:[UIImage imageNamed:@"no-image-available.jpg"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"image %li",indexPath.row);
    
    }];
    [cell.imageViewMain sd_setImageWithURL:[NSURL URLWithString:object.urlImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"image %li",indexPath.row);
        
    }];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    object = [dataSource objectAtIndex:indexPath.row];
    Singleton * singleton = [Singleton getInstance];
    singleton.urlDetail = object.urlDetail;
    [self performSegueWithIdentifier:@"pushDetail" sender:object];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"pushDetail"]) {
        DetailVC * detail = segue.destinationViewController;
        detail.postObject = sender;
    }
}

- (void) initURLwithNumberPage:(NSInteger) numberPage{
    arrURL = [[NSMutableArray alloc] init];
    NSString * url;
    for (int i = 1; i <= numberPage; i++) {

        url = [NSString stringWithFormat:@"%@%i",kURL,i];
        [arrURL addObject:url];
    }
    //NSLog(@"%@",arrURL);
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
        object.urlDetail = [posElement objectForKey:@"href"];
        //NSLog(@"title %@",object.title);
        
        
        //UserName /* by\n                    Lao Nam */                    "
        query = @"//span";
        array = [ element searchWithXPathQuery:query];
        posElement = [array firstObject];
         NSString * strName= [[posElement firstChild] content];
        object.nameUser = [NSString stringWithFormat:@"-- by %@ --",[strName substringWithRange:NSMakeRange(26, 7)]];
        //NSLog(@"name  %i",object.nameUser.length);
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
