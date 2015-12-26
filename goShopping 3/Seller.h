//
//  Seller.h
//  goShopping
//
//  Created by bobo on 15-12-7.
//  Copyright (c) 2015年 class2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Seller : NSObject

//保存商品对象的对象的引用
@property(copy,nonatomic) NSMutableArray* allProduct;
//买家姓名
@property(copy,nonatomic) NSString* sellerName;

//将商家商家的信息传递给所有买家
@property(copy) void(^block)(void);
-(id)init;

//上架商品，且将商品信息保存到磁盘文件中
-(void)addProduct;
//下架商品
-(void)removeProduct;
//展示所有商品信息
-(void)showAllProduct;


@end
