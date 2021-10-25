//
//  Modeling3dTaskModel.h
//  3DMagicObjReconstructDemo
//
//  Created by zy on 2021/8/14.
//

#import <Foundation/Foundation.h>
#import "Modeling3dReconstructConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface Modeling3dReconstructTaskModel : NSObject<NSCoding>

// id
@property (nonatomic, copy) NSString *taskId;
// 分片大小
@property (nonatomic, assign) NSInteger blockSize;
// 有效期
@property (nonatomic, assign) NSInteger expireTime;
// 任务状态
@property (nonatomic, assign) NSInteger taskStatus;
// 受限制处理状态：0.不限制 1.限制处理
@property (nonatomic, assign) BOOL restrictFlag;
// 创建时间
@property (nonatomic, copy) NSString *createDate;
// 上传状态 
@property (nonatomic, assign) UploadProgress uploadStatus;
// 当前任务文件大小
@property (nonatomic, assign) int64_t fileSize;

// 保存更改
- (void)save;
@end

NS_ASSUME_NONNULL_END
