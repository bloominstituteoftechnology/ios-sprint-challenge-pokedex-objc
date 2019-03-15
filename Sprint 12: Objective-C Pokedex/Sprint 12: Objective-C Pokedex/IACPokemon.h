//
//  IACPokemon.h
//  Sprint 12: Objective-C Pokedex
//
//  Created by Ivan Caldwell on 3/15/19.
//  Copyright © 2019 Ivan Caldwell. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// Your model must support at least: pokemon name, identifier, sprite, and abilities.
@interface IACPokemon : NSObject

@property (readonly, copy) NSString *pokemonName;
@property (readonly, copy) NSURL *pokemonURL;
@property (readonly) NSNumber *pokemonID;
@property (readonly) NSArray<NSString *> *pokemonAbilities;
@property (readonly, copy) NSURL *pokemonFrontDefaultURL;

- (instancetype _Nullable) initPokemonDictionary: (NSDictionary *)dictionary;
- (void) fillInPokemonDictionary: (NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
