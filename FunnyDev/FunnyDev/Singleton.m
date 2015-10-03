//
//  Singleton.m
//  FunnyDev
//
//  Created by Andy Tran on 9/27/15.
//  Copyright (c) 2015 TanTan. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

+ (id)getInstance{
    static Singleton * instance = nil;
    @synchronized (self){
        if (instance == nil) {
            instance = [[Singleton alloc] init];
        }
    }
    return instance;
}

- (void)parseNumberPage{
        NSURL * posURL = [NSURL URLWithString:@"http://devvui.com"];
        NSData * posHTMLData = [NSData dataWithContentsOfURL:posURL];
        
        //2
        TFHpple * posParser = [TFHpple hppleWithHTMLData:posHTMLData];
        //3
        
        //NSString * posXpathQueryString = @"//ul[@class='nav navbar-nav navHeader']/li[1]/div/div[@class='production']/ul/li/a";
        NSString * posXpathQueryString = @"//div[@class='paging-wrap']";
        NSArray * posNodes = [posParser searchWithXPathQuery:posXpathQueryString];

        for (TFHppleElement * element in posNodes) {

            NSString* query = @"//a[2]";
            NSArray * array = [ element searchWithXPathQuery:query];
            TFHppleElement * posElement = [array firstObject];
            _iNumberPage = [[posElement content] integerValue];

        }
}
@end
