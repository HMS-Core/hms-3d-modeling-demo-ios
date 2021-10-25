//
//  Modeling3dMainListCell.h
//  3DMagicObjReconstructDemo
//
//  Created by zy on 2021/8/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, OperateType) {
    OperateTypePreview,
    OperateTypeUpload,
    OperateTypeDownload,
    OperateTypeDownloadFilesList,
    OperateTypeDelete,
    OperateTypeQuery,
    OperateTypeLimit
};

@protocol Modeling3dMainListCellDelegate <NSObject>

- (void)operateOnCellWithType:(OperateType)type indexPath:(NSIndexPath *)indexPath;

@end

@class Modeling3dReconstructTaskModel;
@interface Modeling3dMainListCell : UITableViewCell

@property (nonatomic, weak) id<Modeling3dMainListCellDelegate> delegate;
@property (nonatomic, strong) Modeling3dReconstructTaskModel *taskModel;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

NS_ASSUME_NONNULL_END
