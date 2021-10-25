//
//  Modeling3dDemoMineVC.m
//  3DMagicObjReconstructDemo
//
//  Created by zy on 2021/9/13.
//

#import "Modeling3dDemoMineVC.h"
#import "Modeling3dMainListCell.h"
#import "Modeling3dProgressAlertView.h"
#import <Modeling3dKit/Modeling3dKit.h>
#import "UIViewController+CustomAlert.h"
#import "Modeling3dProgressAlertView.h"
#import "Modeling3dDemoFilesListVC.h"
#import "TZImagePickerController.h"
#import "TZAssetCell.h"
#import "CGXPopoverView.h"

@interface Modeling3dDemoMineVC ()<UITableViewDelegate, UITableViewDataSource, TZImagePickerControllerDelegate, Modeling3dMainListCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) NSMutableArray *queryDatas;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@property (nonatomic, strong) dispatch_source_t timer;
@end

// 默认的下载格式 OBJ
#define kDefaultDownloadFormat @[[CGXPopoverItem actionWithTitle:@"OBJ"],[CGXPopoverItem actionWithTitle:@"GLTF"]]

@implementation Modeling3dDemoMineVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getListData];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.timer) {
        dispatch_cancel(self.timer);
        self.timer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonConfig];
    
    self.datas = [NSMutableArray array];
    self.queryDatas = [NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:@"Modeling3dMainListCell" bundle:nil] forCellReuseIdentifier:@"Modeling3dMainListCell"];
    self.tableView.tableFooterView = [UIView new];
    
}


#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Modeling3dMainListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Modeling3dMainListCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.taskModel = [self.datas objectAtIndex:indexPath.row];
    cell.indexPath = indexPath;
    
    return cell;
}

#pragma mark - Delegate
#pragma mark - TZImagePickerControllerDelegate
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
        Modeling3dReconstructTaskModel *taskModel = [self.datas objectAtIndex:self.currentIndexPath.row];
        [[Modeling3dReconstructTask sharedManager] queryRestrictionWithTaskId:taskModel.taskId successHandler:^(TaskRestrictStatus restrictFlag) {
            if (!restrictFlag) {
                Modeling3dProgressAlertView *alert = [self showCustomAlert:YES taskId:taskModel.taskId];
                
                [[Modeling3dReconstructTask sharedManager] uploadTaskWithTaskModel:taskModel
                                                                       imageAssets:images
                                                                fileHandleProgress:^(UploadProgress progress){
                    alert.statusLabel.text = [self getUploadStatusStringFromStatusCode:progress];
                } successHandler:^{
                    taskModel.taskStatus = 1;
                    [taskModel save];
                    [self.tableView reloadRowsAtIndexPaths:@[self.currentIndexPath] withRowAnimation:UITableViewRowAnimationNone];
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
    });
}


#pragma mark - Modeling3dMainListCellDelegate
// 操作
- (void)operateOnCellWithType:(OperateType)type indexPath:(nonnull NSIndexPath *)indexPath {
    self.currentIndexPath = indexPath;
    Modeling3dReconstructTaskModel *taskModel = [self.datas objectAtIndex:self.currentIndexPath.row];
    
    switch (type) {
        case OperateTypePreview:
            [self preview:taskModel];
            break;
        case OperateTypeUpload:
            [self upload];
            break;
        case OperateTypeDownload:
            [self download:taskModel];
            break;
        case OperateTypeDelete:
            [self delete:taskModel];
            break;
        case OperateTypeQuery:
            [self query:taskModel];
            break;
        case OperateTypeLimit:
            [self limit:taskModel];
            break;
        default:
            break;
    }

}

#pragma mark - Event
// 图片选择
- (void)upload {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusDenied) {
                [self showSystemAlertWithTitle:NSLocalizedString(@"tips", nil) message:NSLocalizedString(@"permission_msg", nil) handler:^(UIAlertAction *action) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }];
                return;
            }
            
            [self presentViewController:[self getImagePicker] animated:YES completion:^{
            }];
        });
    }];
}

