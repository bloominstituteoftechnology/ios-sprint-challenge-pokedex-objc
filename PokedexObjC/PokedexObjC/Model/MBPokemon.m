//
//  MBPokemon.m
//  PokedexObjC
//
//  Created by Mitchell Budge on 7/26/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

#import "MBPokemon.h"

@implementation MBPokemon

- (instancetype)initWithName:(NSString *)name sprite:(NSURL *)sprite idNumber:(NSNumber *)idNumber abilities:(NSArray *)abilities {
    self = [super init];
    if (self) {
        _name = [name copy];
        _sprite = [sprite copy];
        _idNumber = [idNumber copy];
        _abilities = [abilities copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSNumber *idNumber = dictionary[@"id"];

    NSString *spriteString = dictionary[@"sprites"][@"front_default"];
    NSURL *sprite = [NSURL URLWithString:spriteString];
    
    NSMutableArray<NSString *> *abilities = [[NSMutableArray alloc] init];
    NSArray *abilitiesDictionary = dictionary[@"abilities"];
    for (NSDictionary *abilityDictionary in abilitiesDictionary) {
        NSString *ability = abilityDictionary[@"ability"][@"name"];
        [abilities addObject:ability];
    }
    
    return [self initWithName:name sprite:sprite idNumber:idNumber abilities:abilities];
}

@end
