//
//  LTBPokemon.m
//  Pokedex
//
//  Created by Linh Bouniol on 10/12/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

#import "LTBPokemon.h"

@interface LTBPokemon ()

@property (nonatomic, readwrite, copy) NSString *name;
@property (nonatomic, readwrite, copy, nullable) NSString *identifier;
@property (nonatomic, readwrite, copy, nullable) NSArray<NSString *> *abilities;
@property (nonatomic, readwrite, nullable) NSURL *spriteURL;

@end

@implementation LTBPokemon

- (instancetype)initWithName:(NSString *)name
{
    if (self = [super init]) {
        _name = name;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    
    return [self initWithName:name];
}

- (void)updateWithDictionary:(NSDictionary *)dict
{
    self.identifier = dict[@"id"];
    
    NSDictionary *abilityDicts = dict[@"abilities"];
    NSMutableArray *abilityStrings = [[NSMutableArray alloc] init];
    
    for (NSDictionary *abilityDict in abilityDicts) {
        NSDictionary *abilityInfo = abilityDict[@"ability"];
        NSString *abilityString = abilityInfo[@"name"];
        [abilityStrings addObject:abilityString];
    }
    
    self.abilities = abilityStrings;
    
    NSDictionary *spritesDicts = dict[@"sprites"];
    NSString *spriteURLString = spritesDicts[@"front_default"];
    
    self.spriteURL = [[NSURL alloc] initWithString:spriteURLString];
}

@end
