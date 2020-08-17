//
//  PokemonResults.h
//  POKEOBJCDEX
//
//  Created by Kelson Hartle on 8/16/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KRHPokemon;

NS_ASSUME_NONNULL_BEGIN

@interface PokemonResults : NSObject

@property (nonatomic, readonly, copy) NSArray<KRHPokemon *> *pokemon;

- (instancetype)initWithPokemonName:(NSArray<KRHPokemon *> *)pokemonName;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
