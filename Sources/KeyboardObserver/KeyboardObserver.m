//
//  KeyboardObserver.m
//  
//
//  Created by BlueSky335 on 2023/3/24.
//

#import "./include/KeyboardObserver.h"

@import UIKit;

@implementation KeyboardObserver

+ (void) load {
    [KeyboardObserver share];
}

+ (KeyboardObserver *)share {
    static KeyboardObserver * obj = NULL;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        obj = [[KeyboardObserver alloc] init];
    });
    return obj;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup {
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        NSValue * value = [note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        self.keyboardEndFrame = value.CGRectValue;
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        self.keyboardEndFrame = CGRectZero;
    }];
}

@end
