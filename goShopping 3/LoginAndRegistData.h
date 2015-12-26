//
//  LoginAndRegistData.h
//  goShopping
//
//  Created by bobo on 15-12-7.
//  Copyright (c) 2015年 class2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginAndRegistData : NSObject

@property(copy,nonatomic) NSString* userName;
@property(copy,nonatomic) NSString* passWord;
@property(copy,nonatomic) NSString* repeatPwd;
@property(copy,nonatomic) NSString* address;
@property(copy,nonatomic) NSString* telPhone;
@property(copy,nonatomic) NSString* userFlat;   //权限标记
@property(copy,nonatomic) NSString* postCode;

-(id)init;

@end
