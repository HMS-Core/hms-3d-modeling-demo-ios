//
//  Modeling3dReconstructConstants.h
//  Modeling3dDemo
//
//  Created by zy on 2021/10/14.
//

#ifndef Modeling3dReconstructConstants_h
#define Modeling3dReconstructConstants_h

typedef NS_ENUM(NSUInteger, UploadProgress) {
    UploadProgressInitUpload,           //初始化上传
    UploadProgressCompress,             //压缩
    UploadProgressSplit,                //分片
    UploadProgressUploading,            //上传
    UploadProgressNoticeService         //通知云端上传完成
};

typedef NS_ENUM(NSUInteger, InitTaskConfig) {
    /** taskType = 0 */
    InitTaskConfigPictureModel=0,       //RGB图像
//    InitTaskConfigSLAMModel=1,          //SLAM模式
//    /** taskType = 1 */
//    InitTaskConfigTrandationModel=0,    //传统模式
//    InitTaskConfigAIModel=1             //AI模式
};

typedef NS_ENUM(NSUInteger, QueryTaskStatus) {
    QueryTaskStatusCreateReconstruct,   //新建重建任务
    QueryTaskStatusFinishUploadFiles,   //文件上传完毕
    QueryTaskStatusExcuteReconstruct,   //开始重建
    QueryTaskStatusReconstructSuccess,  //重建成功
    QueryTaskStatusReconstructFail      //重建失败
};

typedef NS_ENUM(NSUInteger, TaskRestrictStatus) {
    TaskRestrictStatusUnrestrict,       //未限制
    TaskRestrictStatusRestrict          //已限制
};

typedef NS_ENUM(NSUInteger, TaskDownloadFormat) {
    TaskDownloadFormatOBJ,              //OBJ
    TaskDownloadFormatGLTF              //GLTF
};


#endif /* Modeling3dReconstructConstants_h */
