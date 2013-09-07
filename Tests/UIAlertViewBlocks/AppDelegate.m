//
//  AppDelegate.m
//  UIAlertViewBlocks
//
//  Created by Ryan Maxwell on 7/09/13.
//  Copyright (c) 2013 Ryan Maxwell. All rights reserved.
//

#import "AppDelegate.h"
#import "UIAlertView+Blocks.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [UIAlertView showWithTitle:@"Test"
                       message:@"Test Message"
             cancelButtonTitle:@"Cancel"
             otherButtonTitles:@[@"One", @"Two"]
                      tapBlock:^(UIAlertView *alertView, NSInteger index){
                          NSLog(@"Tapped '%@' at index %d", [alertView buttonTitleAtIndex:index], index);
    }];
    
    return YES;
}

@end
