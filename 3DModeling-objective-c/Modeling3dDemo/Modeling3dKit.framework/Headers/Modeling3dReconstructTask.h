//
//  Modeling3dTask.h
//  3DMagicObjReconstructDemo
//
//  Created by zy on 2021/8/11.
//

#import <Foundation/Foundation.h>
#import "Modeling3dReconstructConstants.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^failureBlock)(NSInteger retCode, NSString *retMsg);

@class Modeling3dReconstructTaskModel;
@interface Modeling3dReconstructTask : NSObject

/** taskType 0、物体重建 1、材质生成 默认为0 */
@property (nonatomic, assign) NSInteger taskType; 

+ (instancetype)sharedManager;


/// 初始化SDK
- (void)initSDK;

/// 初始化Task
/// @param taskConfig 任务配置参数 详见InitTaskConfig枚举
/// @param successHandler 成功回调 返回Modeling3dTaskModel对象
/// @param failureHandler 失败回调 retCode:错误码 retMsg错误信息
- (void)initTaskWithTaskConfig:(InitTaskConfig)taskConfig
                successHandler:(void(^)(Modeling3dReconstructTaskModel *taskModel))successHandler
                failureHandler:(failureBlock)failureHandler;


/// 删除Task
/// @param taskId taskId
/// @param successHandler 成功回调
/// @param failureHandler 失败回调 retCode:错误码 retMsg错误信息
- (void)deleteTaskWithTaskId:(NSString *)taskId
              successHandler:(void(^)(void))successHandler
              failureHandler:(failureBlock)failureHandler;


/// 查询Task状态
/// @param taskId taskId
/// @param successHandler 成功回调 返回QueryTaskStatus枚举
/// @param failureHandler 失败回调 retCode:错误码 retMsg错误信息
- (void)queryTaskWithTaskId:(NSString *)taskId
             successHandler:(void(^)(QueryTaskStatus taskStatus, NSString *errorMsg))successHandler
             failureHandler:(failureBlock)failureHandler;


/// 限制Task
/// @param taskId taskId
/// @param isCancel 添加限制和取消限制的标识 isCancel: 0-添加 1-取消
/// @param successHandler 成功回调
/// @param failureHandler 失败回调 retCode:错误码 retMsg错误信息
- (void)restrictionWithTaskId:(NSString *)taskId
                     isCancel:(BOOL)isCancel
               successHandler:(void(^)(void))successHandler
               failureHandler:(failureBlock)failureHandler;


/// 查询Task的限制状态
/// @param taskId taskId
/// @param successHandler 成功回调 返回TaskRestrictStatus枚举
/// @param failureHandler 失败回调 retCode:错误码 retMsg错误信息
- (void)queryRestrictionWithTaskId:(NSString *)taskId
                    successHandler:(void(^)(TaskRestrictStatus restrictFlag))successHandler
                    failureHandler:(failureBlock)failureHandler;


/// 下载Task
/// @param taskId taskId
/// @param downloadFormat 下载格式：目前支持OBJ、GLTF
/// @param successHandler 成功回调
/// @param progressHandler 进度回调
/// @param failureHandler 失败回调 retCode:错误码 retMsg错误信息
- (void)downloadTaskWithTaskId:(NSString *)taskId
                downloadFormat:(TaskDownloadFormat)downloadFormat
                successHandler:(void(^)(void))successHandler
               progressHandler:(void(^)(float progressValue))progressHandler
                failureHandler:(failureBlock)failureHandler;


/// 预览Task
/// @param taskId taskId
/// @param successHandler 成功回调
/// @param failureHandler 失败回调 retCode:错误码 retMsg错误信息
- (void)previewTaskWithTaskId:(NSString *)taskId
               successHandler:(void(^)(void))successHandler
               failureHandler:(failureBlock)failureHandler;


/// 上传文件
/// @param taskModel Init获取到的Modeling3dTaskModel对象
/// @param imageAssets 选择的图片素材数组(NSArray<UIImage *> *)数组内为UIImage对象
/// @param fileHandleProgress 上传阶段回调
/// @param successHandler 成功回调
/// @param progressHandler 进度回调
/// @param failureHandler 失败回调 retCode:错误码 retMsg错误信息
- (void)uploadTaskWithTaskModel:(Modeling3dReconstructTaskModel *)taskModel
                    imageAssets:(NSArray<UIImage *> *)imageAssets
             fileHandleProgress:(void(^)(UploadProgress progress))fileHandleProgress
                 successHandler:(void(^)(void))successHandler
                progressHandler:(void(^)(float progressValue))progressHandler
                 failureHandler:(failureBlock)failureHandler;


/// 取消上传
/// @param taskId taskId
/// @param completeHandler 完成回调 retCode:错误码 retMsg错误信息
- (void)cancelUploadTaskWithTaskId:(NSString *)taskId
                   completeHandler:(void(^)(NSInteger retCode, NSString *retMsg))completeHandler;


/// 取消下载
/// @param completeHandler 完成回调 retCode:错误码 retMsg错误信息
- (void)cancelDownloadTaskWithTaskId:(NSString *)taskId
                     completeHandler:(void(^)(NSInteger retCode, NSString *retMsg))completeHandler;


/// 下载模型转换为指定格式
/// @param taskId 任务ID
/// @param fileFormat 目标格式类型
/// @param successHandler 成功回调
/// @param failureHandler 失败回调
- (void)transformDownloadFormatWithTaskId:(NSString *)taskId
                               fileFormat:(NSString *)fileFormat
                           successHandler:(void(^)(void))successHandler
                           failureHandler:(failureBlock)failureHandler;

#pragma mark - Demo
- (void)createLocationUrlWithTaskModel:(Modeling3dReconstructTaskModel *)taskModel;
- (NSArray *)getLocationFileArray;
- (UIImage *)getCoverImageWithTaskId:(NSString *)taskId;
@end

NS_ASSUME_NONNULL_END
