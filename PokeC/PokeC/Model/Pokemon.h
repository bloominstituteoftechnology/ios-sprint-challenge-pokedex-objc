//
//  Pokemon.h
//  PokeC
//
//  Created by Lotanna Igwe-Odunze on 3/15/19.
//  Copyright © 2019 Sugabelly LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

@property (readonly, copy) NSString *name;
@property (readonly, copy) NSURL *url;
@property (readonly, nullable, copy) NSString *identifier;
@property (readonly, nullable, copy) NSURL *spriteURL;
@property (readonly, nullable, copy) NSArray<NSString *> *abilities;
@property (readonly) NSString *abilityString;

- (instancetype _Nullable)initWithDictionary: (NSDictionary<NSString *, NSString *> *)dictionary;

- (void)fillInWithDictionary: (NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
