# 3DModeling-Sample
English | [中文](https://github.com/HMS-Core/hms-3d-modeling-demo-ios/blob/master/3DModeling-Sample/README_ZH.md)

## Table of Contents

 * [Introduction](#introduction)
 * [Project directory structure](#Project-directory-structure)
 * [More Scenarios](#more-scenarios)
 * [Getting Started](#getting-started)
    * [Supported Environment](#supported-environment)
 * [License](#license)


## Introduction
This sample code describes how to use the 3D Modeling Kit SDK, including the following modules:

### 3D Object Reconstruction
It includes image uploading, model previewing and model downloadling.

<table><tr>
<td><img src="https://github.com/HMS-Core/hms-3d-modeling-demo-ios/blob/master/3DModeling-objective-c/resources/ModelUpload.png" width=320 title="upload page" border=2></td>
<td><img src="https://github.com/HMS-Core/hms-3d-modeling-demo-ios/blob/master/3DModeling-objective-c/resources/ModelPreview.png" width=320 title="preiview page" border=2></td>
<td><img src="https://github.com/HMS-Core/hms-3d-modeling-demo-ios/blob/master/3DModeling-objective-c/resources/ModelDownload.png" width=320 title="download page" border=2></td>
</tr></table>




For details about the HMS Core 3D Modeling SDK, please refer to [HUAWEI 3D Modeling Kit](https://developer.huawei.com/consumer/en/doc/development/graphics-Guides/introduction-0000001143077297)

## Project directory structure

3DModeling-objective-c

    |-- Modeling3dDemo
        |-- Assets.xcassets
        |-- Modeling3dKit.framework
            |-- Headers
            	|-- Modeling3dKit.h //3DModelingKit.h.
            	|-- Modeling3dReconstructConstants.h // Modeling3dReconstructConstant defined in 3DModelingKit.
            	|-- Modeling3dReconstructErrorCode.h // Modeling3dErrorCode defined in 3DModelingKit.
            	|-- Modeling3dReconstructTask.h // Task processing class, such as uploading, querying, and downloading.
    	|-- UI
        |-- agconnect-services.plist
    |-- Modeling3dDemo.xcodeproj


## More Scenarios
HUAWEI 3D Modeling Kit allows your apps to easily leverage Huawei's long-term proven expertise in 3D Modeling Kit to support diverse 3D Modeling applications throughout a wide range of industries.
For more application scenarios, see: [Huawei 3D Modeling Service Integration Cases.](https://developer.huawei.com/consumer/en/doc/development/graphics-Guides/case-one-0000001148975606)

## Getting Started
 - Clone the code library to the local computer.

       git clone https://github.com/HMS-Core/hms-3d-modeling-demo-ios.git

 - If you have not registered as a developer, [register and create an app in AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html).
 - Obtain the agconnect-services.plist file from [Huawei Developers](https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides/config-agc-0000001050990353).
 - Replace the agconnect-services.json file in the project.
 - Compile and run on an IOS device or simulator.

Attention:

You should create an iOS app in AppGallery Connect, and obtain the agconnect-services.plist file and add it to the project. You should also generate a signing certificate fingerprint and add the certificate file to the project. More to Development Process

## Supported Environments
Devices with IOS version 9.0 or later are recommended.


##  License
The 3DModeling Sample have obtained the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0).