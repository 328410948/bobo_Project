//
//  ManageLoginAndRegist.m
//  goShopping
//
//  Created by bobo on 15-12-7.
//  Copyright (c) 2015年 class2. All rights reserved.
//

#import "ManageLoginAndRegist.h"
#import "LoginAndRegistData.h"
#import "Seller.h"
#import "Buyyer.h"
#import "ManageLoginAndRegist+readDataFromFiles.h"
#define PATH @"/Users/qianfeng/Desktop/bobo_Project/goShopping 3/UsersRegistData.txt"
#define _PATH_ @"/Users/qianfeng/Desktop/bobo_Project/goShopping 3/bought"
@implementation ManageLoginAndRegist
{//私有成员变量
    char userName[20];
    char passWord[20];
    char repeatPwd[20];
    char telPhone[11];
    char address[300];
    char postCode[300];
   }

-(id)init
{
    if(self=[super init])
    {
        _allUersData=[[NSMutableArray alloc]init];
        _buyyerName=[[NSMutableArray alloc]init];
        _buyyerBoughtListFilePath=[[NSMutableArray alloc]init];
    }
    return self;
}

//注册，当flat是1表示商家注册，2表示买家注册
-(void)userRegist:(int)flat
{
    //flat==1表示商家注册，flat==2表示买家注册
    NSLog(@"\nplease enter your regist userName:");
    scanf("%s",userName);
    NSLog(@"\nplease enter your regist passWord:");
    scanf("%s",passWord);
    NSLog(@"\nplease repeat your passWord:");
    scanf("%s",repeatPwd);
    NSLog(@"\nplease enter your telPhone:");
    scanf("%s",telPhone);
    NSLog(@"\nplease enter your address:");
    scanf("%s",address);
    NSLog(@"\nplease enter your postCode:");
    scanf("%s",postCode);
    
    if([[NSString stringWithUTF8String:passWord]isEqualToString:[NSString stringWithUTF8String:repeatPwd]])
    {
    
        //将用户输入的注册信息拼接成一个字符串
        NSString* UserData = [NSString stringWithFormat:@"%s %s %s %s %s %s %d\n",userName,passWord,repeatPwd,telPhone,address,postCode,flat];
    
        NSFileHandle* fh=[NSFileHandle fileHandleForWritingAtPath:PATH];
    
        //将数据写入文件
        [fh seekToEndOfFile];
        [fh writeData:[UserData dataUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"regist success!");
    
    }else
    {
        NSLog(@"regist error!");
    }
}

////读取注册文件中的用户注册信息，私有方法
//-(NSString*)readDataFromFile:(NSString*)path
//{
//     NSString* str=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    return str;
//}

//解析读取到的用户注册信息数据且保存在数据模型中，便于登陆比对，，私有方法
-(void)analysisData
{
    NSString* readStr=[self readDataFromFile:PATH];
    NSArray* userData=[readStr componentsSeparatedByString:@"\n"];
    
    for(int i=0;i<userData.count-1;i++)
    {   //创建数据模型对象，将提取出的数据存储到数据模型对象中
        NSArray* lineOfData = [userData[i] componentsSeparatedByString:@" "];
        LoginAndRegistData* u=[[LoginAndRegistData alloc]init];
        u.userName=lineOfData[0];
        u.passWord=lineOfData[1];
        u.repeatPwd=lineOfData[2];
        u.telPhone=lineOfData[3];
        u.address=lineOfData[4];
        u.postCode=lineOfData[5];
        u.userFlat=lineOfData[6];
        
        [_allUersData addObject:u];
    }
}

//登陆功能，可以区分出是商家用户还是买家用户 1 表示商家用户  2表示买家用户
-(void)userLogin
{
    [self analysisData];
    NSLog(@"\nplease enter your userName:");
    scanf("%s",userName);
    NSLog(@"\nplease enter your passWord:");
    scanf("%s",passWord);
    
    for (LoginAndRegistData* u in _allUersData) {
        static int i=0;
        if([u.userName isEqualTo:[NSString stringWithUTF8String:userName]]&&[u.passWord isEqualTo:[NSString stringWithUTF8String:passWord]])
        {   //如果判断出标识符flat是1的话，表示是商家用户，2表示是买家用户
            if([u.userFlat isEqualTo:@"1"])
            {
                NSLog(@"商家用户登陆成功");
                [self sellerMainShow:u.userName];
                
            }else
            {
                NSLog(@"买家登陆成功");
                [self buyyerMainShow:u.userName];
            }
        }else if(i==_allUersData.count-1)
        {
            NSLog(@"\nlogin error!!!");
        }
    }
}

//程序运行的主界面（功能选择界面）
-(void)mainShow
{
    NSFileManager* fm=[NSFileManager defaultManager];
    //如果文件不存在，创建该文件，否则不创建
    if([fm fileExistsAtPath:PATH]==NO)
    {
        [fm createFileAtPath:PATH contents:nil attributes:nil];
    }

    int n=0;
LOOP3:
   
    NSLog(@"\n\t\t\t*************************\n\t\t\t*   欢迎来到 goShopping   *\n\t\t\t*************************\n\t\t\t*                       *\n\t\t\t*************************\n\t\t\t* 1.登陆                 *\n\t\t\t* 2.商家注册              *\n\t\t\t* 3.买家注册              *\n\t\t\t* 4.退出                 *\n\t\t\t* 5.使用说明（必看）        *\n\t\t\t*************************\n\t\t\t*************************\n\nenter your choose:");
    
    scanf("%d",&n);
    switch (n) {
        case 1:
            [self userLogin];
            sleep(2);
            goto LOOP3;
            break;
        case 2:
            [self userRegist:n-1];
            sleep(2);
            goto LOOP3;
            break;
        case 3:
            [self userRegist:n-1];
            sleep(2);
            goto LOOP3;
            break;
        case 4:
            exit(0);
        case 5:
            [self howUse];
            break;
        default:
            NSLog(@"enter error!");
            return;
    }
    
}

//使用说明书
-(void)howUse
{
    NSLog(@"\n\n该项目为商家用户和买家用户所使用。商家商户注册可后，进行登录可拥有这几项功能：1.上架商品。2.下架商品。3.查看所有上架商品。4.查看订单（买家下单后，下单信息可以反推给相应的商家）。商家的上述几项操作结果，都是同步给买家端。买家可以实时看见商家的相关动态。\n买家注册登录后，可拥有这几项功能：1.查看所有商家，和商家的所有商品信息。2.可以下单购买。3.可以查看自己购买的购物清单。买家下单后，下单信息可以反推给相应的商家。\n");
}

//商家主界面（功能选择界面）
-(void)sellerMainShow:(NSString*)sellerName
{
    Seller* s=[[Seller alloc]init];
    s.sellerName=sellerName;
    int n=0;
LOOP:
    NSLog(@"\n\n\n\n\t\t\t1.上架\n\t\t\t2.下架\n\t\t\t3.查看所有上架商品\n\t\t\t4.查看下单信息\n\t\t\t5.退出");
    scanf("%d",&n);
    switch (n) {
        case 1:
            [s addProduct];
            sleep(3);
            goto LOOP;
            break;
        case 2:
            [s removeProduct];
            sleep(3);
            goto LOOP;
            break;
        case 3:
            [s showAllProduct];
            sleep(3);
            goto LOOP;
            break;
        case 4:
            [self showBoughtList:sellerName];
            sleep(3);
            goto LOOP;
            break;
        case 5:
            NSLog(@"即将退出......");
            sleep(3);
            exit(0);
            
        default:
            break;
    }
}

//获得所有买家姓名，因为买家的订单信息存储的文件名是包含买家姓名的，商家要遍历这些文件，查看那些买家买了自家的商品。
-(NSMutableArray*)getBuyyerName
{
    NSFileHandle* fh=[NSFileHandle fileHandleForReadingAtPath:@"/Users/qianfeng/Desktop/goShopping 3/UsersRegistData.txt"];
    NSString* readStr=[[NSString alloc]initWithData:[fh readDataToEndOfFile] encoding:NSUTF8StringEncoding];
    NSArray* arr_1=[readStr componentsSeparatedByString:@"\n"];
    for(int i=0;i<arr_1.count-1;i++)
    {
        NSArray* arr_2=[arr_1[i] componentsSeparatedByString:@" "];
        if([arr_2[6]isEqualToString:@"2"])
        {
            NSString* buyyerName = arr_2[0];
            [_buyyerName addObject:buyyerName];
        }
    }
    return _buyyerName;
}

//根据买家姓名合成买家订单存储文件的全路径
-(NSMutableArray*)getBuyyerBoughtListFilePath
{
    NSMutableArray* allNames=[self getBuyyerName];
    for (NSString* s in allNames) {
        
       NSString* path=[ NSString stringWithFormat:@"%@%@",@"/Users/qianfeng/Desktop/goShopping 3/bought",s];
        [_buyyerBoughtListFilePath addObject:path];
    }
    return _buyyerBoughtListFilePath;
}

//显示商家的订单信息
-(void)showBoughtList:(NSString*)sellerName
{
    NSMutableArray* arr=[self getBuyyerBoughtListFilePath];

    for (NSString* path in arr) {
        NSFileHandle* fh=[NSFileHandle fileHandleForReadingAtPath:path];
       NSString* readStr = [[NSString alloc]initWithData:[fh readDataToEndOfFile] encoding:NSUTF8StringEncoding];
        NSArray* arr_1=[readStr componentsSeparatedByString:@"\n"];
        
        
              for(int i=0;i<arr_1.count-1;i++)
        {
            NSArray* arr_2=[arr_1[i] componentsSeparatedByString:@" "];
            
            if([arr_2[0]isEqualToString:[NSString stringWithFormat:@"%@%@",@"sellerName:",sellerName]])
            {
                NSLog(@"订单信息如下：\n\t\t%@ %@ %@ %@",arr_2[1],arr_2[1],arr_2[2],arr_2[3]);
               // exit(0);
            }
            
        }
        
    
    }
}


//买家的主界面
-(void)buyyerMainShow:(NSString*)buyyerName
{
    //没创建一个买家用户，就创建其相对应的文件进行买家订单数据存储
    NSFileManager* fm=[NSFileManager defaultManager];
    if([fm fileExistsAtPath:[NSString stringWithFormat:@"%@%@",_PATH_,buyyerName]]==NO)
    {
        [fm createFileAtPath:[NSString stringWithFormat:@"%@%@",_PATH_,buyyerName] contents:nil attributes:nil];
        
    }

    
    Buyyer* b=[[Buyyer alloc]init];
    b.name=buyyerName;
    int n=0;
LOOP1:
    NSLog(@"\n\n\n\n\t\t\t1.显示所有商家\n\t\t\t2.下单\n\t\t\t3.查看订单\n\t\t\t4.退出");
    scanf("%d",&n);
    switch (n) {
        case 1:
            [b showAllSellerAndProductes];
            sleep(2);
            goto LOOP1;
            break;
        case 2:
            [b bought];
            sleep(2);
            goto LOOP1;
            break;
        case 3:
            [b showProductList];
            sleep(2);
            goto LOOP1;
            break;
        case 4:
            NSLog(@"即将退出......");
            sleep(2);
            exit(0);
            
            
        default:
            break;
    }

}
@end
