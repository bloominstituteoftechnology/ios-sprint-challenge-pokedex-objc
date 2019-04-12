//
//  FCCPokemon.m
//  Pokedex
//
//  Created by Lambda_School_Loaner_34 on 4/12/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

#import "FCCPokemon.h"

@implementation FCCPokemon

- (instancetype)initWithName:(NSString *)name identifier:(NSNumber *)identifier abilities:(NSArray *)abilities sprite:(NSURL *)sprite {
    
    self = [super init];
    if (self) {
        _name = [name copy];
        _identifier = [identifier copy];
        _abilities = [abilities copy];
        _sprite = [sprite copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSString *name = dictionary[@"name"];
    NSNumber *identifier = dictionary[@"id"];
    
    NSString *spriteString = dictionary[@"sprites"][@"front_default"];
    NSURL *sprite = [NSURL URLWithString:spriteString];
    
    NSMutableArray<NSString *> *abilities = [[NSMutableArray alloc] init];
    NSArray *abilitiesDictionary = dictionary[@"abilities"];
    
    for (NSDictionary *abilityDictionary in abilitiesDictionary) {
        NSString *ability = abilityDictionary[@"ability"][@"name"];
        
        [abilities addObject:ability];
    }
    return [self initWithName:name identifier:identifier abilities:abilities sprite:sprite];
}


@end
