//
//  IGFPokemonController.m
//  Pokedex
//
//  Created by Ian French on 12/12/20.
//

#import "IGFPokemonController.h"
#import "Pokedex-Swift.h"

@interface IGFPokemonController()

@property (nonatomic)  NSArray<IGFPokemonModel *> *pokemons;

@end

@implementation IGFPokemonController

- (void)fetchPokemonFromAPI:(void (^)(NSError *error))completion
{
    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<IGFPokemonModel *> *pokemons, NSError *error) {
        if (error) {
            completion(error);
            return;
        } else {
            self.pokemons =  [[NSArray alloc] initWithArray:pokemons];
            completion(nil);
        }
    }];

}

- (void)fetchPokemonDetailsFromAPI:(IGFPokemonModel *)pokemon
{
    [PokemonAPI.sharedController fillInDetailsFor:pokemon];
}

- (NSArray <IGFPokemonModel *> *)getPokemons {
    return self.pokemons;
}









@end
