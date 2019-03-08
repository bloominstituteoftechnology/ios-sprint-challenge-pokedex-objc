//
//  ABCPokemon.m
//  PokedexObjC
//
//  Created by Austin Cole on 3/8/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

#import "ABCPokemon.h"

@implementation ABCPokemon

- (instancetype)initNameAndUrlWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self != nil) {
        _name = [dictionary valueForKey:@"name"];
        _url = [dictionary valueForKey:@"url"];
    }
    return self;
}

- (instancetype)fillInDetailsWithDictionary: (NSDictionary *)dictionary {
    if (self != nil) {
        NSMutableArray *abilities = [[NSMutableArray alloc] init];
        NSArray *dictAbilities = [dictionary valueForKey:@"abilities"];
        for (NSDictionary *abilitiesDictionary in dictAbilities) {
            NSDictionary *individualAbility = [abilitiesDictionary objectForKey:@"ability"];
            NSString *abilityName = [individualAbility objectForKey:@"name"];
            [abilities addObject:abilityName];
        }
        _abililties = abilities;
        
        _idNumber = [dictionary objectForKey:@"id"];
        
        NSDictionary *spritesDictionary = [dictionary objectForKey:@"sprites"];
        _sprite = [spritesDictionary objectForKey:@"front_default"];
    }
    return self;
}

@end
