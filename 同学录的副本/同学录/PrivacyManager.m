//
//  PrivacyManager.m
//  test
//
//  Created by mgfjx on 2018/11/7.
//  Copyright © 2018 mgfjx. All rights reserved.
//

#import "PrivacyManager.h"
#import <UIKit/UIKit.h>

#define kKeyWindow          [UIApplication sharedApplication].keyWindow

#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height)

#define kSCALE_WIDTH SCREEN_WIDTH/414.0
#define kSCALE_HEIGHT SCREEN_HEIGHT/736.0

#define kAgreementKey @"kAgreementKey"

@interface PrivacyManager ()

@property (nonatomic, strong) UIView *backgroundView; ;

@end

@implementation PrivacyManager

+ (instancetype)manager {
    static PrivacyManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PrivacyManager alloc] init];
    });
    return instance;
}

- (void)showAfterAppLaunch {
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [self show];
    }];
}

- (void)show {
    
    BOOL isAgree = [[NSUserDefaults standardUserDefaults] boolForKey:kAgreementKey];
    if (isAgree) {
        return;
    }
    
    CGFloat cornerRadius = 6*kSCALE_WIDTH;
    CGFloat offset = 5*kSCALE_WIDTH;
    CGFloat footerHeight = 80*kSCALE_WIDTH;
    
    UIColor *lineColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    
    UIView *bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [kKeyWindow addSubview:bgView];
    self.backgroundView = bgView;
    
    UIView *contentView ;
    {
        CGFloat contentViewHeight = 100*kSCALE_HEIGHT;
        CGFloat widthOffset = 30*kSCALE_WIDTH ;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(widthOffset,[UIApplication sharedApplication].statusBarFrame.size.height + contentViewHeight, SCREEN_WIDTH - 2*widthOffset, SCREEN_HEIGHT - [UIApplication sharedApplication].statusBarFrame.size.height - 2*contentViewHeight)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = cornerRadius;
        view.layer.masksToBounds = YES;
        [bgView addSubview:view];
        contentView = view;
    }
    
    UILabel *titleLabel ;
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, contentView.frame.size.width, 50*kSCALE_WIDTH)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:17*kSCALE_WIDTH];
        label.textColor = [UIColor blackColor];
        label.text = @"隐私政策";
        [contentView addSubview:label];
        titleLabel = label;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, label.frame.size.height - 1, label.frame.size.width, 1)];
        line.backgroundColor = lineColor;
        [label addSubview:line];
    }
    
    UIView *footerView ;
    {
        UIView *controlView = [[UIView alloc] initWithFrame:CGRectMake(0, contentView.frame.size.height - footerHeight, contentView.frame.size.width, footerHeight)];
        [contentView addSubview:controlView];
        footerView = controlView;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, controlView.frame.size.width, 1)];
        line.backgroundColor = lineColor;
        [controlView addSubview:line];
        
        UIButton *privacyBtn ;
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button addTarget:self action:@selector(jumpToWebView) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:@"《隐私政策》" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            button.titleLabel.font = [UIFont systemFontOfSize:12*kSCALE_WIDTH];
            [controlView addSubview:button];
            [button sizeToFit];
            button.frame = CGRectMake(10*kSCALE_WIDTH, CGRectGetMaxY(line.frame) + offset, button.frame.size.width, button.frame.size.height);
            privacyBtn = button;
        }
        
        CGFloat btnWidth = (controlView.frame.size.width - 4*offset)/2;
        CGFloat btnHeight = controlView.frame.size.height - CGRectGetMaxY(privacyBtn.frame) - 2*offset;
        
        UIButton *unAgreeBtn;
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(offset, CGRectGetMaxY(privacyBtn.frame) + offset, btnWidth, btnHeight);
            [button addTarget:self action:@selector(unAgreeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:@"不同意并退出" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
            button.layer.cornerRadius = cornerRadius;
            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
            button.layer.borderWidth = 1;
            button.layer.masksToBounds = YES;
            button.titleLabel.font = [UIFont systemFontOfSize:17*kSCALE_WIDTH];
            
            [controlView addSubview:button];
            unAgreeBtn = button;
        }
        
        UIButton *agreeBtn;
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(CGRectGetMaxX(unAgreeBtn.frame) + 2*offset, CGRectGetMaxY(privacyBtn.frame) + offset, btnWidth, btnHeight);
            [button addTarget:self action:@selector(agreeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:@"同意" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
            button.backgroundColor = [UIColor redColor];
            button.layer.cornerRadius = cornerRadius;
            button.layer.masksToBounds = YES;
            button.titleLabel.font = [UIFont systemFontOfSize:17*kSCALE_WIDTH];
            
            [controlView addSubview:button];
            agreeBtn = button;
        }
        
    }
    
    {
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10*kSCALE_WIDTH, CGRectGetMaxY(titleLabel.frame), contentView.frame.size.width - 2*10*kSCALE_WIDTH, CGRectGetMinY(footerView.frame) - CGRectGetMaxY(titleLabel.frame))];
        [contentView addSubview:textView];
        textView.editable = NO;
        textView.showsVerticalScrollIndicator = NO;
        textView.attributedText = [self getAttributedString];
    }
    
    bgView.alpha = 0.0;
    [UIView animateWithDuration:0.15 animations:^{
        bgView.alpha = 1.0;
    }];
}

- (NSAttributedString *)getAttributedString {
    
    NSString *URLAgreement = [[NSBundle mainBundle] pathForResource:@"agreement" ofType:@"txt"];
    NSString *html = [NSString stringWithContentsOfFile:URLAgreement encoding:NSUTF8StringEncoding error:nil];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 8;
    style.paragraphSpacing = 5;
//    style.headIndent = 20*kSCALE_WIDTH ;
    
    NSDictionary *attributeDict = @{
                                    NSFontAttributeName: [UIFont systemFontOfSize:14*kSCALE_WIDTH],
                                    NSParagraphStyleAttributeName: style,
                                    NSForegroundColorAttributeName: [UIColor blackColor],
                                    NSKernAttributeName: @(1.5f),
                                    };
    NSAttributedString *attributeString = [[NSAttributedString alloc] initWithString:html attributes:attributeDict];
    
    return attributeString;
}

- (void)jumpToWebView {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://mgfjxxiexiaolong.github.io/2019/04/13/%E9%9A%90%E7%A7%81%E5%8D%8F%E8%AE%AE/"]];
}

- (void)agreeBtnClicked {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kAgreementKey];
    [self.backgroundView removeFromSuperview];
}

- (void)unAgreeBtnClicked {
    exit(0);
}

@end
