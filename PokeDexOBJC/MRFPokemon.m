//
//  MRFPokemon.m
//  PokeDexOBJC
//
//  Created by Michael Flowers on 11/23/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

#import "MRFPokemon.h"

@implementation MRFPokemon

- (nonnull instancetype)initWithName:(NSString *_Nonnull)name
                          identifier:(int)identifier
                              sprite:(NSString *_Nonnull)sprite
                           abilities:(NSArray *_Nonnull)abilities
{
    if (self = [super init])
    {
        _name = name;
        _identifier = identifier;
        _sprite = sprite;
        _abilities = abilities;
    }
    
    return self;
    
}

- (nullable instancetype)initWithDictionary:(NSDictionary *_Nullable)dictionary { //we need this to populate the detailView
    //initialize dictionary
    self = [super init];
    
    if (self){
        //this is where we map our properties to the names/spelling on the api
        _name = dictionary[@"name"];
        _identifier = [dictionary[@"id"] intValue];
        _sprite = dictionary[@"sprites"][@"front_default"];
        _abilities = dictionary[@"abilities"][@"ability"][@"name"];
        
//        NSString *name = dictionary[@"name"];
//        int identifier = [dictionary[@"id"] intValue];
//
//        NSDictionary *sprites = dictionary[@"sprites"];
//        NSString *spriteURL = sprites[@"front_default"];
//
//        NSMutableArray *abilitiesArray = dictionary[@"abilitites"];
//        NSMutableArray *abilityNames = [[NSMutableArray  alloc] init];
//
//        for (NSDictionary *abilityDictionary in abilitiesArray)
//        {
//            NSDictionary *ability = abilityDictionary[@"ability"];
//            NSArray *abilityName = ability[@"name"];
//            [abilityNames addObject:[NSString stringWithFormat:@"%@\n", abilityName]];
//        }
        
    }
    return self;
//    return [self initWithName:name identifier:identifier sprite:spriteURL abilities:abilities];
}

@end
