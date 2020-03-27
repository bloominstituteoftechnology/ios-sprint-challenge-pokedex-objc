//
//  JLAPokemon.h
//  PokedexSprint
//
//  Created by Jorge Alvarez on 3/27/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JLAPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, copy) NSURL *sprite;
@property (nonatomic, copy) NSArray *abilities;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END

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
