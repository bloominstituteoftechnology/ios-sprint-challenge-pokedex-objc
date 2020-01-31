//
//  DPRPokemon.m
//  Pokedex
//
//  Created by Dennis Rudolph on 1/31/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "DPRPokemon.h"

@implementation DPRPokemon

- (nonnull instancetype)initWithName:(nonnull NSString *)name URL:(nonnull NSURL *)url {
    self = [super init];
    if (self) {
        _name = name;
        _url = url;
    }
    return self;
}

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSString *urlString = dictionary[@"url"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    if (!name) {
        return nil;
    }
    
    if(!url) {
        return nil;
    }
    
    return [self initWithName:name URL:url];
}

- (void)finishDetails:(nonnull DPRPokemon *)pokemon withDictionary:(nonnull NSDictionary *)dictionary {
    
    NSNumber *identifier = dictionary[@"id"];
    
    NSDictionary *sprites = dictionary[@"sprites"];
    NSString *spriteString = sprites[@"front_default"];
    NSURL *spriteURL = [NSURL URLWithString:spriteString];
    NSMutableArray *abilities = dictionary[@"abilities"];
    
    NSMutableArray *abilitiesArray = [[NSMutableArray alloc] init];
    for (NSDictionary *abilityDict in abilities) {
        NSDictionary *ability = abilityDict[@"ability"];
        NSString *abilityName = ability[@"name"];
        [abilitiesArray addObject: [NSString stringWithFormat:@"%@", abilityName]];
    }
    
    self.spriteURL = spriteURL;
    self.abilities = abilitiesArray;
    self.identifier = identifier;
}

@end
