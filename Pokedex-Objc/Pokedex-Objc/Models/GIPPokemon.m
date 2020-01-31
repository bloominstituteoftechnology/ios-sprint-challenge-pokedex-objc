//
//  GIPPokemon.m
//  Pokedex-Objc
//
//  Created by Gi Pyo Kim on 12/20/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//


#import "GIPPokemon.h"

@interface GIPPokemon()

@property (nonatomic, readwrite) NSMutableArray<NSString *> *internalAbilities;

@end

@implementation GIPPokemon

- (nonnull instancetype)initWithName:(nonnull NSString *)name detailURL:(nonnull NSURL *)detailURL {
    self = [super init];
    if (self) {
        _name = name;
        _detailURL = detailURL;
        _internalAbilities = [[NSMutableArray alloc] init];
    }
    return self;
}

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSString *urlString = dictionary[@"url"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    if (!name || !url) {
        return nil;
    }
    
    return [self initWithName:name detailURL:url];
}

- (void)fillInDetailsFor:(nonnull GIPPokemon *)pokemon dictionary:(nonnull NSDictionary *)dictionary {
    NSDictionary *spriteDict = dictionary[@"sprites"];
    NSString *spriteString = spriteDict[@"front_default"];
    NSURL *spriteURL = [NSURL URLWithString:spriteString];
    NSError *error = nil;
    NSData *spriteData = [NSData dataWithContentsOfURL:spriteURL options:0 error:&error];
    if (error) {
        NSLog(@"GIPPokemon::fillInDetailsFor : Invalid sprite URL: %@", error);
        return;
    }
    UIImage *sprite = [UIImage imageWithData:spriteData];
    pokemon.sprite = sprite;
    
    NSNumber *identifier = dictionary[@"id"];
    pokemon.identifier = identifier;
    
    NSArray *abilitiesArray = dictionary[@"abilities"];
    for (NSDictionary *dict in abilitiesArray) {
        NSDictionary *abilityDict = dict[@"ability"];
        NSString *name = abilityDict[@"name"];
        [self.internalAbilities addObject:name];
    }
    pokemon.abilities = self.internalAbilities;
}

@end
