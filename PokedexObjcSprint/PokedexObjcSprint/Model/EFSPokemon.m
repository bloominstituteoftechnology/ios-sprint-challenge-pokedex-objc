//
//  EFSPokemon.m
//  PokedexObjcSprint
//
//  Created by Clayton Watkins on 10/9/20.
//

#import "EFSPokemon.h"

@implementation EFSPokemon

// Basic initalizer
- (instancetype)initWithName:(NSString *)aName
{
    if (self = [super init]) {
        _name = aName.copy;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    // getting name from json and then initalizing a pokemon with the name
    NSString *name = [[dictionary objectForKey:@"name"] capitalizedString];
    if (![name isKindOfClass:NSString.class]) return nil;
    return [self initWithName:name];
}

@end
