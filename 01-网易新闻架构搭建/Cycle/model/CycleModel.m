//
//  CycleModel.m
//  01-网易新闻架构搭建
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CycleModel.h"
#import "NetworlTool.h"


@implementation CycleModel
//字典转模型
+(instancetype)CycleModelWithDic:(NSDictionary *)dic
{
    CycleModel *model = [[CycleModel alloc]init];
    //KVC
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
//下载方法
+(void)loadCycleDataWithUrlstr:(NSString *)urlstr successBlock:(void(^)(NSArray *listArr))successBlock failBlock:(void (^)(NSError *error))failBlock
{
    [[NetworlTool sharedNetworlTool]GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
//        NSLog(@"%@",responseObject);
        
        //取出key
        NSString *key = responseObject.keyEnumerator.nextObject;
        //数组
        NSArray *arr = [responseObject objectForKey:key];
        //可变数组
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        
        //遍历arr
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //模型
            CycleModel *model = [self CycleModelWithDic:obj];
            //模型添加到可变的数组里面
            [arrM addObject:model];
        }];
        
        //判断successBlock是否已经实现
        if (successBlock) {
            successBlock(arrM.copy);
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failBlock) {
            failBlock(error);
        }
    }];
}
@end
