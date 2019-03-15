//
//  JMKPokemon.m
//  PokeDexObjC
//
//  Created by TuneUp Shop  on 3/15/19.
//  Copyright © 2019 jkaunert. All rights reserved.
//

#import "JMKPokemon.h"

@implementation JMKPokemon

- (instancetype)initWithName:(NSString *)name URL:(NSURL *)url
{
    self = [super init];
    if (self) {
        _name = name;
        _url = url;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary<NSString *,NSString *> *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSString *urlstring = dictionary[@"url"];
    NSURL *url = [NSURL URLWithString:urlstring];
    
    return [self initWithName:name URL:url];
}

- (void)fillInDetailsWithDictionary:(NSDictionary *)dictionary
{
    NSString *identifier = dictionary[@"id"];
    _identifier = identifier;
    
    NSString *urlstring = dictionary[@"sprites"][@"front_shiny"];
    NSURL *url = [NSURL URLWithString:urlstring];
    _spriteURL = url;
    
    NSMutableArray *abilities = [NSMutableArray array];
    NSArray *abilitiesArray = dictionary[@"abilities"];
    for (NSDictionary *abilityDict in abilitiesArray) {
        NSString *ability = abilityDict[@"ability"][@"name"];
        [abilities addObject:ability];
    }
    
    [self willChangeValueForKey:@"abilities"];
    _abilities = abilities;
    [self didChangeValueForKey:@"abilities"];
}

- (NSString *)abilitiesString
{
    NSString *tempString = [NSString string];
    for (NSString *abilityName in self.abilities) {
        tempString = [tempString stringByAppendingFormat:@"%@\n", abilityName];
    }
    return tempString;
}

@end
