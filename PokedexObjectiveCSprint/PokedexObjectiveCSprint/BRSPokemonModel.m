//
//  BRSPokemonModel.m
//  PokedexObjectiveCSprint
//
//  Created by BrysonSaclausa on 12/12/20.
//

#import "BRSPokemonModel.h"

@implementation BRSPokemonModel

- (instancetype)initWithName:(NSString *)aName identifier:(NSString *)identifier;
{
    self = [super init];
    if (self) {
        _name = aName;
        _identifier = identifier;
    }
    return self;
}

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    //do work
    return self;
}

@end
