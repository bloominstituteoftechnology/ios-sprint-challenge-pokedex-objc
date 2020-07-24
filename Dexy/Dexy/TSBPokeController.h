//
//  TSBPokeController.h
//  Dexy
//
//  Created by Thomas Sabino-Benowitz on 7/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSBPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSBPokeController : NSObject

@property (nonatomic) TSBPokemon *pokemon;

- (instancetype)init;
- (void)fetchAllPokemonCompletion:(void (^)(NSArray<TSBPokemon *> * _Nullable pokemons, NSError * _Nullable error))completion;
- (void)addJsonDetails:(TSBPokemon *)pokemon;


@end

NS_ASSUME_NONNULL_END
