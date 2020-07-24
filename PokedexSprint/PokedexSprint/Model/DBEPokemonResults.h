//
//  DBEPokemonResults.h
//  PokedexSprint
//
//  Created by Dahna on 7/24/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DBEPokemon;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(PokemonResults)
@interface DBEPokemonResults : NSObject

@property (nonatomic, readonly, copy) NSArray<DBEPokemon *> *pokemonArray;

- (instancetype)initWithPokemonArray:(NSArray<DBEPokemon *> *)pokemonArray;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
