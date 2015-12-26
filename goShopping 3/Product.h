//
//  Product.h
//  goShopping
//
//  Created by bobo on 15-12-7.
//  Copyright (c) 2015年 class2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject<NSCoding>  //遵从协议
@property(copy,nonatomic) NSString* productName;//产品名称
@property(copy,nonatomic) NSString* productPrice;//产品价格
@property(copy,nonatomic) NSString* productDescription;//产品描述
@property (copy,nonatomic)NSString* productCount;//产品库存个数
@end
