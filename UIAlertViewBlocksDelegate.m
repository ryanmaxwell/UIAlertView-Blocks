//
//  UIAlertViewBlocksDelegate.m
//  UIAlertViewBlocks
//
//  Created by Ryan Maxwell on 29/08/13.
//  Copyright (c) 2013 Ryan Maxwell. All rights reserved.
//

#import "UIAlertViewBlocksDelegate.h"

@interface UIAlertViewBlocksDelegate ()
@property (strong, nonatomic) NSMutableDictionary *onTapBlocks;
@property (strong, nonatomic) NSMutableDictionary *onWillDismissBlocks;
@property (strong, nonatomic) NSMutableDictionary *onDidDismissBlocks;
@end

@implementation UIAlertViewBlocksDelegate

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
