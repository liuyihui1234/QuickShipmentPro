//
//  ZYNetworkHelper.m
//  ZYSignContractPro
//
//  Created by 飞之翼 on 2019/6/29.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZYNetworkHelper.h"
#import "ZYNetworkClient.h"
#import "ZYNetworkCache.h"
@interface ZYNetworkHelper ()

@end

@implementation ZYNetworkHelper

static ZYNetworkHelper *shareManager = nil;
#pragma mark- AFHTTPSessionManager单利
+ (ZYNetworkHelper *)shareHttpManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[self alloc] init];
    });
    return shareManager;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [super allocWithZone:zone];
    });
    return shareManager;
}
/***********普通请求***********/
- (void)requsetWithUrl:(NSString *)url withParams:(NSDictionary *)params withCacheType:(ZYClientRequestCachePolicy)cacheType withRequestType:(ZYNetworkRequestType)type withResult:(ZYBlock)resultBlock {
    
    switch (type) {
        case ZYNetworkTypeGet:
        {
            // 响应缓存数据
            [self getCache:cacheType url:url params:params withResult:resultBlock];
            if (self.result) {
                return;
            }
            [[ZYNetworkClient sharedHTTPClient] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                if (responseObject) {
                    [ZYNetworkCache setHttpCache:dict URL:url parameters:params];
                }
                [self handleRequestResultWithDataTask:task responseObject:dict error:nil resultBlock:resultBlock];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [self handleRequestResultWithDataTask:task responseObject:nil error:error resultBlock:resultBlock];
            }];
        }
            break;
        case ZYNetworkTypePost:
        {
            // 响应缓存数据
            [self getCache:cacheType url:url params:params withResult:resultBlock];
            if (self.result) {
                return;
            }
           NSString *token = [NSString stringWithFormat:@"%@",[ZYTools getTokenWithKey:FZ_YTOKEN]];
           [[ZYNetworkClient sharedHTTPClient].requestSerializer setValue:token forHTTPHeaderField:@"token"];
            [[ZYNetworkClient sharedHTTPClient] POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                if (responseObject) {
                    //对数据进行异步缓存
                    [ZYNetworkCache setHttpCache:dict URL:url parameters:params];
                }
                //如果请求成功，则回调dic
                ZY_Network_Model *network_Model = [ZY_Network_Model mj_objectWithKeyValues:dict];
              
                if (network_Model.code == 401){
                  
                    NSDictionary *dic = [NSDictionary dictionaryWithObject:network_Model.msg forKey:@"msgcode"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginToken" object:nil userInfo:dic];
                }

                [self handleRequestResultWithDataTask:task responseObject:dict error:nil resultBlock:resultBlock];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [self handleRequestResultWithDataTask:task responseObject:nil error:error resultBlock:resultBlock];
            }];
        }
            break;
        default:
            break;
    }
}

// 响应缓存
- (void)getCache:(ZYClientRequestCachePolicy)cacheType url:(NSString *)url params:(NSDictionary *)params withResult:(ZYBlock)resultBlock {
    id object = [ZYNetworkCache httpCacheForURL:url parameters:params];
    NSError *error = nil;
    if (object) {
        if (cacheType == ZYClientRequestCacheDataIgnore) {//忽略缓存，重新请求
            self.result = NO;
        } else if (cacheType == ZYClientRequestCacheDataNoLoad) {//有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
    
            if (object) {
                resultBlock(object,error);
            }
            self.result = YES;
        } else if (cacheType == ZYClientRequestCacheDataElseLoad) {//有缓存就用缓存，没有缓存就重新请求(用于数据不变时)
            if (object) {
                resultBlock(object,error);
            }
            self.result = YES;
            
        } else if (cacheType == ZYClientRequestCacheDataAndLoad) {///有缓存就先返回缓存，同步请求数据
            if (object) {
                resultBlock(object,error);
            }
            self.result = NO;
        }
    }
}
// 数据回调
- (void)handleRequestResultWithDataTask:(NSURLSessionDataTask *)task responseObject:(id)responseObject error:(NSError *)error resultBlock:(ZYBlock)resultBlock {
    if(resultBlock) {
    
        resultBlock(responseObject,error);
    }
}

//获取网络缓存的总大小 bytes(字节)
+ (NSInteger)getAllHttpCacheSize{
    return [ZYNetworkCache getAllHttpCacheSize];
}

//删除所有网络缓存,
+ (void)removeAllHttpCache{
    [ZYNetworkCache removeAllHttpCache];
}
//上传视频
- (void)uploadVideoWithUrl:(NSString *)url withToken:(NSString *)token withVideoData:(NSData *)videoData withVideoName:(NSString *)videoName withResult:(ZYBlock)resultBlock {
    [[ZYNetworkClient sharedHTTPClient].requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [[ZYNetworkClient sharedHTTPClient] POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:videoData name:@"file" fileName:videoName mimeType:@"video/mp4"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        self.videoUploadProgress = [NSString stringWithFormat:@"%.2f",1.0*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleRequestResultWithDataTask:task responseObject:responseObject error:nil resultBlock:resultBlock];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleRequestResultWithDataTask:task responseObject:nil error:error resultBlock:resultBlock];
    }];
}
//上传图片
-(void)uploadPicturesWithUrl:(NSString*)url withToken:(NSString *)token withImage:(UIImage*)image withResult:(ZYBlock)resultBlock{
    [[ZYNetworkClient sharedHTTPClient].requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [[ZYNetworkClient sharedHTTPClient] POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = [self imageWithImage:image];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleRequestResultWithDataTask:task responseObject:responseObject error:nil resultBlock:resultBlock];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleRequestResultWithDataTask:task responseObject:nil error:error resultBlock:resultBlock];
    }];
}

//图片压缩
- (NSData *)imageWithImage:(UIImage*)newImage{
    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(newImage, 0.1);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(newImage, 0.5);
        }else if (data.length>200*1024) {//0.25M-0.5M
            data=UIImageJPEGRepresentation(newImage, 0.9);
        }
    }
    return data;
}
@end
