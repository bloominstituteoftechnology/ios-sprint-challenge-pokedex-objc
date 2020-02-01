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
@property(nonatomic, nullable) NSString *name;
@property(nonatomic, nullable) NSString *sprite;
@property(nonatomic, nullable) NSArray<NSString *> * abilities;
@property(nonatomic) int pokemonID;

- (instancetype)initWithName:(NSString *)name sprite:(NSString *)sprite abilities:(NSArray *)abilities pokemonID:(int)pokemonID;
- (instancetype)initWithResultsName:(NSString *)name;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
