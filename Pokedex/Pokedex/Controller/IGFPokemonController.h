//
//  IGFPokemonController.h
//  Pokedex
//
//  Created by Ian French on 12/12/20.
//

#import <Foundation/Foundation.h>



@class IGFPokemonModel;

@interface IGFPokemonController : NSObject

- (void)fetchPokemonFromAPI:(void (^)(NSError *error))completion;

- (void)fetchPokemonDetailsFromAPI:(IGFPokemonModel *)pokemon;

- (NSArray <IGFPokemonModel *> *)getPokemons;



@end

