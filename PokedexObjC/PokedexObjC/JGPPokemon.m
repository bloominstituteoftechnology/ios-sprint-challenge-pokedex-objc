//
//  JGPPokemon.m
//  PokedexObjC
//
//  Created by John Pitts on 7/26/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

#import "JGPPokemon.h"
#import "JGPAbility.h"

@implementation JGPPokemon

- (nonnull instancetype) initWithName:(NSString *_Nonnull)name
                           identifier:(int)identifier
                            sprite:(NSString *_Nullable)sprite
                            abilities:(NSArray<JGPAbility *> *)abilities {
    self = [super init];
    if (self) {
        _name = [name copy];
        _identifier = identifier;
        _sprite = [sprite copy];
        _abilities = [abilities copy];
    }
    return self;
}

- (nullable instancetype)initWithDictionary:(NSDictionary *_Nullable)dictionary {
    
    
    NSString *name = dictionary[@"name"];
    
    NSString *identifierString = dictionary[@"id"];
    int identifier = [identifierString intValue];
    
    NSString *sprite = dictionary[@"sprites"][@"front_default"];
    
    // TRY THIS KVC METHOD BY UNCOMMENTING THE TWO LINES BELOW TO SEE IF IT ACHIEVES SAME AS LINES 42-46 ????????????????
    // NSArray *abilitiesTopLevel = dictionary[@"abilities"]
    // NSArray *abilities = [abilitiesTopLevel valueForKeyPath:@"ability.name"];
    
    NSMutableArray *abilities = [NSMutableArray array];
    NSArray *abilitiesImmutable = dictionary[@"abilities"];
    for (NSDictionary *dict in abilitiesImmutable) {
        JGPAbility *ability = [[JGPAbility alloc] initWithDictionary:dict];
        [abilities addObject:ability];
    }
    return [self initWithName:name identifier:identifier sprite:sprite abilities:abilities];
}


- (NSString *)description {
    return [NSString stringWithFormat:@"name:%@\nid=%d\nsprite=%@\nabilities=%@", self.name, self.identifier, self.sprite, self.abilities];
}



@end
