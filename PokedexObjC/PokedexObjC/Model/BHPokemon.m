//
//  BHPokemon.m
//  PokedexObjC
//
//  Created by Benjamin Hakes on 3/8/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

#import "BHPokemon.h"
#import "BHAbility.h"

@implementation BHPokemon

#define CheckClass(_v, _c) if ([(_v) isKindOfClass:[_c class]] == NO) { return nil;}
#define CheckClassNoReturn(_v, _c) if ([(_v) isKindOfClass:[_c class]] == NO) { return;}

@synthesize identifier = _identifier;

-(instancetype)initWithJSON:(id)json {
    
    if ([json isKindOfClass:[NSDictionary class]] == NO){
        return nil;
    }
    
    
    
    self = [super init];
    if (self) {
        
        
        NSDictionary *pokemonDict = json;
        
        // name
        NSString *name = pokemonDict[@"name"];
        CheckClass(name, NSString)
        
        // moreInfo
        NSString *urlString = pokemonDict[@"url"];
        CheckClass(urlString, NSString)
        
        _name = name;
        _moreInfoURLString = urlString;
        
        
    }
    return self;
    
}

-(BHPokemon*)updateWithJSON:(id)json{
    
    if ([json isKindOfClass:[NSDictionary class]] == NO){
        return nil;
    }
    
    
    NSDictionary *pokemonDict = json;
    
    // identifier
    NSString *identifer = [NSString stringWithFormat:@"%@", pokemonDict[@"id"]];
    
    // species
    NSDictionary *speciesInfo = pokemonDict[@"species"];
    CheckClass(speciesInfo, NSDictionary)
    NSString *speciesName = speciesInfo[@"name"];
    CheckClass(speciesName, NSString)
    
    // moves
    NSArray *moves = pokemonDict[@"moves"];
    NSArray *moveNames = [moves valueForKeyPath:@"move.name"];
    
    // abilities
    NSMutableArray *abilities = [NSMutableArray array];
    NSArray *abilityDefs = pokemonDict[@"abilities"];
    for (NSDictionary *def in abilityDefs) {
        BHAbility *ability = [[BHAbility alloc] initWithJSON:def];
        if (ability != nil) {
            [abilities addObject:ability];
        }
    }
    
    // sprites
    NSMutableArray *images = [NSMutableArray array];
    
    NSDictionary *sprites = pokemonDict[@"sprites"];
    CheckClass(speciesInfo, NSDictionary)
    
    NSString *backDefault = sprites[@"back_default"];
    CheckClass(backDefault, NSString)
    [images addObject:[NSURL URLWithString:backDefault]];
    
    NSString *frontDefault = sprites[@"front_default"];
    CheckClass(frontDefault, NSString)
    [images addObject:[NSURL URLWithString:frontDefault]];
    
    [self setValue:identifer forKey:@"identifier"];
    [self setValue:speciesName forKey:@"speciesName"];
    [self setValue:moveNames forKey:@"moves"];
    [self setValue:images forKey:@"images"];
    [self setValue:abilities forKey:@"abilities"];
    
    return self;
}

@end
