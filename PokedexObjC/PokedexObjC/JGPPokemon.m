//
//  JGPPokemon.m
//  PokedexObjC
//
//  Created by John Pitts on 7/26/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

#import "JGPPokemon.h"

@implementation JGPPokemon

- (nonnull instancetype) initWithName:(NSString *_Nonnull)name
                           identifier:(int)identifier
                            sprite:(NSString *_Nullable)sprite
                            abilities:(NSArray<NSString *> *)abilities {
    self = [super init];
    if (self) {
        _name = [name copy];
        _identifier = identifier;
        _sprite = [sprite copy];
        _abilities = [abilities copy];
    }
    return self;
}

- (nullable instancetype)initWithDictionary:(NSDictionary *_Nullable)dict {
    
    NSString *name = dict[@"name"];
    NSString *identifierString = dict[@"id"];
    int identifier = [identifierString intValue];
    NSString *sprite = dict[@"sprites.front_default"];
    
    
    NSArray<NSString *> *abilities = dict[@"ability.name"];
    
//    if (!name || !identifier || !sprite || !abilities) {
//        return nil;
//    }
    
    
    return [self initWithName:name
                   identifier:identifier
                    sprite:sprite
                    abilities:abilities];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@...name %d...id %@....sprite %@...abilities", self.name, self.identifier, self.sprite, self.abilities];
}



@end
