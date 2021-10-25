//
//  Modeling3dProgressAlertView.h
//  3DMagicObjReconstructDemo
//
//  Created by zy on 2021/8/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Modeling3dProgressAlertView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *progressValueLabel;
@property (nonatomic, copy) void(^cancelHandler)(NSString *title);

@end

NS_ASSUME_NONNULL_END
