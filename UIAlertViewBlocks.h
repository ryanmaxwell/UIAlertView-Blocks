//
//  UIAlertViewBlocks.h
//  UIAlertViewBlocks
//
//  Created by Ryan Maxwell on 29/08/13.
//  Copyright (c) 2013 Ryan Maxwell. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UIAlertViewCompletionBlock) (UIAlertView *alertView, NSUInteger buttonIndex);

@interface UIAlertView (Blocks)

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:(NSArray *)otherButtonTitles
                     onTap:(UIAlertViewCompletionBlock)onTap
             onWillDismiss:(UIAlertViewCompletionBlock)onWillDismiss
              onDidDismiss:(UIAlertViewCompletionBlock)onDidDismiss;

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:(NSArray *)otherButtonTitles
                completion:(UIAlertViewCompletionBlock)onTap;

@end

@interface UIAlertViewBlocksDelegate : NSObject <UIAlertViewDelegate>

+ (instancetype)sharedInstance;

- (void)setOnTapBlock:(UIAlertViewCompletionBlock)onTap
   onWillDismissBlock:(UIAlertViewCompletionBlock)onWillDismiss
    onDidDismissBlock:(UIAlertViewCompletionBlock)onDidDismiss
         forAlertView:(UIAlertView *)alertView;

@end
