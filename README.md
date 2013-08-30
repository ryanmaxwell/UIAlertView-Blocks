UIAlertViewBlocks
=================

Category on UIAlertView to use inline block callbacks instead of delegate callbacks.

UIAlertView was created in a time before blocks, ARC, and judging by its naming – touch screens too. Who “clicks” on an alert view anyway?

Lets modernize this shizzle with some blocks goodness.

```objc
typedef void (^UIAlertViewCompletionBlock) (UIAlertView *alertView, NSUInteger buttonIndex);
```

 Do it all in a single call:

```objc
+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
    cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitles:(NSArray *)otherButtonTitles
           completion:(UIAlertViewCompletionBlock)onTap;
```

If you need further customization, use the longer method:

```objc
+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
    cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitles:(NSArray *)otherButtonTitles
                onTap:(UIAlertViewCompletionBlock)onTap
        onWillDismiss:(UIAlertViewCompletionBlock)onWillDismiss
         onDidDismiss:(UIAlertViewCompletionBlock)onDidDismiss;
```
## Example

```objc
[UIAlertView showWithTitle:@"Drink Selection"
                   message:@"Choose a refreshing beverage"
         cancelButtonTitle:@"Cancel"
         otherButtonTitles:@[@"Beer", @"Wine"]
                completion:^(UIAlertView *alertView, NSUInteger buttonIndex) {
                    if (buttonIndex == [alertView cancelButtonIndex]) {
                        NSLog(@"Cancelled");
                    } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Beer"]) {
                        NSLog(@"Have a cold beer");
                    } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Wine"]) {
                        NSLog(@"Have a glass of chardonnay");
                    }
                }];
```

## Requirements

ARC - so iOS 4.3 or later

## Usage

Add `UIAlertView+Blocks.h/m` into your project, or `pod 'UIAlertViewBlocks'` using CocoaPods.