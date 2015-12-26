//
//  ManageLoginAndRegist.h
//  goShopping
//
//  Created by bobo on 15-12-7.
//  Copyright (c) 2015年 class2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManageLoginAndRegist : NSObject

@property NSMutableArray* allUersData;
@property NSMutableArray* buyyerName;
@property NSMutableArray* buyyerBoughtListFilePath;
-(id)init;
//注册，当flat是1表示商家注册，2表示买家注册
-(void)userRegist:(int)flat;
//登陆
-(void)userLogin;
//主界面
-(void)mainShow;

//商家主界面（功能选择界面）
-(void)sellerMainShow:(NSString*)sellerName;


@end
