//
//  Modeling3dMainListCell.m
//  3DMagicObjReconstructDemo
//
//  Created by zy on 2021/8/11.
//

#import "Modeling3dMainListCell.h"
#import <Modeling3dKit/Modeling3dKit.h>
#import "CGXPopoverView.h"

@interface Modeling3dMainListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cover_img;
@property (weak, nonatomic) IBOutlet UILabel *status_lab;
@property (weak, nonatomic) IBOutlet UIView *status_bg_view;
@property (weak, nonatomic) IBOutlet UILabel *title_lab;
@property (weak, nonatomic) IBOutlet UILabel *size_lab;
@property (weak, nonatomic) IBOutlet UIButton *preview_btn;
@property (nonatomic, strong) CAGradientLayer *glayer;
@end


@implementation Modeling3dMainListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cover_img.layer.cornerRadius = 8;
    self.cover_img.layer.masksToBounds = YES;
    self.status_bg_view.layer.cornerRadius = 4;
    self.status_bg_view.layer.masksToBounds = YES;
    
    self.glayer = [CAGradientLayer layer];
    self.glayer.frame = CGRectMake(0, 0, 122, 15);
    self.glayer.startPoint = CGPointMake(0.50, 0.00);
    self.glayer.endPoint = CGPointMake(0.50, 1.00);
    self.glayer.locations = @[@(0),@(1.f)];
    [self.status_bg_view.layer addSublayer:self.glayer];
    [self.status_bg_view.layer insertSublayer:self.glayer atIndex:0];
}

- (void)setTaskModel:(Modeling3dReconstructTaskModel *)taskModel {
    _taskModel = taskModel;
    
    self.title_lab.text = [NSString stringWithFormat:@"%@", _taskModel.taskId];
    self.size_lab.text = [NSString stringWithFormat:@"%.2f MB", _taskModel.fileSize*1.f/1024/1024];
    self.status_lab.text = [NSString stringWithFormat:@" %@  ", [self getTaskStatusStringFromTaskStatusCode:_taskModel.taskStatus]];
    self.cover_img.image = [[Modeling3dReconstructTask sharedManager] getCoverImageWithTaskId:_taskModel.taskId];
    
    [self showStatusBgColorWithStatus:_taskModel.taskStatus];
    if (_taskModel.taskStatus == 0) {
        [self.preview_btn setImage:[UIImage imageNamed:@"icon_mine_1"] forState:UIControlStateNormal];
    } else if (_taskModel.taskStatus == 1 || _taskModel.taskStatus == 2) {
        [self.preview_btn setImage:[UIImage imageNamed:@"icon_mine_3"] forState:UIControlStateNormal];
    } else {
        [self.preview_btn setImage:[UIImage imageNamed:@"icon_mine_2"] forState:UIControlStateNormal];
    }
}

#pragma mark - Event
- (IBAction)previewClick:(UIButton *)sender {
    if (self.taskModel.taskStatus == 0) {
        // 上传
        if (self.delegate && [self.delegate respondsToSelector:@selector(operateOnCellWithType:indexPath:)]) {
            [self.delegate operateOnCellWithType:OperateTypeUpload indexPath:self.indexPath];
        }
    } else {
        // 预览
        if (self.delegate && [self.delegate respondsToSelector:@selector(operateOnCellWithType:indexPath:)]) {
            [self.delegate operateOnCellWithType:OperateTypePreview indexPath:self.indexPath];
        }
    }
}
// 更多
- (IBAction)moreActionClick:(UIButton *)sender {
    CGXPopoverManager *manager = [CGXPopoverManager new];
    manager.arrowStyle = CGXPopoverManagerArrowStyleTriangle;
    manager.timeInterval = 0.2;
    manager.selectTitleColor = [UIColor blackColor];
    manager.modleArray = [NSMutableArray arrayWithArray:@[[CGXPopoverItem actionWithTitle:NSLocalizedString(@"download", nil)],[CGXPopoverItem actionWithTitle:NSLocalizedString(@"delete", nil)],[CGXPopoverItem actionWithTitle:NSLocalizedString(@"query", nil)],[CGXPopoverItem actionWithTitle:self.taskModel.restrictFlag?NSLocalizedString(@"r_res", nil):NSLocalizedString(@"a_res", nil)]]];
    CGXPopoverView *popoverView = [[CGXPopoverView alloc] initWithFrame:CGRectZero WithManager:manager];
    
    [popoverView showToView:sender SelectItem:^(CGXPopoverItem *item, NSIndexPath *indexPath) {
        if (indexPath.row == 0) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(operateOnCellWithType:indexPath:)]) {
                [self.delegate operateOnCellWithType:OperateTypeDownload indexPath:self.indexPath];
            }
        } else if (indexPath.row == 1) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(operateOnCellWithType:indexPath:)]) {
                [self.delegate operateOnCellWithType:OperateTypeDelete indexPath:self.indexPath];
            }
        } else if (indexPath.row == 2) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(operateOnCellWithType:indexPath:)]) {
                [self.delegate operateOnCellWithType:OperateTypeQuery indexPath:self.indexPath];
            }
        } else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(operateOnCellWithType:indexPath:)]) {
                [self.delegate operateOnCellWithType:OperateTypeLimit indexPath:self.indexPath];
            }
        }
    }];

}


- (void)showStatusBgColorWithStatus:(NSInteger)code {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    if (code == 0 || code == 1) {
        self.glayer.colors = @[
        (__bridge id)[UIColor colorWithRed:77/255.0 green:177/255.0 blue:209/255.0 alpha:1.00].CGColor,
        (__bridge id)[UIColor colorWithRed:90/255.0 green:152/255.0 blue:180/255.0 alpha:1.00].CGColor,
        ];
    } else if (code == 2) {
        self.glayer.colors = @[
        (__bridge id)[UIColor colorWithRed:207/255.0 green:189/255.0 blue:72/255.0 alpha:1.00].CGColor,
        (__bridge id)[UIColor colorWithRed:214/255.0 green:126/255.0 blue:49/255.0 alpha:1.00].CGColor,
        ];
    } else if (code == 3) {
        self.glayer.colors = @[
        (__bridge id)[UIColor colorWithRed:77/255.0 green:209/255.0 blue:155/255.0 alpha:1.00].CGColor,
        (__bridge id)[UIColor colorWithRed:68/255.0 green:191/255.0 blue:126/255.0 alpha:1.00].CGColor,
        ];
    } else if (code == 4) {
        self.glayer.colors = @[
        (__bridge id)[UIColor colorWithRed:209/255.0 green:77/255.0 blue:77/255.0 alpha:1.00].CGColor,
        (__bridge id)[UIColor colorWithRed:191/255.0 green:68/255.0 blue:81/255.0 alpha:1.00].CGColor,
        ];
    }
    
    [CATransaction commit];
}
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
@end
