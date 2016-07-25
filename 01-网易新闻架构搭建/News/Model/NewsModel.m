//
//  NewsModel.m
//  01-网易新闻架构搭建
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "NewsModel.h"
#import "NetworlTool.h"

@implementation NewsModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
+(instancetype)NewsModelWithDic:(NSDictionary *)dic
{
    NewsModel *model = [[NewsModel alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
+(void)downloadWithUrlstr:(NSString *)urlstr successBlock:(void(^)(NSArray *arr))successBlock failureBlock:(void(^)(NSError *error))failureBlock
{
    
    NSLog(@"NewsModel  %@",urlstr);
    [[NetworlTool sharedNetworlTool]GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
        NSDictionary *dic = responseObject;
        NSString *key = dic.keyEnumerator.nextObject;

//        [dic.allKeys lastObject];
//        NSLog(@"key %@",key);
        NSArray *arr = [dic objectForKey:key];
        //可变数组
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        //遍历arr
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NewsModel *model = [self NewsModelWithDic:obj];
            [arrM addObject:model];
        }];
        
        if (successBlock) {
            successBlock(arrM.copy);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}
@end
