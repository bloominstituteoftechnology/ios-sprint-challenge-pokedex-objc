//
//  ARPokemon.h
//  PokedexObjc
//
//  Created by Alex Rhodes on 11/14/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ARPokedexPokemon : NSObject

@property NSString *name;
@property NSString *url;

- (instancetype) initWithName:(NSString *)name url:(NSString *)pokeUrl;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end

