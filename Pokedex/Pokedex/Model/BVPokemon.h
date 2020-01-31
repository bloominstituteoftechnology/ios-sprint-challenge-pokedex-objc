//
//  BVPokemon.h
//  Pokedex
//
//  Created by brian vilchez on 1/31/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BVPokemon : NSObject
@property(nonatomic) NSString *name;

@property(nonatomic) NSString *sprite;
@property(nonatomic) NSArray * abilities;

- (instancetype)initWithName:(NSString *)name sprite:(NSString *)sprite abilities:(NSArray *)abilities;
- (instancetype)initWithResultsName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
