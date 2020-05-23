//
//  MSKPokemon.m
//  NotDigimonObjectiveC
//
//  Created by Lambda_School_Loaner_268 on 5/22/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

#import "MSKPokemon.h"

@implementation MSKPokemon: NSObject
-(instancetype)initWithName:(NSString *)name
                 identifier:(NSString *)identifier
                     sprite:(NSString *)sprite
                  abilities:(NSArray<NSString *> *)abilities
                        url:(NSString *)url {
    self = [super init];
    if (self) {
        _name = name;
        _identifier = identifier;
        _sprite = sprite;
        _abilities = abilities;
        _url = url;
    }
    return self;
}

-(instancetype)initWithName:(NSString *)name url:(NSString *)url {
    self = [super init];
    if (self) {
        _name = name;
        _url = url;
    }
    return self;
}

-(instancetype)initWithAllDict:(NSDictionary *)dict {
    NSString *name = dict[@"name"];
    NSString *url = dict[@"url"];
    self = [self initWithName:name
                   identifier:@""
                       sprite:@""
                    abilities:[[NSArray alloc] init]
                          url:url];
    return self;
}
-(instancetype)initWithSpecificDict:(NSDictionary *)dict {
    NSString *name = dict[@"name"];
    NSString *identifier = [dict[@"id"] stringValue];
    NSString *frontShiny = dict[@"sprites"][@"front_shiny"];
    NSArray *abilitiesParentArray = dict[@"abilities"];
    NSMutableArray *abilitiesArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary  in abilitiesParentArray) {
        NSString *abilityName = dictionary[@"ability"][@"name"];
        [abilitiesArray addObject:abilityName];
    }
    NSString *url = nil;
    
    self = [self initWithName:name
                   identifier:identifier
                       sprite:frontShiny
                    abilities:abilitiesArray
                          url:url];
    return self;
}
    
@end
