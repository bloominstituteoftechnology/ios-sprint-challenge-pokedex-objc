//
//  Pokemon.h
//  Pokedex
//
//  Created by Joe Veverka on 7/24/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

// Poke properties!
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, nullable) NSURL *spriteURL;
@property (nonatomic, nullable) NSArray<NSString *> *abilities;

// Poke Init!
- (instancetype)initWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
