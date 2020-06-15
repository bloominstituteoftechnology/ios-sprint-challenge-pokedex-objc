//
//  DTWPokemonDetail.m
//  Pokedex-Objc
//
//  Created by David Wright on 6/14/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import "DTWPokemonDetail.h"
#import "NSURL+Secure.h"

@implementation DTWPokemonDetail

- (instancetype)initWithName:(nonnull NSString *)name
                  identifier:(nonnull NSNumber *)identifier
                   spriteURL:(nullable NSURL *)spriteURL
                   abilities:(nonnull NSString *)abilities
{
    if (self = [super init]) {
        _name = name.copy;
        _identifier = identifier;
        _spriteURL = spriteURL;
        _abilities = abilities.copy;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    // name
    NSString *name = [[dictionary objectForKey:@"name"] capitalizedString];
    if (![name isKindOfClass:[NSString class]]) return nil;
    
    // identifier
    NSNumber *identifier = [dictionary objectForKey:@"id"];
    if (![identifier isKindOfClass:[NSNumber class]]) return nil;
    
    // spriteURL
    NSDictionary *spriteURLDictionary = [dictionary objectForKey:@"sprites"];
    if (![spriteURLDictionary isKindOfClass:[NSDictionary class]]) return nil;
    
    NSString *spriteURLString = [spriteURLDictionary objectForKey:@"front_default"];
    if (![spriteURLString isKindOfClass:[NSString class]]) return nil;
    
    NSURL *spriteURL = [NSURL URLWithString:spriteURLString].URLUsingHTTPS;
    
    // abilities
    NSArray *abilitiesDictionaries = [dictionary objectForKey:@"abilities"];
    if (![abilitiesDictionaries isKindOfClass:[NSArray class]]) return nil;
    
    NSMutableArray *abilitiesArray = [[NSMutableArray alloc] initWithCapacity:abilitiesDictionaries.count];
    
    for (NSDictionary *abilitiesDictionary in abilitiesDictionaries) {
        if (![abilitiesDictionary isKindOfClass:[NSDictionary class]]) continue;
        
        NSDictionary *abilityDictionary = [abilitiesDictionary objectForKey:@"ability"];
        if (![abilityDictionary isKindOfClass:[NSDictionary class]]) continue;
        
        NSString *ability = [abilityDictionary objectForKey:@"name"];
        if (![ability isKindOfClass:[NSString class]]) continue;
        
        if (ability) {
            [abilitiesArray addObject:ability.capitalizedString];
        } else {
            // TODO: One of our "required" fields might be optional and we may need to debug this with real data
            NSLog(@"Unable to parse abilities dictionary: %@", abilitiesDictionary);
        }
    }
    
    NSString *abilities = [abilitiesArray componentsJoinedByString:@", "];
    
    return [self initWithName:name identifier:identifier spriteURL:spriteURL abilities:abilities];
}

@end
