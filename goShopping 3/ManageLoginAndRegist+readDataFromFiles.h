//
//  ManageLoginAndRegist+readDataFromFiles.h
//  goShopping
//
//  Created by bobo on 15-12-16.
//  Copyright (c) 2015年 class2. All rights reserved.
//

#import "ManageLoginAndRegist.h"

@interface ManageLoginAndRegist (readDataFromFiles)

//读取注册文件中的用户注册信息
-(NSString*)readDataFromFile:(NSString*)path;
@end
