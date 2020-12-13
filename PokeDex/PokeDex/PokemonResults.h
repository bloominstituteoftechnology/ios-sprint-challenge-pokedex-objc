//
//  PokemonResults.h
//  PokeDex
//
//  Created by Bohdan Tkachenko on 12/12/20.
//

#import <Foundation/Foundation.h>

@class BTPokemon;

NS_ASSUME_NONNULL_BEGIN

@interface PokemonResults : NSObject

@property (nonatomic, readonly, copy) NSArray<BTPokemon *> *pokemon;

- (instancetype)initWithPokemonName:(NSArray<BTPokemon *> *)pokemonName;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
