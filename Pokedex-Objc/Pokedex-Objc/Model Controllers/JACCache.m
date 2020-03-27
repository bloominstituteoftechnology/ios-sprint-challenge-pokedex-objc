//
//  NSObject+JACCache.m
//  Pokedex-Objc
//
//  Created by Jordan Christensen on 3/26/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

#import "JACCache.h"

@interface JACCache ()
@property NSMutableDictionary *dict;
@end

@implementation JACCache : NSObject

- (instancetype)init {
    if (self = [super init]) {
        _dict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setValue:(UIImage *)image withKey:(NSString *)key {
    [_dict setValue:image forKey:key];
}

- (UIImage *)getValueWithKey:(NSString *)key {
    UIImage *image = [_dict valueForKey:key];
    if (image) {
        return image;
    } else {
        return NULL;
    }
}
@end
