//
//  SAEPokemon.m
//  Pokedex-Sprint
//
//  Created by Sammy Alvarado on 12/14/20.
//

#import "SAEPokemon.h"

@implementation SAEPokemon

- (instancetype)initWithName:(NSString *)aName {
    if (self = [super init]) {
        _name = aName.copy;
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = [dictionary objectForKey:@"name"];
    if (![name isKindOfClass:NSString.class]) return nil;
    return [self initWithName:name];
}

@end
