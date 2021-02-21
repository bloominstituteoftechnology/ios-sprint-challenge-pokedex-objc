//
//  Pokemon.m
//  PokedexObjc
//
//  Created by Kenneth Jones on 2/19/21.
//

#import "Pokemon.h"

@implementation Pokemon

- (instancetype) init
{
    return [self initWithIdentifier:0
                               name:@""
                             sprite:@""
                          abilities:@""];
}

- (instancetype)initWithIdentifier:(int)anIdentifier
                              name:(NSString *)aName
                            sprite:(NSString *)aSprite
                         abilities:(NSString *)someAbilities
{
    if (self = [super init]) {
        _identifier = anIdentifier;
        _name = aName.copy;
        _sprite = aSprite.copy;
        _abilities = someAbilities.copy;
    }
    return self;
}

// Decoding
- (instancetype)initWithDictionary:(NSDictionary *)aDictionary
{
    // Identifier
    NSNumber *identifier = [aDictionary objectForKey:@"id"];
    if (![identifier isKindOfClass:NSNumber.class]) return nil;
    
    // Name
    NSString *name = [aDictionary objectForKey:@"name"];
    if (![name isKindOfClass:NSString.class]) return nil;
    
    // Sprite URL String
    NSDictionary *sprites = [aDictionary objectForKey:@"sprites"];
    if (![sprites isKindOfClass:NSDictionary.class]) return nil;
    
    NSString *sprite = [sprites objectForKey:@"front_default"];
    if (![sprite isKindOfClass:NSString.class]) return nil;
    
    // Abilities
    NSArray *abilitiesInfo = [aDictionary objectForKey:@"abilities"];
    if (![abilitiesInfo isKindOfClass:NSArray.class]) return nil;
    
    NSMutableString *abilities = [NSMutableString new];
    for (NSDictionary *abilitiesDictionary in abilitiesInfo) {
        NSDictionary *abilityDictionary = [abilitiesDictionary objectForKey:@"ability"];
        if (![abilitiesDictionary isKindOfClass:NSDictionary.class]) return nil;
        
        NSString *ability = [abilityDictionary objectForKey:@"name"];
        NSString *abilityString = [NSString stringWithFormat:@"%@. ", ability];
        [abilities appendString:abilityString];
    }
    
    return [self initWithIdentifier:identifier.intValue
                               name:name
                             sprite:sprite
                          abilities:abilities];
}

@end
