//
//  Modeling3dProgressAlertView.m
//  3DMagicObjReconstructDemo
//
//  Created by zy on 2021/8/19.
//

#import "Modeling3dProgressAlertView.h"

@implementation Modeling3dProgressAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[NSBundle mainBundle] loadNibNamed:@"Modeling3dProgressAlertView" owner:self options:nil].firstObject;
        
        [self.progressView addObserver:self forKeyPath:@"progress" options:NSKeyValueObservingOptionNew context:nil];
        self.progressView.progress = 0.f;
        self.statusLabel.text = @"";
        
        self.frame = frame;
    }
    return self;
}

- (IBAction)cancel:(UIButton *)sender {
    
    if (self.cancelHandler && [sender.currentTitle isEqualToString:NSLocalizedString(@"cancel", nil)]) {
        self.cancelHandler(self.titleLab.text);
    }
    
    [self removeFromSuperview];
}


- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"progress"]) {
        float progress = [change[@"new"] floatValue];
        self.progressValueLabel.text = [NSString stringWithFormat:@"%@: %.2f%%", NSLocalizedString(@"completed", nil), progress*100];
        if (progress == 1) {
            [self removeFromSuperview];
        }
    }
}

- (void)dealloc {
    [self.progressView removeObserver:self forKeyPath:@"progress"];
}
@end
