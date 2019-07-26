//
//  DLJPokemon.m
//  ObjcPokemon
//
//  Created by Diante Lewis-Jolley on 7/26/19.
//  Copyright © 2019 Diante Lewis-Jolley. All rights reserved.
//

#import "DLJPokemon.h"

@implementation DLJPokemon

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {

    self = [super init];
    if (self) {

        NSString *name = dictionary[@"name"];
        NSInteger pokemonID = dictionary[@"id"];

        NSString *sprite = [dictionary valueForKeyPath:@"sprites.front_default"];

        NSArray *abilityArray = dictionary[@"abilities"];

        NSArray *abilityNames = [abilityArray valueForKeyPath:@"ability.name"];

        _name = name;
        _pokemonID = pokemonID;

        _sprite = sprite;
        _ablities = abilityNames;


    }
    return self;
}


@end
