//
//  ZYNetworkClient.m
//  ZYSignContractPro
//
//  Created by 飞之翼 on 2019/6/29.
//  Copyright © 2019 飞之翼. All rights reserved.
//


#import "ZYNetworkClient.h"

static ZYNetworkClient *_sharedHTTPClient = nil;
static NSString *baseUrl = @"http://www.baidu.com";


@implementation ZYNetworkClient


+ (instancetype)sharedHTTPClient {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self initHTTPClient];
        
    });
    
    return _sharedHTTPClient;
}
+ (void)initHTTPClient{
    
    _sharedHTTPClient = [[ZYNetworkClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    _sharedHTTPClient.currentState = -1;
    
    [_sharedHTTPClient.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case 1:
                _sharedHTTPClient.currentState = 1;
                NSLog(@"-------AFNetworkReachabilityStatusReachableViaWWAN------");
                break;
            case 2:
                _sharedHTTPClient.currentState = 2;
                NSLog(@"-------AFNetworkReachabilityStatusReachableViaWiFi------");
                break;
            case 0:
                _sharedHTTPClient.currentState = 0;
                NSLog(@"-------AFNetworkReachabilityStatusNotReachable------");
                break;
            default:
                break;
        }
    }];
    [_sharedHTTPClient.reachabilityManager startMonitoring];
}
-(instancetype)initWithBaseURL:(nullable NSURL *)url{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain", nil];
    
    self.requestSerializer                         = [AFHTTPRequestSerializer serializer];
    self.responseSerializer                        = [AFHTTPResponseSerializer serializer];
    self.requestSerializer.timeoutInterval         = 20.0;
    //    self.securityPolicy.allowInvalidCertificates   = YES;//忽略https证书
    //    self.securityPolicy.validatesDomainName        = NO;//是否验证域名
    AFSecurityPolicy *securityPolicy               = [AFSecurityPolicy policyWithPinningMode:0];
    securityPolicy.allowInvalidCertificates        = YES;
    
    securityPolicy.validatesDomainName             = NO;
    self.securityPolicy                            = securityPolicy;
    
    
    return self;
}
@end
