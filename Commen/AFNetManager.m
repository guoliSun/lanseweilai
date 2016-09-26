//
//  AFNetManager.m
//  AFNetWorking
//
//  Created by CORYIL on 15/11/25.
//  Copyright (c) 2015年 徐锐. All rights reserved.
//

#import "AFNetManager.h"


@implementation AFNetManager

#pragma mark - GET请求

+ (void)getRequestWithURL:(NSString *)url
           withParameters:(NSDictionary *)parameters
                  success:(void(^)(id response))block{

    //1.Manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //2.发起get请求
    [manager GET:url
      parameters:parameters
         success:^(AFHTTPRequestOperation * operation, id responseObject) {
             
             //请求成功
             /*
                id responseObject --> 返回的数据
              */
//             NSLog(@"GET 请求成功!");
             block(responseObject);
             
             
         } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
             //请求失败
             NSLog(@"GET 失败,错误信息: %@",error);
         }];

}

#pragma mark - POST请求

+ (void)postRequestWithURL:(NSString *)url
           withParameters:(NSDictionary *)parameters
                   success:(void(^)(id response))block{

    //1.
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //2.发起post请求
    [manager POST:url
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              //请求成功
              /*
               id responseObject --> 返回的数据
               */
              NSLog(@"POST 请求成功!");
              block(responseObject);
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
              //请求失败
              NSLog(@"POST 失败,错误信息: %@",error);
    }];


}

#pragma mark - POST上传

+ (void)postMultiPartWithURL:(NSString *)url
              withParameters:(NSDictionary *)parameters
                    filePath:(NSString *)filePath
                   fieldName:(NSString *)fieldName
                     success:(void(^)(id response))block{
    
    //1.
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    /*_________ ✅设置请求头(根据情况可选) ______________________________________________________*/

//    //1⃣️设置请求类型
//    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
//    
//    //请求头
//    [requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
//    
//    manager.requestSerializer = requestSerializer;
//    
//    //2⃣️设置响应信息类型
//    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    //2.post
    [manager POST:url
       parameters:parameters
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    
    //添加上传的数据
//    ❌NSURL *fileURL = [NSURL URLWithString:filePath];
    
    //通过路径字符串获取本地文件URL
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    
    [formData appendPartWithFileURL:fileURL name:fieldName error:nil];
        
    }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              //请求成功
              /*
               id responseObject --> 返回的数据
               */
              NSLog(@"上传 请求成功!");
              block(responseObject);
        
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
              //请求失败
              NSLog(@"上传失败,错误信息: %@",error);
    }];

}

#pragma mark - 4.下载任务

+ (void)downLoadRequestWithURL:(NSString *)url{
    
    
    //1.配置
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //2.request
    NSURL *requestURL = [NSURL URLWithString:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
    
    //3.manager 下载任务管理器
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:config];
    
    //4.下载任务task
    
    NSProgress *progress = nil;
    
    NSURLSessionDownloadTask *downTask = [manager downloadTaskWithRequest:request progress:&progress destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        /*
            targetPath
            response
         */
        NSLog(@"download : \ntargetPath->%@ \nresponse->%@",targetPath,response);
        
        /*_____ 指定文件保存的位置 __________________________________________________________*/
        
        NSString *path = [NSHomeDirectory()stringByAppendingString:@"/Documents/dog.jpg"];
        
        NSLog(@"path %@",path);
        NSURL *url = [NSURL fileURLWithPath:path];
        
        return url;//<-------返回一个你想要存放的路径信息
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        //下载完成
        NSLog(@"complete : \nresponse->%@ \nfilepath->%@ \nerror->%@",response,filePath,error);
        
    }];
    
    
    //5.开始任务
    [downTask resume];

}




@end
