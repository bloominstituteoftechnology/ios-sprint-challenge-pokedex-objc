//
//  JPHPokedexPokemon.h
//  ObjCPokedex
//
//  Created by Jerry haaser on 1/31/20.
//  Copyright © 2020 Jerry haaser. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface JPHPokedexPokemon : NSObject

@property NSString *name;
@property NSString *url;

- (instancetype) initWithName:(NSString *)name url:(NSString *)pokeUrl;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end


