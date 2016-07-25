//
//  NetworlTool.m
//  01-网易新闻架构搭建
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "NetworlTool.h"
#import <AFNetworking.h>

@implementation NetworlTool

static id _instancetype;
+(instancetype)sharedNetworlTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//      http://c.m.163.com/nc/T1348647853363

        NSURL *baseurl = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        _instancetype = [[self alloc]initWithBaseURL:baseurl];
    });
    return _instancetype;
}
@end
