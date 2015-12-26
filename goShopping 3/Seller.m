//
//  Seller.m
//  goShopping
//
//  Created by bobo on 15-12-7.
//  Copyright (c) 2015年 class2. All rights reserved.
//

#import "Seller.h"
#import "Product.h"
#import "ManageLoginAndRegist.h"
//存储产品相关信息文件路径
#define PATH @"/Users/qianfeng/Desktopbobo_Project//goShopping 3/productData"
@implementation Seller
{//私有成员变量
    char name[50];
    char price[10];
    char description[500];
    char count[10];
}

-(id)init
{
    if(self=[super init])
    {
        _allProduct=[[NSMutableArray alloc]init];
    }
    return self;
}

//上架商品，且将商品信息保存到磁盘文件中，该方法可连续上架多个商品。
-(void)addProduct
{
     char y_n;
LOOP:
    NSLog(@"\n请输入上架商品名称:");
    scanf("%s",name);
    NSLog(@"\n请输入商品售价:");
    scanf("%s",price);
    NSLog(@"\n请输入商品描述:");
    scanf("%s",description);
    NSLog(@"请输入商品库存:");
    scanf("%s",count);
    
    Product* p=[[Product alloc]init];
    p.productName=[NSString stringWithUTF8String:name];
    p.productPrice=[NSString stringWithUTF8String:price];
    p.productDescription=[NSString stringWithUTF8String:description];
    p.productCount=[NSString stringWithUTF8String:count];
    
    [_allProduct addObject:p];
    NSLog(@"%@ 已经被成功上架，是否继续上架其他商品？（Y/N）",p.productName);
    scanf(" %c",&y_n);
    if(y_n=='y' || y_n=='Y')
        goto LOOP; //用goto实现程序定向跳转
    else
    {
        [self saveData];//上架成功后保存商品信息
    }
}



//归档商品对象信息
-(void)saveData
{
    
    NSMutableData* data=[[NSMutableData alloc]init];
    NSKeyedArchiver* aCoder=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [aCoder encodeObject:_allProduct forKey:@"_allProduct"];
    [aCoder encodeObject:_sellerName forKey:@"_sellerName"];
    [aCoder finishEncoding];
    [data writeToFile:[NSString stringWithFormat:@"%@%@",PATH,_sellerName] atomically:YES];
}
-(NSMutableArray*)readData
{
        //解归档，读取数据
    NSData* data=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@%@",PATH,_sellerName]];
    NSKeyedUnarchiver* a=[[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    _allProduct=[a decodeObjectForKey:@"_allProduct"];
    _sellerName=[a decodeObjectForKey:@"_sellerName"];
    [a finishDecoding];
    return _allProduct;
}

//下架商品，然后将商品信息从文件中删除，然后更新文件
-(void)removeProduct
{
    NSLog(@"请输入要下架商品名称:");
    scanf("%s",name);
    
    //解析归档数据
    _allProduct=[self readData];
    
    for (Product* p in _allProduct) {
        
        if([[NSString stringWithUTF8String:name]isEqualTo:p.productName])
        {
            //将下架商品删除后，重新归档，保存数据
            [_allProduct removeObject:p];
            [self saveData];
            break;
        }
    }
    
   }
-(void)showAllProduct
{
    //解析归档数据
   _allProduct = [self readData];
    
    for (Product* p in _allProduct) {
        NSLog(@"商品详情如下：\nsellerName:%@,name:%@,price:%@,description:%@,count:%@",_sellerName,p.productName,p.productPrice,p.productDescription,p.productCount);
       
    }
}


@end
