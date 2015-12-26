//
//  Product.m
//  goShopping
//
//  Created by bobo on 15-12-7.
//  Copyright (c) 2015年 class2. All rights reserved.
//

#import "Product.h"

@implementation Product

//归档方法
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //依次归档相关的数据值
    [aCoder encodeObject:self.productName forKey:@"productName"];
    [aCoder encodeObject:self.productPrice forKey:@"productPrice"];
    [aCoder encodeObject:self.productDescription forKey:@"productDescription"];
    [aCoder encodeObject:self.productCount forKey:@"productCount"];
}

//解归档方法
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.productName=[aDecoder decodeObjectForKey:@"productName"];
    self.productPrice=[aDecoder decodeObjectForKey:@"productPrice"];
    self.productDescription=[aDecoder decodeObjectForKey:@"productDescription"];
    self.productCount=[aDecoder decodeObjectForKey:@"productCount"];
    return self;
}
@end
