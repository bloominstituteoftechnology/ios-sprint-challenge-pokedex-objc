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
@property (nonatomic, readwrite, copy, nullable) NSString *identifier;
@property (nonatomic, readwrite, copy, nullable) NSArray<NSString *> *abilities;
@property (nonatomic, readwrite, nullable) NSURL *spriteURL;

@end

@implementation Pokemon

//-(instancetype)initWithName:(NSString *)name identifier:(NSInteger)identifier abilities:(NSArray *)abilities sprite:(NSString *)sprite
//{
//    self = [super init];
//    if(self)
//    {
//        _name = [name copy];
//        _identifier = identifier;
//        _abilities = [abilities copy];
//        _sprite = [sprite copy];
//    }
//    return self;
//}

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
//-(instancetype)initWithDictionary:(NSDictionary *)dictionary
//{
//    NSString *name = dictionary[@"name"];
//    NSString *identifierString = dictionary[@"id"];
//    NSInteger idenitifier = identifierString.integerValue;
//    NSArray *abilities = dictionary[@"abilities"];
//    NSString *sprite = dictionary[@"front_default"];
//
//    if(!name || !identifierString || !abilities || !sprite)
//    {
//        return  nil;
//    }
//
//    return [self initWithName:name identifier:idenitifier abilities:abilities sprite:sprite];
//}

- (void)fillWithDictionary:(NSDictionary *)fillDictionary
{
    self.identifier = fillDictionary[@"id"];
    
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
