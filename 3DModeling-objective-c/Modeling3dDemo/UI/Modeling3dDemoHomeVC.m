//
//  Modeling3dDemoHomeVC.m
//  3DMagicObjReconstructDemo
//
//  Created by zy on 2021/9/13.
//

#import "Modeling3dDemoHomeVC.h"
#import "UIViewController+CustomAlert.h"
#import <Modeling3dKit/Modeling3dKit.h>
#import "Modeling3dProgressAlertView.h"
#import "TZImagePickerController.h"
#import "TZAssetCell.h"

@interface Modeling3dDemoHomeVC ()<TZImagePickerControllerDelegate>

@end

@implementation Modeling3dDemoHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonConfig];
    
}


- (IBAction)uploadClick:(UIButton *)sender {
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusDenied) {
                [self showSystemAlertWithTitle:NSLocalizedString(@"tips", nil) message:NSLocalizedString(@"permission_msg", nil) handler:^(UIAlertAction *action) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }];
                return;
            }
            
            [self presentViewController:[self getImagePicker] animated:YES completion:nil];
        });
    }];
}
- (IBAction)howToUploadClick:(UIButton *)sender {
    NSLog(@"%@", sender.currentTitle);
    
}


#pragma mark - TZImagePickerControllerDelegate
// 选择图片后上传
- (void)imagePickerController:(TZImagePickerController *)picker
       didFinishPickingPhotos:(NSArray<UIImage *> *)photos
                 sourceAssets:(NSArray *)assets
        isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:assets.count];
    dispatch_group_t group = dispatch_group_create();
    for (PHAsset *asset in assets) {
        dispatch_group_enter(group);
        // 导出原图 内存消耗小
        [[TZImageManager manager] getOriginalPhotoWithAsset:asset completion:^(UIImage *photo, NSDictionary *info) {
            if (![[info objectForKey:PHImageResultIsDegradedKey] boolValue]) {
                [images addObject:photo];
                dispatch_group_leave(group);
            }
        }];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [[Modeling3dReconstructTask sharedManager] initTaskWithTaskConfig:InitTaskConfigPictureModel successHandler:^(Modeling3dReconstructTaskModel * _Nonnull taskModel) {
            [[Modeling3dReconstructTask sharedManager] createLocationUrlWithTaskModel:taskModel];
            
            [[Modeling3dReconstructTask sharedManager] queryRestrictionWithTaskId:taskModel.taskId successHandler:^(TaskRestrictStatus restrictFlag) {
                if (!restrictFlag) {
                    Modeling3dProgressAlertView *alert = [self showCustomAlert:YES taskId:taskModel.taskId];
                    
                    [[Modeling3dReconstructTask sharedManager] uploadTaskWithTaskModel:taskModel
                                                                           imageAssets:images
                                                                    fileHandleProgress:^(UploadProgress progress){
                        alert.statusLabel.text = [self getUploadStatusStringFromStatusCode:progress];
                    } successHandler:^{
                        [self showSuccessWithStatus:@"Upload Success"];
                        taskModel.taskStatus = 1;
                        [taskModel save];
                    } progressHandler:^(float progressValue) {
                        NSLog(@"upload: %f", progressValue);
                        alert.progressView.progress = progressValue;
                    } failureHandler:^(NSInteger retCode, NSString * _Nonnull retMsg) {
                        [alert removeFromSuperview];
                        [self showErrorWithStatus:retMsg];
                    }];
                } else {
                    [self showErrorWithStatus:@"The task is restricted, operate before cancel restrict please"];
                }
            } failureHandler:^(NSInteger retCode, NSString * _Nonnull retMsg) {
                [self showErrorWithStatus:retMsg];
            }];
        } failureHandler:^(NSInteger retCode, NSString * _Nonnull retMsg) {
            [self showErrorWithStatus:retMsg];
        }];
    });
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
