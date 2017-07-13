//
//  MTAPIClient.m
//  NetServicesLayerDemo
//
//  Created by qingyun on 15/12/31.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import "MTAPIClient.h"
#import <AFHTTPSessionManager.h>

@interface MTAPIClient ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) AFNetworkReachabilityManager *netMonitor;
@property (nonatomic) MTNetworkStatus status;
@end


@implementation MTAPIClient

static MTAPIClient *_sharedClient;
static dispatch_once_t once;

+ (instancetype)sharedAPIClient {
    dispatch_once(&once, ^{
        _sharedClient = [[MTAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl]];
    });
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    
    // configration
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSString *cerPath                = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];
    NSData *certData                 = [NSData dataWithContentsOfFile:cerPath];
    self.manager.securityPolicy.allowInvalidCertificates = NO;
    [self.manager.securityPolicy setPinnedCertificates : [NSSet setWithObject:certData]];
//    self.manager.securityPolicy.SSLPinningMode = AFSSLPinningModeCertificate;
    self.manager.securityPolicy.validatesDomainName = YES;
    
    self.netMonitor = [AFNetworkReachabilityManager sharedManager];
    self.status = MTNetworkStatusWWAN;
    
    MTWeakSelf
    [self.netMonitor setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        __weakSelf.status = (MTNetworkStatus)status;
        if (status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN) {
            [__weakSelf resumeAllDataRequests];
        }else{
            [__weakSelf suspendAllDataRequests];
        }
    }];
    [self.netMonitor startMonitoring];
    
    return self;
}

#pragma mark - http(s) requests
- (void)cancelAllDataRequests{
    NSArray *tasks = self.manager.dataTasks;
    [tasks makeObjectsPerformSelector:@selector(cancel)];
}

- (void)suspendAllDataRequests{
    NSArray *tasks = self.manager.dataTasks;
    [tasks makeObjectsPerformSelector:@selector(suspend)];
}

- (void)resumeAllDataRequests{
    NSArray *tasks = self.manager.dataTasks;
    [tasks makeObjectsPerformSelector:@selector(resume)];
}

- (NSString *)stringFromNetworkMethod:(NetworkMethod)method {
    switch (method) {
        case GET:
            return @"GET";
            break;
        case POST:
            return @"POST";
            break;
        case HEAD:
            return @"HEAD";
            break;
        case PUT:
            return @"PUT";
            break;
        case DELETE:
            return @"DELETE";
            break;
        default:
            return @"Unknown HTTP Method";
            break;
    }
}

- (void)requestJSONDataWithMethod:(NetworkMethod)method
                             Path:(NSString *)path
                       parameters:(NSDictionary *)parameters
                         callback:(void (^)(id, NSError *))callback {
    // 检查网络状态
    if (_status == MTNetworkStatusUnknown || _status == MTNetworkStatusNotReachable) {
        NSString *statusStr = [self networkStatusDesc];
        MTDebugLog(@"NetStatus:%@", statusStr);
        NSError *error = [NSError errorWithDomain:@"NetStatusDomain" code:3001 userInfo:@{@"NetStatus":statusStr}];
        callback(nil, error);
        return;
    }
    
    // 入参检查
    if (!path || path.length <= 0) {
        MTDebugLog(@"Path should not be null!");
        return;
    }
    
    // 入口调试Log
    MTDebugLog(@"\n===========request===========\n%@\n%@:\n%@", [self stringFromNetworkMethod:method], path, parameters);
    
    // 入参处理(URL)
    path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // 发起请求
    switch (method) {
        case GET: {
            [self.manager GET:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                MTDebugLog(@"\n===========response===========\n%@:\n%@", path, responseObject);
                callback(responseObject, nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                MTDebugLog(@"\n===========response===========\n%@:\n%@", path, error);
                callback(nil, error);
            }];
            break;
        }
        case POST: {
            [self.manager POST:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                MTDebugLog(@"\n===========response===========\n%@:\n%@", path, responseObject);
                callback(responseObject, nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                MTDebugLog(@"\n===========response===========\n%@:\n%@", path, error);
                callback(nil, error);
            }];
            break;
        }
        case HEAD: {
            /**
             *  TODO:
             */
            break;
        }
        case PUT: {
            /**
             *  TODO:
             */
            break;
        }
        case DELETE: {
            /**
             *  TODO:
             */
            break;
        }
        default:
            break;
    }
}

