//
//  JPHPokemon.m
//  ObjCPokedex
//
//  Created by Jerry haaser on 1/31/20.
//  Copyright © 2020 Jerry haaser. All rights reserved.
//

#import "JPHPokemon.h"

@implementation JPHPokemon

- (instancetype)initWithName:(NSString *)name abilities:(NSArray <NSString *>*)abilities ID:(NSNumber *)ID sprite:(NSURL *)sprite {
    self = [super init];
    if (self) {
        _name = name;
        _abilities = abilities;
        _ID = ID;
        _sprite = sprite;
        
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSNumber *ID = dictionary[@"id"];
    NSString *name = dictionary[@"name"];
    
    NSDictionary *sprites = dictionary[@"sprites"];
    NSURL *sprite = sprites[@"front_default"];
    
    NSMutableArray *abilitiesArray = dictionary[@"abilities"];
    NSMutableArray *abilityNames = [[NSMutableArray alloc] init];
    for (NSDictionary *abilityDictionary in abilitiesArray) {
        NSDictionary *ability = abilityDictionary[@"ability"];
        NSArray *abilityName = ability[@"name"];
        [abilityNames addObject: [NSString stringWithFormat:@"%@\n", abilityName]];
    }
    return [self initWithName:name abilities:abilityNames ID:ID sprite:sprite];
}
@end
