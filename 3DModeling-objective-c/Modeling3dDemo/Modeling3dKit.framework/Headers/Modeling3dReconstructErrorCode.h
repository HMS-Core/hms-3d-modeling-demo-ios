//
//  Modeling3dErrorCode.h
//  3DMagicObjReconstructDemo
//
//  Created by zy on 2021/8/21.
//

#ifndef Modeling3dErrorCode_h
#define Modeling3dErrorCode_h

typedef NS_ENUM(NSUInteger, MRErrorCode) {
    /** 未知错误 */
    ERR_UNKNOWN                             = 1122,
    
    // 云测返回码 映射到 端侧错误码
    /**(1000 1003 1004) 服务器异常 */
    ERR_SERVICE_EXCEPTION                   = 1112,
    /**(1001 1006) 鉴权失败 */
    ERR_AUTHORIZE_FAILED                    = 1111,
    /**(1002) 非法参数 */
    ERR_ILLEGAL_PARAMETER                   = 1104,
    /**(1005) Token非法或过期 */
    ERR_ILLEGAL_TOKEN                       = 1116,
    /**(1007) 任务不存在 */
    ERR_TASKIDID_NOT_EXISTE                 = 1114,
    /**(1008) 任务状态非法 */
    ERR_ILLEGAL_TASK_STATUS                 = 1115,
    /**(1009) 图片文件不存在 */
    ERR_FILE_NOT_FOUND                      = 1103,
    /**(1010) 任务过期 */
    ERR_TASK_EXPIRED                        = 1117,
    /**(1011 1012) 调用超过上线 */
    ERR_RAT_OVER_MAX_LIMIT                  = 1118,
    
    
    // 本地逻辑错误码
    /** 不支持的图片格式 */
    ERR_IMAGE_FILE_NOTSUPPORTED             = 1100,
    /** 图片文件太大 (上传的图片大小范围为小于800M) */
    ERR_IMAGE_FILE_SIZE_OVERFLOW            = 1101,
    /** 图片文件数量不支持 (上传的图片个数范围为20-200) */
    ERR_FILE_NUMBER_NOT_SUPPORT             = 1102,
    /** 重建引擎繁忙 */
    ERR_ENGINE_BUSY                         = 1105,
    /** 上传失败 */
    ERR_IMAGE_UPLOAD_FAILED                 = 1106,
    /** 任务正在执行，不允许重复提交 */
    ERR_TASK_ALREADY_INPROGRESS             = 1107,
    /** 查询失败 */
    ERR_QUERY_FAILED                        = 1108,
    /** 下载失败 */
    ERR_DOWNLOAD_FAILED                     = 1109,
    /** 取消上传失败 */
    ERR_UPLOAD_CANCEL_FAILED                = 1119,
    /** 取消下载失败 */
    ERR_CANCELDOWNLOAD_FAILED               = 1120,
    /** 网络异常 */
    ERR_NETCONNECT_FAILED                   = 1110,
    /** 内部错误 */
    ERR_INTERNAL                            = 1113,
    /** 初始化失败 */
    ERR_INIT_TASK_FAILED                    = 1121,
    /** 图片分辨率不支持 (上传的图片个数范围为1080*720-4096*3048) */
    ERR_IMAGE_RESOLUTION_NOTSUPPORTED       = 1123,
    /** 图片分辨率不一致 */
    ERR_IMAGE_RESOLUTION_INCONSISTENT       = 1124,
    
    /** 图片格式不一致 */
    ERR_IMAGE_TYPE_INCONSISTENT             = 1125,
    /** 预览失败 */
    ERR_MODEL_PREVIEW_FAILED                = 1126,
    /** 删除云测文件失败 */
    ERR_DELETE_REMOTE_FILE_FAILED           = 1127,
    /** 任务受限 */
    ERR_TASK_RESTRICTED                     = 1128,
    /** 数据处理地未设置 */
    ERR_DATA_PROCESSING_LOCATION_NOT_SET    = 1129,
    
    /** 压缩失败 */
    ERR_COMPRESS_FAIL                       = 2111,
    /** 分片失败 */
    ERR_FILE_SPLIT_FAIL                     = 2112,
    /** 重建未完成不支持下载 */
    ERR_DOWNLOAD_NOT_SUPPORT                = 2113,
    
    
    /** 请求取消 */
    MRErrorCodeCanceled                     = NSURLErrorCancelled
};




#endif /* Modeling3dErrorCode_h */
