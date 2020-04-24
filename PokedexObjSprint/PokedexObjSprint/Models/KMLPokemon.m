//
//  KMLPokemon.m
//  PokedexObjSprint
//
//  Created by Keri Levesque on 4/24/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

#import "KMLPokemon.h"

@implementation KMLPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _name = dictionary[@"name"];
        _identifier = dictionary[@"id"];
       //the abilities array
        NSMutableArray *abilities = [[NSMutableArray alloc] init];
        NSArray<NSDictionary *> *abilitiesArray = dictionary[@"abilities"];
        
        for (NSDictionary *ability in abilitiesArray) {
            NSString *name = ability[@"ability"][@"name"];
            [abilities addObject:name];
        }
        
        _abilities = abilities;

        // the sprites
        NSString *string = dictionary[@"sprites"][@"front_default"];
        if (string != nil) {
            NSURL *url = [[NSURL alloc] initWithString:string];
            _spriteURL = url;
        };
    }
    return self;
}


@end
