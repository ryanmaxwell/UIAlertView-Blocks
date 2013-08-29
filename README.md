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
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:(NSArray *)otherButtonTitles
                completion:(UIAlertViewCompletionBlock)onTap;
```

If you need further customization, use the longer method:

```objc
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:(NSArray *)otherButtonTitles
                     onTap:(UIAlertViewCompletionBlock)onTap
             onWillDismiss:(UIAlertViewCompletionBlock)onWillDismiss
              onDidDismiss:(UIAlertViewCompletionBlock)onDidDismiss;
```