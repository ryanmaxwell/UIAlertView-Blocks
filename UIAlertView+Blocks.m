//
//  UIAlertView+Blocks.m
//  UIAlertViewBlocks
//
//  Created by Ryan Maxwell on 29/08/13.
//  Copyright (c) 2013 Ryan Maxwell. All rights reserved.
//

#import "UIAlertView+Blocks.h"

@interface UIAlertViewBlocksManager : NSObject <UIAlertViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *onTapBlocks;
@property (strong, nonatomic) NSMutableDictionary *onWillDismissBlocks;
@property (strong, nonatomic) NSMutableDictionary *onDidDismissBlocks;

+ (instancetype)sharedInstance;

- (void)setOnTapBlock:(UIAlertViewCompletionBlock)onTap
   onWillDismissBlock:(UIAlertViewCompletionBlock)onWillDismiss
    onDidDismissBlock:(UIAlertViewCompletionBlock)onDidDismiss
         forAlertView:(UIAlertView *)alertView;

@end

@implementation UIAlertViewBlocksManager

+ (instancetype)sharedInstance {
    static id instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (id)init {
    self = [super init];
    
    if (self) {
        _onTapBlocks = [NSMutableDictionary dictionary];
        _onWillDismissBlocks = [NSMutableDictionary dictionary];
        _onDidDismissBlocks = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setOnTapBlock:(UIAlertViewCompletionBlock)onTap
   onWillDismissBlock:(UIAlertViewCompletionBlock)onWillDismiss
    onDidDismissBlock:(UIAlertViewCompletionBlock)onDidDismiss
         forAlertView:(UIAlertView *)alertView {
    NSString *hashString = [NSString stringWithFormat:@"%d", alertView.hash];
    
    if (onTap) {
        self.onTapBlocks[hashString] = onTap;
    }
    if (onWillDismiss) {
        self.onWillDismissBlocks[hashString] = onWillDismiss;
    }
    if (onDidDismiss) {
        self.onDidDismissBlocks[hashString] = onDidDismiss;
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *hashString = [NSString stringWithFormat:@"%d", alertView.hash];
    
    UIAlertViewCompletionBlock completion = self.onTapBlocks[hashString];
    
    if (completion) {
        completion(alertView, buttonIndex);
        
        [self.onTapBlocks removeObjectForKey:hashString];
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSString *hashString = [NSString stringWithFormat:@"%d", alertView.hash];
    
    UIAlertViewCompletionBlock completion = self.onWillDismissBlocks[hashString];
    
    if (completion) {
        completion(alertView, buttonIndex);
        
        [self.onWillDismissBlocks removeObjectForKey:hashString];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    alertView.delegate = nil;
    
    NSString *hashString = [NSString stringWithFormat:@"%d", alertView.hash];
    
    UIAlertViewCompletionBlock completion = self.onDidDismissBlocks[hashString];
    
    if (completion) {
        completion(alertView, buttonIndex);
        
        [self.onDidDismissBlocks removeObjectForKey:hashString];
    }
}

@end

@implementation UIAlertView (Blocks)

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
    cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitles:(NSArray *)otherButtonTitles
                onTap:(UIAlertViewCompletionBlock)onTap
        onWillDismiss:(UIAlertViewCompletionBlock)onWillDismiss
         onDidDismiss:(UIAlertViewCompletionBlock)onDidDismiss {
    
    UIAlertView *alertView = [[self alloc] initWithTitle:title
                                                 message:message
                                                delegate:nil
                                       cancelButtonTitle:cancelButtonTitle
                                       otherButtonTitles:nil];
    
    for (NSString *buttonTitle in otherButtonTitles) {
        [alertView addButtonWithTitle:buttonTitle];
    }
    
    if (onTap || onWillDismiss || onDidDismiss) {
        alertView.delegate = [UIAlertViewBlocksManager sharedInstance];
        [[UIAlertViewBlocksManager sharedInstance] setOnTapBlock:onTap onWillDismissBlock:onWillDismiss onDidDismissBlock:onDidDismiss forAlertView:alertView];
    }
    
    [alertView show];
}

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
    cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitles:(NSArray *)otherButtonTitles
           completion:(UIAlertViewCompletionBlock)completion {
    
    [self showWithTitle:title
                message:message
      cancelButtonTitle:cancelButtonTitle
      otherButtonTitles:otherButtonTitles
                  onTap:completion
          onWillDismiss:nil
           onDidDismiss:nil];
}

@end
