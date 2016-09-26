//
//  AFNetManager.h
//  AFNetWorking
//
//  Created by CORYIL on 15/11/25.
//  Copyright (c) 2015年 徐锐. All rights reserved.
//

#import  <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface AFNetManager : NSObject


+ (void)getRequestWithURL:(NSString *)url
           withParameters:(NSDictionary *)parameters
                  success:(void(^)(id response))block;


+ (void)postRequestWithURL:(NSString *)url
            withParameters:(NSDictionary *)parameters
                   success:(void(^)(id response))block;

+ (void)postMultiPartWithURL:(NSString *)url
              withParameters:(NSDictionary *)parameters
                    filePath:(NSString *)filePath
                   fieldName:(NSString *)fieldName
                     success:(void(^)(id response))block;

+ (void)downLoadRequestWithURL:(NSString *)url;

@end
