//
//  OSIPokemonController.h
//  Sprint12
//
//  Created by Sergey Osipyan on 3/8/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OSIPokemonName;
@class OSIPokemon;

typedef void(^PokemonCompletionHandler)(OSIPokemonName *pokemon, NSError *error);
typedef void(^PokemonDetailsCompletionHandler)(OSIPokemon * pokemon,  NSError *error);

NS_ASSUME_NONNULL_BEGIN

@interface OSIPokemonController : NSObject


- (void)fetchPokemonName:(PokemonCompletionHandler)handler;
- (void)fetchPokemonWithURL:(NSString *)pokemonURL complition:(PokemonDetailsCompletionHandler)complition;

@end

NS_ASSUME_NONNULL_END