- (NSData *)dataWithCompressedImage:(UIImage *)image {
    NSData *data;
    data = UIImageJPEGRepresentation(image, 1.0);
    if ((float)data.length/1024/1024 > 1.0) {
        data = UIImageJPEGRepresentation(image, 1024*1024*1.0/(float)data.length);
    }
    
    return data;
}

- (void)requestJSONDataWithPath:(NSString *)path
                     parameters:(NSDictionary *)parameters
                       fileInfo:(NSDictionary *)fileInfo
                       callback:(void (^)(id, NSError *))callback {
    
    // 检查网络状态
    if (_status == MTNetworkStatusUnknown || _status == MTNetworkStatusNotReachable) {
        NSString *statusStr = [self networkStatusDesc];
        MTDebugLog(@"NetStatus:%@", statusStr);
        NSError *error = [NSError errorWithDomain:@"NetStatusDomain" code:3001 userInfo:@{@"NetStatus":statusStr}];
        callback(nil, error);
        return;
    }
    
    // 入参检查
    if (!path || path.length <= 0) {
        MTDebugLog(@"Path should not be null!");
        return;
    }
    
    if (!fileInfo) {
        MTDebugLog(@"FileInfo should not be null!");
        return;
    }
    
    // 入口调试Log
    MTDebugLog(@"\n===========request===========\n%@:\n%@", path, parameters);
    
    // 入参处理(URL)
    path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    // 取出fileInfo name/fileName/mimeType/image/...
    NSString *name = fileInfo[@"name"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *timestamp = [formatter stringFromDate:[NSDate date]];
    NSString *defaultFileName = [NSString stringWithFormat:@"%@.jpg", timestamp];
    NSString *fileName = fileInfo[@"fileName"] == nil ? defaultFileName : fileInfo[@"fileName"];
    
    NSString *defaultMIMEType = @"image/jpeg";
    NSString *mimeType = fileInfo[@"mimeType"] == nil ? defaultMIMEType : fileInfo[@"mimeType"];
    
    BOOL imagesIsArray = NO;
    // 如果上传的是图片，可能需要对图片的大小进行压缩 (<= 1M)
    id images = fileInfo[@"image"];
    if ([images isKindOfClass:[UIImage class]]) {
        UIImage *image = fileInfo[@"image"];
        NSData *data = [self dataWithCompressedImage:image];
        images = data;
    } else if ([images isKindOfClass:[NSArray class]]) {
        imagesIsArray = YES;
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (UIImage *image in images) {
            NSData *data = [self dataWithCompressedImage:image];
            [tmpArr addObject:data];
        }
        images = tmpArr;
    }
    
    // 如果上传的是其他文件，则转换为NSData对象
    id video = fileInfo[@"video"];
    NSData *data = [NSData dataWithContentsOfFile:video];
    video = data;
    
    // 发起请求
    [self.manager POST:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (images) {
            if (imagesIsArray) {
                for (NSData *data in images) {
                    [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
                }
            } else {
                [formData appendPartWithFileData:images name:name fileName:fileName mimeType:mimeType];
            }
        }else if (video){
            [formData appendPartWithFileData:video name:name fileName:fileName mimeType:mimeType];
        }
        
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MTDebugLog(@"\n===========response===========\n%@:\n%@", path, responseObject);
        callback(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MTDebugLog(@"\n===========response===========\n%@:\n%@", path, error);
        callback(nil, error);
    }];
}

- (void)uploadImage:(UIImage *)image
               path:(NSString *)path
               name:(NSString *)name
           callback:(void(^)(id, NSError *))callback
           progress:(void (^)(CGFloat progressValue))progress {
    
    // 检查网络状态
    if (_status == MTNetworkStatusUnknown || _status == MTNetworkStatusNotReachable) {
        NSString *statusStr = [self networkStatusDesc];
        MTDebugLog(@"NetStatus:%@", statusStr);
        NSError *error = [NSError errorWithDomain:@"NetStatusDomain" code:3001 userInfo:@{@"NetStatus":statusStr}];
        callback(nil, error);
        return;
    }
    
    
    // 入参检查
    if (!path || path.length <= 0) {
        MTDebugLog(@"Path should not be null!");
        return;
    }
    
    if (!image) {
        MTDebugLog(@"Image should not be null!");
        return;
    }
    
    if (!name || name.length <= 0) {
        MTDebugLog(@"Name should not be null!");
        return;
    }
    
    // 入口调试Log
    MTDebugLog(@"\n===========upload image===========\n%@:\n%@", path, name);
    
    // 入参处理(URL)
    path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // 如果图片内容过大（>1M），则需要压缩
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    if ((float)data.length/1024/1024 > 1.0) {
        data = UIImageJPEGRepresentation(image, 1024*1024*1.0/(float)data.length);
    }
    
    // 自动生成fileName
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *timestamp = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", timestamp];
    MTDebugLog(@"\nUploadImage\n%@ : %.2fK", fileName, (float)data.length/1024);
    
    // 开始上传
    [self.manager POST:path parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            dispatch_async(dispatch_get_main_queue(), ^{
                progress(uploadProgress.fractionCompleted);
            });
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MTDebugLog(@"Success: %@", responseObject);
        callback(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MTDebugLog(@"Error: %@",error);
        callback(nil, error);
    }];
}

- (void)downloadVideoWithPath:(NSString *)path
                     progress:(void (^)(CGFloat progressValue))progress
                     callback:(void(^)(NSURL *fullPath, NSError *error))callback{
    // 检查网络状态
    if (_status == MTNetworkStatusUnknown || _status == MTNetworkStatusNotReachable) {
        NSString *statusStr = [self networkStatusDesc];
        MTDebugLog(@"NetStatus:%@", statusStr);
        NSError *error = [NSError errorWithDomain:@"NetStatusDomain" code:3001 userInfo:@{@"NetStatus":statusStr}];
        callback(nil, error);
        return;
    }
    
    // 入参检查
    if (!path || path.length <= 0) {
        MTDebugLog(@"Path should not be null!");
        return;
    }
    
    // 入口调试Log
    MTDebugLog(@"\n===========download video===========\n%@", path);
    
    // 入参处理(URL)
    path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // 生成视频存储路径
    NSArray *strings = [path componentsSeparatedByString:@"/"];
    NSString *name = strings.lastObject;
    NSString  *fullPath = [NSString stringWithFormat:@"%@/%@", kDocumentPath, name];
    
    //开始下载
    NSURL *url = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *task = [self.manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            dispatch_async(dispatch_get_main_queue(), ^{
                MTDebugLog(@"Progress: %f", downloadProgress.fractionCompleted);
                progress(downloadProgress.fractionCompleted);
            });
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:fullPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        MTDebugLog(@"Error: %@",error);
        callback(filePath, error);
    }];
    [task resume];
}

#pragma mark - network status
- (MTNetworkStatus)networkStatus {
    return _status;
}

- (NSString *)networkStatusDesc {
    NSString *statusStr;
    switch (_status) {
        case MTNetworkStatusTimeout:
            statusStr = @"网络请求超时";
            break;
        case MTNetworkStatusUnknown:
            statusStr = @"网络未知";
            break;
        case MTNetworkStatusNotReachable:
            statusStr = @"网络不可达";
            break;
        case MTNetworkStatusWWAN:
            statusStr = @"2G/3G/4G";
            break;
        case MTNetworkStatusWiFi:
            statusStr = @"Wi-Fi";
            break;
        default:
            break;
    }
    return statusStr;
}

@end