// 下载
- (void)download:(Modeling3dReconstructTaskModel *)taskModel {
    
    CGXPopoverManager *manager = [CGXPopoverManager new];
    manager.arrowStyle = CGXPopoverManagerArrowStyleTriangle;
    manager.timeInterval = 0.2;
    manager.selectTitleColor = [UIColor blackColor];
    manager.modleArray = [NSMutableArray arrayWithArray:kDefaultDownloadFormat];
    CGXPopoverView *popoverView = [[CGXPopoverView alloc] initWithFrame:CGRectZero WithManager:manager];
    
    Modeling3dMainListCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[self.datas indexOfObject:taskModel] inSection:0]];
    [popoverView showToView:cell.moreBtn SelectItem:^(CGXPopoverItem *item, NSIndexPath *indexPath) {

        [[Modeling3dReconstructTask sharedManager] queryRestrictionWithTaskId:taskModel.taskId successHandler:^(TaskRestrictStatus restrictFlag) {
            if (!restrictFlag) {
                Modeling3dProgressAlertView *alert = [self showCustomAlert:NO taskId:taskModel.taskId];
                alert.hidden = YES;
                [[Modeling3dReconstructTask sharedManager] downloadTaskWithTaskId:taskModel.taskId
                                                                   downloadFormat:[item.title isEqualToString:@"OBJ"] ? TaskDownloadFormatOBJ : TaskDownloadFormatGLTF
                                                                successHandler:^{
                    [self showSuccessWithStatus:@"Download Success"];
                } progressHandler:^(float progressValue) {
                    NSLog(@"download :%f", progressValue);
                    if (alert.hidden) alert.hidden = NO;
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
    }];
    
}

// 删除
- (void)delete:(Modeling3dReconstructTaskModel *)taskModel {
    [self show];
    [[Modeling3dReconstructTask sharedManager] deleteTaskWithTaskId:taskModel.taskId
                                                  successHandler:^{
        [self showSuccessWithStatus:@"Delete Success"];
        [self.datas removeObjectAtIndex:self.currentIndexPath.row];
        [self.tableView reloadData];
    } failureHandler:^(NSInteger retCode, NSString * _Nonnull retMsg) {
        [self showErrorWithStatus:retMsg];
    }];
}

// 查询
- (void)query:(Modeling3dReconstructTaskModel *)taskModel {
    [self show];
    [[Modeling3dReconstructTask sharedManager] queryTaskWithTaskId:taskModel.taskId
                                                 successHandler:^(QueryTaskStatus taskStatus, NSString *errorMsg) {
        [self showSuccessWithStatus:[self getTaskStatusStringFromTaskStatusCode:taskStatus]];
        taskModel.taskStatus = taskStatus;
        [taskModel save];
        [self.tableView reloadRowsAtIndexPaths:@[self.currentIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    } failureHandler:^(NSInteger retCode, NSString * _Nonnull retMsg) {
        [self showErrorWithStatus:retMsg];
    }];
}

// 限制
- (void)limit:(Modeling3dReconstructTaskModel *)taskModel {
    [self show];
    [[Modeling3dReconstructTask sharedManager] restrictionWithTaskId:taskModel.taskId
                                                         isCancel:taskModel.restrictFlag
                                                   successHandler:^{
        [self showSuccessWithStatus:@"Operate Success"];
        taskModel.restrictFlag = !taskModel.restrictFlag;
        [taskModel save];
    } failureHandler:^(NSInteger retCode, NSString * _Nonnull retMsg) {
        [self showErrorWithStatus:retMsg];
    }];
}

// 预览
- (void)preview:(Modeling3dReconstructTaskModel *)taskModel {
    [self show];
    [[Modeling3dReconstructTask sharedManager] previewTaskWithTaskId:taskModel.taskId
                                                   successHandler:^{
        [self dismiss];
    } failureHandler:^(NSInteger retCode, NSString * _Nonnull retMsg) {
        [self showErrorWithStatus:retMsg];
    }];
}


- (void)getListData {

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.datas removeAllObjects];
        [self.datas addObjectsFromArray:[[Modeling3dReconstructTask sharedManager] getLocationFileArray]];
        // 自动查询刷新状态  成功或者失败之后就不去查询
        for (Modeling3dReconstructTaskModel *model in self.datas) {
            if (model.taskStatus < 3) {
                [self.queryDatas addObject:model];
            }
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
        if (self.queryDatas.count) {
            [self startAutoQuery];
        }
    });
}

- (void)startAutoQuery {
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 20.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        // 定时执行查询
        for (Modeling3dReconstructTaskModel *model in self.queryDatas) {
            if (model.taskStatus == 0) continue;
            [[Modeling3dReconstructTask sharedManager] queryTaskWithTaskId:model.taskId successHandler:^(QueryTaskStatus taskStatus, NSString * _Nonnull errorMsg) {
                if (model.taskStatus != taskStatus) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        model.taskStatus = taskStatus;
                        [model save];
                        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.datas indexOfObject:model] inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                    });
                    
                    if (taskStatus >= 3) {
                        [self.queryDatas removeObject:model];
                    }
                }
            } failureHandler:^(NSInteger retCode, NSString * _Nonnull retMsg) {
                
            }];
        }
    });
    
    dispatch_resume(self.timer);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
