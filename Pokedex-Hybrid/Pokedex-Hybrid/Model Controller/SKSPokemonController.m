//
//  SKSPokemonController.m
//  Pokedex-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/31/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "SKSPokemonController.h"
#import "Pokedex_Hybrid-Swift.h"

@interface SKSPokemonController()

@property (nonatomic) NSArray<SKSPokemon *> *pokemons;

@end

@implementation SKSPokemonController


- (void)fetchPokemonWithPokemonAPI:(void (^)(NSError *error))completion {
    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<SKSPokemon *> *pokemons, NSError *error) {
        if (error) {
            completion(error);
            return;
        } else {
            self.pokemons =  [[NSArray alloc] initWithArray:pokemons];
            completion(nil);
        }
    }];

}

- (NSArray <SKSPokemon *> *)getPokemons {
    return self.pokemons;
}

@end
