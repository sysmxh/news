//
//  NetworlTool.h
//  01-网易新闻架构搭建
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface NetworlTool : AFHTTPSessionManager
+(instancetype)sharedNetworlTool;
@end
