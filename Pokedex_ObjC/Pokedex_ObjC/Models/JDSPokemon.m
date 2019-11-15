//
//  JDSPokemon.m
//  Pokedex_ObjC
//
//  Created by Lambda_School_Loaner_214 on 11/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import "JDSPokemon.h"

@implementation JDSPokemon
-(instancetype)initWithName:(NSString *)name sprite:(NSURL *)spriteURL idNumber:(NSNumber *)idNumber abilities:(NSArray *)abilities{
    self = [super init];
    if (self) {
        _name       = [name copy];
        _spriteURL  = [spriteURL copy];
        _idNumber   = [idNumber copy];
        _abilities  = [abilities copy];
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    NSString *name = dictionary[@"name"];
    NSNumber *idNumber = dictionary[@"id"];
    NSString *spriteURLString = dictionary[@"sprites"][@"front_default"];
    NSURL *spriteURL = [NSURL URLWithString:spriteURLString];
    NSMutableArray<NSString *> *abilities = [[NSMutableArray alloc] init];
    NSArray *abilitiesDictionary = dictionary[@"abilities"];
    for (NSDictionary *abilityDictionary in abilitiesDictionary) {
        NSString *ability = abilityDictionary[@"ability"][@"name"];
        [abilities addObject:ability];
    }
    
    return [self initWithName:name sprite:spriteURL idNumber:idNumber abilities:abilities];
}
@end
