//
//  ManageLoginAndRegist+readDataFromFiles.m
//  goShopping
//
//  Created by bobo on 15-12-16.
//  Copyright (c) 2015年 class2. All rights reserved.
//

#import "ManageLoginAndRegist+readDataFromFiles.h"

@implementation ManageLoginAndRegist (readDataFromFiles)
//读取注册文件中的用户注册信息
-(NSString*)readDataFromFile:(NSString*)path
{
    NSString* str=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return str;
}
@end
