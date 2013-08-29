//
//  UIAlertViewBlocksDelegate.h
//  UIAlertViewBlocks
//
//  Created by Ryan Maxwell on 29/08/13.
//  Copyright (c) 2013 Ryan Maxwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIAlertView+Blocks.h"

@interface UIAlertViewBlocksDelegate : NSObject <UIAlertViewDelegate>

+ (instancetype)sharedInstance;

- (void)setOnTapBlock:(UIAlertViewCompletionBlock)onTap
   onWillDismissBlock:(UIAlertViewCompletionBlock)onWillDismiss
    onDidDismissBlock:(UIAlertViewCompletionBlock)onDidDismiss
         forAlertView:(UIAlertView *)alertView;

@end
