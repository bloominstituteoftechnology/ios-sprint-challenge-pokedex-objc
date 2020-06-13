//
//  DSCPokemon.m
//  PokedexOBJC
//
//  Created by denis cedeno on 6/12/20.
//  Copyright © 2020 DenCedeno Co. All rights reserved.
//

#import "DSCPokemon.h"

@interface DSCPokemon()
@property (nonatomic, nullable) NSMutableArray *abilitiesArray;
@end

@implementation DSCPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.name = dictionary[@"name"];
        self.pokemonURL = dictionary[@"url"];
    }
    return self;
}

@end
