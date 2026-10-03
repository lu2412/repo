#import <UIKit/UIKit.h>

// 1. 针对开屏等待页 / 开屏广告控制器
%hook KSNewOpenWaiteViewController

- (void)viewDidLoad {
    %orig;
    // 方法 A：如果控制器加载后直接自动跳过，可以尝试在这里主动调用跳过方法或直接 dismiss/pop
    // 也可以通过延迟一小段时间调用其跳过逻辑
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 尝试直接调用日志中看到的跳过动作方法
        if ([self respondsToSelector:@selector(skipTimeCount:)]) {
            [self performSelector:@selector(skipTimeCount:) withObject:nil];
        }
    });
}

%end


// 2. 针对首页弹出广告视图 (KSHomePresentAdView)
%hook KSHomePresentAdView

- (void)didMoveToWindow {
    %orig;
    // 当弹窗视图被添加到窗口时，直接将其从父视图中移除，实现直接屏蔽
    [self removeFromSuperview];
}

%end
