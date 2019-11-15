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
                   abilities:(NSArray *)abilities
                         URL:(NSURL *)imageURL {
    self = [super init];
    if (self) {
        _name = [name copy];
        _identifier = [identifier copy];
        _abilities = [abilities copy];
        _imageURL = imageURL;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    //name
    NSString *name = dictionary[@"name"];
    //ID
    NSNumber *identifier = dictionary[@"id"];
    //URL
    NSDictionary *imageURLDictionary = dictionary[@"sprites"];
    NSString *urlString = imageURLDictionary[@"front_default"];
    NSURL *imageURL = [NSURL URLWithString:urlString];
    //Abilities
    NSMutableArray *abilitiesArray = dictionary[@"abilities"];
    NSMutableArray *abilityNames = [[NSMutableArray alloc] init];
    for (NSDictionary *abilityDictionary in abilitiesArray) {
        NSDictionary *ability = abilityDictionary[@"ability"];
        NSArray *abilityName = ability[@"name"];
        [abilityNames addObject: [NSString stringWithFormat:@"%@\n", abilityName]];
    }
    
    return [self initWithName:name identifier:identifier abilities:[abilityNames copy] URL:imageURL];
}

@end
