//
//  JLCPokemon.m
//  Pokedex-objc-ST
//
//  Created by Jake Connerly on 11/15/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

#import "JLCPokemon.h"

@implementation JLCPokemon

- (instancetype)initWithName:(NSString *)name
                  identifier:(NSNumber *)identifier
                   abilities:(NSArray *)abilities {
    self = [super init];
    if (self) {
        _name = [name copy];
        _identifier = [identifier copy];
        _abilities = [abilities copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSNumber *identifier = dictionary[@"id"];
    NSMutableArray *abilitiesArray = dictionary[@"abilities"];
    NSMutableArray *abilityNames = [[NSMutableArray alloc] init];
    
    for (NSDictionary *abilityDictionary in abilitiesArray) {
        NSDictionary *ability = abilityDictionary[@"ability"];
        NSArray *abilityName = ability[@"name"];
        [abilityNames addObject: [NSString stringWithFormat:@"%@\n", abilityName]];
    }
    
    return [self initWithName:name identifier:identifier abilities:[abilityNames copy]];
}

@end
