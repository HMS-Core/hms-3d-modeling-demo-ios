# 3DModeling-Sample
[![License](https://img.shields.io/badge/Docs-hmsguides-brightgreen)](https://developer.huawei.com/consumer/cn/doc/development/HMS-Guides/ml-introduction-4)

中文 | [English](https://github.com/HMS-Core/hms-3d-modeling-demo/blob/master/3DModeling-Sample/README.md)
## 目录

 * [介绍](#介绍)
 * [工程目录结构](#工程目录结构)
 * [更多场景](#更多场景)
 * [运行步骤](#运行步骤)
 * [支持的环境](#支持的环境)
 * [许可证](#许可证)


## 介绍
本示例代码目的是为了介绍3D Modeling Kit SDK的使用，其中包含以下两个能力：

### 3D物体建模
其中包括：上传采集图片、查询建模进度、下载模型。

<table><tr>
<td><img src="https://github.com/HMS-Core/hms-3d-modeling-demo/blob/master/3DModeling-objective-c/resources/ModelCapture.jpg" width=300 title="capture page" border=2></td>
<td><img src="https://github.com/HMS-Core/hms-3d-modeling-demo/blob/master/3DModeling-Sample/resources/ModelUpload.jpg" width=300 title="upload page" border=2></td>
<td><img src="https://github.com/HMS-Core/hms-3d-modeling-demo/blob/master/3DModeling-Sample/resources/ModelDownload.jpg" width=300 title="download page" border=2></td>
</tr></table>


详细介绍请参考[华为3D建模服务SDK](https://developer.huawei.com/consumer/cn/doc/development/graphics-Guides/introduction-0000001143077297)。

## 工程目录结构
3DModeling-objective-c

    |-- Modeling3dDemo
        |-- Assets.xcassets
        |-- Modeling3dKit.framework
            |-- Headers
            	|-- Modeling3dKit.h //3DModelingKit.h。
            	|-- Modeling3dReconstructConstants.h //  3DModelingKit 中定义的相关常量。、
            	|-- Modeling3dReconstructErrorCode.h // 3DModelingKit 中定义的业务相关的错误码。
            	|-- Modeling3dReconstructTask.h // 3D建模任务处理类，包含上传、下载、查询等操作。
    	|-- UI UI相关代码
        |-- agconnect-services.plist 开发者相关的配置文件
    |-- Modeling3dDemo.xcodeproj

## 更多场景
华为3D建模服务（HMS 3D Modeling Kit） 提供3D建模套件，为开发者应用3D建模能力开发各类应用提供优质体验。
更多应用场景，可参考：[华为3D建模服务集成案例](https://developer.huawei.com/consumer/cn/doc/development/graphics-Guides/case-one-0000001148975606)。

## 运行步骤
 - 将本代码库克隆到本地。

       git clone  https://github.com/HMS-Core/hms-3d-modeling-demo-ios.git

 - 如果您还没有注册成为开发者，请在[AppGalleryConnect上注册并创建应用](https://developer.huawei.com/consumer/cn/service/josp/agc/index.html)。
 - agconnect-services.json文件请从[华为开发者社区](https://developer.huawei.com/consumer/cn/doc/development/HMSCore-Guides/config-agc-0000001050990353)网站申请获取。
 - 替换工程中的agconnect-services.json文件。
 - 编译并且在IOS设备或模拟器上运行。

注意：

您应该在AppGallery Connect中创建一个iOS应用程序，并获取agconnect-services.plist文件并将其添加到项目中。您还应生成签名证书指纹，并将证书文件添加到项目中。更多关于开发过程的信息

## 支持的环境
推荐使用IOS版本 9.0及以上版本的设备。

##  许可证
此示例代码已获得[Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0)。