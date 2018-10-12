//
//  Pokemon.m
//  PokedexObjC
//
//  Created by Carolyn Lea on 10/12/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

#import "Pokemon.h"

@interface Pokemon ()

@property (nonatomic, readwrite, copy) NSString *name;
@property (nonatomic, readwrite) NSInteger identifier;
@property (nonatomic, readwrite, copy, nullable) NSArray<NSString *> *abilities;
@property (nonatomic, readwrite, nullable) NSURL *spriteURL;

@end

@implementation Pokemon

-(instancetype)initWithName:(NSString *)name
{
    if (self = [super init])
    {
        _name = name;
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    return [self initWithName:name];
}

- (void)fillWithDictionary:(NSDictionary *)fillDictionary
{
    self.identifier = [fillDictionary[@"id"] integerValue];
    
    NSDictionary *abilityDicts = fillDictionary[@"abilities"];
    NSMutableArray *abilityStrings = [[NSMutableArray alloc] init];
    
    for (NSDictionary *abilityDict in abilityDicts)
    {
        NSDictionary *abilityInfo = abilityDict[@"ability"];
        NSString *abilityString = abilityInfo[@"name"];
        [abilityStrings addObject:abilityString];
    }
    
    self.abilities = abilityStrings;
    
    NSDictionary *spritesDicts = fillDictionary[@"sprites"];
    NSString *spriteURLString = spritesDicts[@"front_default"];
    
    self.spriteURL = [[NSURL alloc] initWithString:spriteURLString];
}

@end


//"front_default": "http://pokeapi.co/media/sprites/pokemon/12.png"
