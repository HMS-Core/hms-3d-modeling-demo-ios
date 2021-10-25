//
//  UIViewController+CustomAlert.h
//  3DMagicObjReconstructDemo
//
//  Created by zy on 2021/9/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Modeling3dProgressAlertView,TZImagePickerController;
@interface UIViewController (CustomAlert)

- (void)showSystemAlertWithTitle:(NSString *)title
                         message:(NSString *)message
                         handler:(void (^)(UIAlertAction *action))handler;
- (void)showMessageAlert:(NSString *)message;

- (void)showErrorWithStatus:(NSString *)retMsg;
- (void)showSuccessWithStatus:(NSString *)retMsg;
- (void)show;
- (void)dismiss;

- (Modeling3dProgressAlertView *)showCustomAlert:(BOOL)isUpload taskId:(NSString *)taskId;
- (void)commonConfig;
- (TZImagePickerController *)getImagePicker;

- (NSString *)getTaskStatusStringFromTaskStatusCode:(NSInteger)statusCode;
- (NSString *)getUploadStatusStringFromStatusCode:(NSInteger)statusCode;
@end

NS_ASSUME_NONNULL_END
