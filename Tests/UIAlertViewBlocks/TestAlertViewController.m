//
//  TestAlertViewController.m
//  UIAlertViewBlocks
//
//  Created by Ryan Maxwell on 7/09/13.
//  Copyright (c) 2013 Ryan Maxwell. All rights reserved.
//

#import "TestAlertViewController.h"
#import "UIAlertView+Blocks.h"

@interface TestAlertViewController ()

- (IBAction)showAlert:(id)sender;

@end

@implementation TestAlertViewController

- (IBAction)showAlert:(id)sender {
    [UIAlertView showWithTitle:@"Test"
                       message:@"Test Message"
             cancelButtonTitle:@"Cancel"
             otherButtonTitles:@[@"One", @"Two"]
                      tapBlock:^(UIAlertView *alertView, NSInteger index){
                          NSLog(@"Tapped '%@' at index %d", [alertView buttonTitleAtIndex:index], index);
                      }];
}

@end
