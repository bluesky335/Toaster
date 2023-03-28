//
//  KeyboardObserver.h
//  
//
//  Created by BlueSky335 on 2023/3/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyboardObserver : NSObject
@property (assign,nonatomic) CGRect keyboardEndFrame;
+ (KeyboardObserver *) share;
@end

NS_ASSUME_NONNULL_END
