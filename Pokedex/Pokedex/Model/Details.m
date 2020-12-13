//
//  Details.m
//  Pokedex
//
//  Created by Cora Jacobson on 12/12/20.
//

#import "Details.h"

@implementation Details

- (instancetype)initWithIdentifier:(NSNumber *)anID
                         abilities:(NSString *)someAbilities
                         spriteURL:(NSString *)aURL
{
    if (self = [super init]) {
        _identifier = anID;
        _abilities = someAbilities.copy;
        _spriteURL = aURL.copy;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)aDictionary {
    
    NSNumber *identifier = [aDictionary objectForKey:@"id"];
    
    NSMutableArray *abilitiesArray = [aDictionary objectForKey:@"abilities"];
    NSMutableArray<NSString *> *abilityArray = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *abilityDictionary in abilitiesArray) {
        NSMutableDictionary *abilityDict = [abilityDictionary objectForKey:@"ability"];
        NSString *ability = [abilityDict objectForKey:@"name"];
        [abilityArray addObject:ability];
    }
    NSString *abilityString = [abilityArray componentsJoinedByString:@", "];
    
    NSMutableDictionary *spriteDictionary = [aDictionary objectForKey:@"sprites"];
    NSString *spriteString = [spriteDictionary objectForKey:@"front_default"];
    
    return [self initWithIdentifier:identifier
                          abilities:abilityString
                          spriteURL:spriteString];
}

@end
