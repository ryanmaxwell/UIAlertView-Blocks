//
//  UIAlertView+Blocks.m
//  UIAlertViewBlocks
//
//  Created by Ryan Maxwell on 29/08/13.
//  Copyright (c) 2013 Ryan Maxwell. All rights reserved.
//

#import "UIAlertView+Blocks.h"
#import "UIAlertViewBlocksDelegate.h"

@implementation UIAlertView (Blocks)

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:(NSArray *)otherButtonTitles
                     onTap:(UIAlertViewCompletionBlock)onTap
             onWillDismiss:(UIAlertViewCompletionBlock)onWillDismiss
              onDidDismiss:(UIAlertViewCompletionBlock)onDidDismiss {
    
    UIAlertView *alertView = [[self alloc] initWithTitle:title
                                                 message:message
                                                delegate:[UIAlertViewBlocksDelegate sharedInstance]
                                       cancelButtonTitle:cancelButtonTitle
                                       otherButtonTitles:nil];
    
    for (NSString *buttonTitle in otherButtonTitles) {
        [alertView addButtonWithTitle:buttonTitle];
    }
    
    if (onTap) {
        [[UIAlertViewBlocksDelegate sharedInstance] setOnTapBlock:onTap onWillDismissBlock:onWillDismiss onDidDismissBlock:onDidDismiss forAlertView:alertView];
    }
    
    [alertView show];
}

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:(NSArray *)otherButtonTitles
                completion:(UIAlertViewCompletionBlock)onTap {
    
    [self showAlertWithTitle:title
                     message:message
           cancelButtonTitle:cancelButtonTitle
           otherButtonTitles:otherButtonTitles
                       onTap:onTap
               onWillDismiss:nil
                onDidDismiss:nil];
}

@end
