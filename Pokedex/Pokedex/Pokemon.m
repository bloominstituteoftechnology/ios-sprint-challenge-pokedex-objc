//
//  Pokemon.m
//  Pokedex
//
//  Created by Lambda_School_Loaner_241 on 10/9/20.
//

#import "Pokemon.h"

@implementation Pokemon
- (instancetype)initWithName: (NSString *)pokemonName abilities: (NSString *)pokemonAbilities number: (double) numb
{
    if(self = [super init]){
        _name = pokemonName;
        _abilities = pokemonAbilities;
        _number = numb;
        
    }
    
    return self;
}

@end
