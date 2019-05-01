//
//  PrivacyManager.h
//  test
//
//  Created by mgfjx on 2018/11/7.
//  Copyright © 2018 mgfjx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrivacyManager : NSObject

+ (instancetype)manager ;

@property (nonatomic, strong) NSString *title ;
@property (nonatomic, strong) NSString *content ;

- (void)show ;
- (void)showAfterAppLaunch ;

@end
