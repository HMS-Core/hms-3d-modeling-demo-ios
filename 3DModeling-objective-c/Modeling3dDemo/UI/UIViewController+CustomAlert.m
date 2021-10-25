//
//  UIViewController+CustomAlert.m
//  3DMagicObjReconstructDemo
//
//  Created by zy on 2021/9/6.
//

#import "UIViewController+CustomAlert.h"
#import "SVProgressHUD.h"
#import "Modeling3dProgressAlertView.h"
#import <Modeling3dKit/Modeling3dKit.h>
#import "TZImagePickerController.h"
#import "TZAssetCell.h"

@implementation UIViewController (CustomAlert)

- (void)showSystemAlertWithTitle:(NSString *)title
                         message:(NSString *)message
                         handler:(void (^)(UIAlertAction *action))handler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:({
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"ok", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            handler(action);
        }];
        confirmAction;
    })];
    [alert addAction:({
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        cancelAction;
    })];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)showMessageAlert:(NSString *)message {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"tips", nil) message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:({
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"ok", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        confirmAction;
    })];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (Modeling3dProgressAlertView *)showCustomAlert:(BOOL)isUpload taskId:(NSString *)taskId {
    
    Modeling3dProgressAlertView *alertView = [[Modeling3dProgressAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertView.titleLab.text = isUpload ? NSLocalizedString(@"u_pgs", nil) : NSLocalizedString(@"d_pgs", nil);
    [alertView setCancelHandler:^(NSString * _Nonnull title) {
        if (!isUpload) {
            [[Modeling3dReconstructTask sharedManager] cancelDownloadTaskWithTaskId:taskId completeHandler:^(NSInteger retCode, NSString * _Nonnull retMsg) {
                [SVProgressHUD showErrorWithStatus:retMsg];
            }];
        } else {
            [[Modeling3dReconstructTask sharedManager] cancelUploadTaskWithTaskId:taskId completeHandler:^(NSInteger retCode, NSString * _Nonnull retMsg) {
                [SVProgressHUD showErrorWithStatus:retMsg];
            }];
        }
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
    return alertView;
}


- (void)showSuccessWithStatus:(NSString *)retMsg {
    [SVProgressHUD showSuccessWithStatus:retMsg];
}
- (void)showErrorWithStatus:(NSString *)retMsg {
    [SVProgressHUD showErrorWithStatus:retMsg];
}
- (void)show {
    [SVProgressHUD showWithStatus:@"loading..."];
}
- (void)dismiss {
    [SVProgressHUD dismiss];
}

- (void)commonConfig {
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = self.view.bounds;
    gl.startPoint = CGPointMake(0.50, 0.00);
    gl.endPoint = CGPointMake(0.50, 1.00);
    gl.colors = @[
    (__bridge id)[UIColor colorWithRed:24/255.0 green:27/255.0 blue:39/255.0 alpha:1.00].CGColor,
    (__bridge id)[UIColor colorWithRed:45/255.0 green:29/255.0 blue:51/255.0 alpha:1.00].CGColor,
    ];
    gl.locations = @[@(0),@(1.f)];
    [self.view.layer addSublayer:gl];
    [self.view.layer insertSublayer:gl atIndex:0];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (TZImagePickerController *)getImagePicker {
    
    TZImagePickerController *ipicker = [[TZImagePickerController alloc] initWithMaxImagesCount:200 columnNumber:3 delegate:self];
    ipicker.modalPresentationStyle = UIModalPresentationFullScreen;
    ipicker.allowPreview = NO;
    ipicker.allowPickingVideo = NO;
    ipicker.allowTakeVideo = NO;
    ipicker.showSelectedIndex = YES;
    ipicker.allowTakePicture = NO;
    ipicker.showSelectedIndex = NO;
    ipicker.doneBtnTitleStr = NSLocalizedString(@"upload", nil);
    ipicker.oKButtonTitleColorNormal = [UIColor whiteColor];
    ipicker.oKButtonTitleColorDisabled = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    ipicker.collectionViewBgColor = [UIColor colorWithRed:45/255.f green:29/255.f blue:51/255.f alpha:1];
    ipicker.toolBarBgColor = [UIColor blackColor];
    ipicker.photoSelImage = [UIImage imageNamed:@"icon_mine_4"];
    ipicker.naviBgColor = [UIColor blackColor];
    ipicker.allowPickingOriginalPhoto = NO;
    ipicker.minImagesCount = 20;
    ipicker.onlyReturnAsset = YES;
    
    [ipicker setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        doneButton.backgroundColor = [UIColor colorWithRed:98/255.f green:166/255.f blue:255/255.f alpha:1];
    }];
    [ipicker setPhotoPickerPageDidLayoutSubviewsBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        doneButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-23-56, 11, 56, 28);
        doneButton.layer.cornerRadius = 14;
        doneButton.layer.masksToBounds = YES;
        
        numberImageView.frame = CGRectMake(CGRectGetMinX(doneButton.frame)-26-10, 13, 26, 26);
        numberLabel.frame = numberImageView.frame;
    }];
//    [ipicker setAssetCellDidLayoutSubviewsBlock:^(TZAssetCell *cell, UIImageView *imageView, UIImageView *selectImageView, UILabel *indexLabel, UIView *bottomView, UILabel *timeLength, UIImageView *videoImgView) {
//        selectImageView.frame = CGRectMake(cell.bounds.size.width-5-27, cell.bounds.size.height-5-27, 27, 27);
//    }];
    
    return ipicker;
}


// 获取TaskStatus String
- (NSString *)getTaskStatusStringFromTaskStatusCode:(NSInteger)statusCode {
    
    if (statusCode == 0) {
        return NSLocalizedString(@"task_status_0", nil);
    } else if (statusCode == 1) {
        return NSLocalizedString(@"task_status_1", nil);// 文件已上传
    } else if (statusCode == 2) {
        return NSLocalizedString(@"task_status_2", nil);
    } else if (statusCode == 3) {
        return NSLocalizedString(@"task_status_3", nil);
    } else if (statusCode == 4) {
        return NSLocalizedString(@"task_status_4", nil);
    } else {
        return NSLocalizedString(@"task_status_5", nil);
    }
    
}
// 获取上传阶段 String
- (NSString *)getUploadStatusStringFromStatusCode:(NSInteger)statusCode {
    if (statusCode == 0) {
        return NSLocalizedString(@"u_status_1", nil);
    } else if (statusCode == 1) {
        return NSLocalizedString(@"u_status_2", nil);
    } else if (statusCode == 2) {
        return NSLocalizedString(@"u_status_3", nil);
    } else if (statusCode == 3) {
        return NSLocalizedString(@"u_status_4", nil);
    } else if (statusCode == 4) {
        return NSLocalizedString(@"u_status_5", nil);
    } else {
        return NSLocalizedString(@"u_status_0", nil);
    }
}

@end
