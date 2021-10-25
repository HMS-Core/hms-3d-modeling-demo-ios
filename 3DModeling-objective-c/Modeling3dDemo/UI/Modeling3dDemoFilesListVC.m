//
//  Modeling3dFilesListVC.m
//  3DMagicObjReconstructDemo
//
//  Created by zy on 2021/9/6.
//

#import "Modeling3dDemoFilesListVC.h"
#import "UIViewController+CustomAlert.h"

@interface Modeling3dDemoFilesListVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@end

@implementation Modeling3dDemoFilesListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonConfig];
    
    self.tableView.estimatedRowHeight = 44.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [UIView new];
    
    self.datas = [NSMutableArray array];
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *dataTaskPath = [cachePath stringByAppendingPathComponent:@"dataTask"];
    NSArray *subPaths = [[NSFileManager defaultManager] subpathsAtPath:dataTaskPath];
    for (NSString *subPath in subPaths) {
        NSString *downloadPath = [NSString stringWithFormat:@"%@/%@/downloadModel/model.zip", dataTaskPath, subPath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:downloadPath]) {
            [self.datas addObject:[NSURL fileURLWithPath:downloadPath]];
        }
    }
    [self.tableView reloadData];
}


#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    NSURL *url = [self.datas objectAtIndex:indexPath.row];
    cell.textLabel.text = url.lastPathComponent;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"local_path", nil), url.relativePath];
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (IBAction)backClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
