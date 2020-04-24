//
//  EGCPokemon.m
//  Pokedex
//
//  Created by Enrique Gongora on 4/24/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

#import "EGCPokemon.h"

@implementation EGCPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _name = dictionary[@"name"];
        _identifier = dictionary[@"id"];
        
        NSMutableArray *abilities = [[NSMutableArray alloc] init];
        NSArray<NSDictionary *> *abilitiesArray = dictionary[@"abilities"];
        
        for (NSDictionary *ability in abilitiesArray) {
            NSString *name = ability[@"ability"][@"name"];
            [abilities addObject:name];
        }
        
        _abilities = abilities;
        
        NSString *string = dictionary[@"sprites"][@"front_default"];
        if (string != nil) {
            NSURL *url = [[NSURL alloc] initWithString:string];
            _spriteURL = url;
        };
    }
    return self;
}


@end
