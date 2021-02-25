//
//  Pokemon.m
//  ObjCPokedex
//
//  Created by Craig Belinfante on 2/23/21.
//

#import "Pokemon.h"

@implementation Pokemon

-(void)updateWithID:(NSNumber *)anIdentifier name:(NSString *)aName abilities:(NSString *)anAbility sprites:(NSString *)aSpriteURL

{
    self.identifier = anIdentifier;
    self.name = aName.copy;
    self.abilities = anAbility.copy;
    self.sprites = aSpriteURL.copy;
}

- (instancetype)initWithIdentifier:(NSNumber *)anIdentifier
                              name:(NSString *)aName
                         abilities:(NSString *)anAbility
                           sprites:(NSString *)aSpriteURL
{
    if (self = [super init]) {
        _name = aName.copy;
        _identifier = anIdentifier;
        _abilities = anAbility.copy;
        _sprites = aSpriteURL.copy;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)aDictionary {
    
    NSNumber *identifier = [aDictionary objectForKey:@"id"];
    NSString *name = [aDictionary objectForKey:@"name"];
    NSMutableArray *abilitiesArray = [aDictionary objectForKey:@"abilities"];
    NSMutableArray<NSString *> *abilityArray = [[NSMutableArray alloc] init];
    
    for (NSMutableDictionary *abilityDictionary in abilitiesArray) {
        NSMutableDictionary *abilityString = [abilityDictionary objectForKey:@"ability"];
        NSString *ability = [abilityString objectForKey:@"name"]; [abilityArray addObject:ability];
       }
       NSString *ability = [abilityArray componentsJoinedByString:@", "];
       
       NSMutableDictionary *spriteDictionary = [aDictionary objectForKey:@"sprites"];
       NSString *spriteURL = [spriteDictionary objectForKey:@"front_default"];
       
       return [self initWithIdentifier:identifier name:name abilities:ability sprites:spriteURL];
}

@end
