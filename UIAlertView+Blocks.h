//
//  UIAlertView+Blocks.h
//  UIAlertViewBlocks
//
//  Created by Ryan Maxwell on 29/08/13.
//  Copyright (c) 2013 Ryan Maxwell. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UIAlertViewCompletionBlock) (UIAlertView *alertView, NSInteger buttonIndex);

@interface UIAlertView (Blocks)

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
    cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitles:(NSArray *)otherButtonTitles
                onTap:(UIAlertViewCompletionBlock)onTap
        onWillDismiss:(UIAlertViewCompletionBlock)onWillDismiss
         onDidDismiss:(UIAlertViewCompletionBlock)onDidDismiss;

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
    cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitles:(NSArray *)otherButtonTitles
           completion:(UIAlertViewCompletionBlock)onTap;

@end
