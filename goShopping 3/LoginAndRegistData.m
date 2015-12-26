//
//  LoginAndRegistData.m
//  goShopping
//
//  Created by bobo on 15-12-7.
//  Copyright (c) 2015年 class2. All rights reserved.
//

#import "LoginAndRegistData.h"

@implementation LoginAndRegistData
-(id)init
{
    if(self=[super init])
    {
        _userFlat=nil;
        _userName=nil;
        _passWord=nil;
        _repeatPwd=nil;
        _address=nil;
        _postCode=nil;
        _telPhone=nil;
        
    }
    return self;
}
@end
