//
//  MJRPokemon.m
//  Pokedex-Objc
//
//  Created by Marlon Raskin on 10/18/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

#import "MJRPokemon.h"

@interface MJRPokemon()

@property (nonatomic, nullable) NSMutableArray *abilitiesArray;

@end

@implementation MJRPokemon


- (instancetype)initWithName:(NSString *)name andURLString:(NSString *)urlString {
    if (self = [super init]) {
        self.name = name;
        self.pokemonURL = urlString;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.name = dictionary[@"name"];
        self.pokemonURL = dictionary[@"url"];
    }
    return self;
}

- (void)updateDetails:(NSDictionary *)jsonDict {
    _pokemonID = jsonDict[@"id"];
    _pokemonURL = jsonDict[@"sprites"][@"front_default"];
    [self getAbilitiesAsString:jsonDict[@"abilities"]];
}

- (void)getAbilitiesAsString:(NSArray *)array {

    NSMutableArray<NSString *> *abilities = [@[] mutableCopy];

    for (NSDictionary *abilityDict in array) {
        NSDictionary *abilityDic = abilityDict[@"ability"];
        NSString *ability = abilityDic[@"name"];
        [abilities addObject:ability];
    }
    self.abilities = [abilities componentsJoinedByString:@", "];
}

@end
