//
//  BTPokemonAbillities.m
//  PokeDex
//
//  Created by Bohdan Tkachenko on 12/12/20.
//

#import "BTPokemonAbillities.h"

@implementation BTPokemonAbillities

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

// FIXME: looping through the multiple dictionaries to get all abilities.

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    
    self = [self initWithName:name];
    return self;
}


@end
