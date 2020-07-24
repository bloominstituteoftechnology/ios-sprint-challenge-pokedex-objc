//
//  DBEPokemon.m
//  PokedexSprint
//
//  Created by Dahna on 7/24/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

#import "DBEPokemon.h"

@implementation DBEPokemon

- (instancetype)initWithName:(NSString *)name detailURL:(NSURL * _Nonnull)detailURL
{
    self = [super init];
    if (self) {
        _name = name;
        _detailURL = detailURL;
    }
    return self;
}

- (instancetype)fetchDetails:(NSDictionary *)dictionary
{
    NSString *name = [dictionary[@"name"] capitalizedString];
    NSString *detailURLString = dictionary[@"url"];
    NSURL *detailURL = [NSURL URLWithString:detailURLString];

    if ( !name || !detailURL) { return nil; }

    return [self initWithName:name detailURL:detailURL];
}

@end
