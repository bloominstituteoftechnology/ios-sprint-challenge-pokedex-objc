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
                            abilities:(NSArray<JGPAbility *> *_Nullable)abilities {
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
    int identifier = dict[@"identifier"];
    NSString *sprite = dict[@"sprite"];
    NSArray<JGPAbility *> *abilities = dict [@"abilities"];
    
    if (!name || !identifier || !sprite || !abilities) {
        return nil;
    }
    
    
    return [self initWithName:name
                   identifier:identifier
                    sprite:sprite
                    abilities:abilities];
}



@end
