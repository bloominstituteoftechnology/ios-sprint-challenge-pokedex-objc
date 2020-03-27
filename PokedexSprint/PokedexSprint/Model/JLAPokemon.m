//
//  JLAPokemon.m
//  PokedexSprint
//
//  Created by Jorge Alvarez on 3/27/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

#import "JLAPokemon.h"

@implementation JLAPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if (self = [super init]) {
        
        NSString *name = dictionary[@"name"];
        
        NSNumber *identifier = dictionary[@"id"];
        
        // { [{}] }
        NSDictionary *sprites = dictionary[@"sprites"];
        NSString *spriteString = sprites[@"front_default"];
        NSURL *sprite = [NSURL URLWithString:spriteString];
        
        // abilites [@"ability"] / ability @["name"]
        NSMutableArray *abilitiesArray = [[NSMutableArray alloc] init];
        NSArray *abilitiesDictionary = dictionary[@"abilities"];
        for (NSDictionary *abilityDictionary in abilitiesDictionary) {
            
            NSDictionary *abilityDict = abilityDictionary[@"ability"];
            NSString *abilityName = abilityDict[@"name"];
            
            [abilitiesArray addObject:abilityName];
        }
        
        _name = name;
        _identifier = identifier;
        _sprite = sprite;
        _abilities = abilitiesArray;
    }
    return self;
}
@end

// abilites [@"ability"] / ability @["name"]
// [@"front_default"]
/*
 {
 "abilities": [
   {
     "ability": {
       "name": "imposter",
       "url": "https://pokeapi.co/api/v2/ability/150/"
     },
     "is_hidden": true,
     "slot": 3
   },
   {
     "ability": {
       "name": "limber",
       "url": "https://pokeapi.co/api/v2/ability/7/"
     },
     "is_hidden": false,
     "slot": 1
   }
 ], ... }
 
 ------
 
 "sprites": {
   "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/132.png",
   "back_female": null,
   "back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/132.png",
   "back_shiny_female": null,
   "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png",
   "front_female": null,
   "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/132.png",
   "front_shiny_female": null
 },
 
 */
