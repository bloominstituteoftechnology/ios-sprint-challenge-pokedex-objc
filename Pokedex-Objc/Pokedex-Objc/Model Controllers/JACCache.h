//
//  NSObject+JACCache.h
//  Pokedex-Objc
//
//  Created by Jordan Christensen on 3/26/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JACCache : NSObject
- (void)setValue:(UIImage *)image withKey:(NSString *)key;
- (nullable UIImage *)getValueWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
