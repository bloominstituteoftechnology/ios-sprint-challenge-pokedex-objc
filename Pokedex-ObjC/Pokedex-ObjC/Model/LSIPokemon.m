//
//  LSIPokemon.m
//  Pokedex-ObjC
//
//  Created by Iyin Raphael on 3/15/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

#import "LSIPokemon.h"

@implementation LSIPokemon

- (instancetype)initWithPokemonName:(NSString *)name url:(NSString *)url
{
    self = [super init];
    if (self){
        self.name = name;
        self.url = url;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSString *url = dictionary[@"url"];
    return [self initWithPokemonName:name url:url];
}

- (void)abilitiesArray:(NSArray *)array
{
    NSMutableArray<NSString *> *abilities = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in array){
        NSDictionary *ability = dict[@"ability"];
        [abilities addObject:ability[@"name"]];
    }
    [self setAbilities:[abilities componentsJoinedByString:@", "]];
}

@end
