//
//  Pokemon.m
//  Pokedex
//
//  Created by Elizabeth Thomas on 10/13/20.
//

#import "Pokemon.h"

@implementation Pokemon

- (instancetype)initWithName:(NSString *)name url:(NSString *)urlString
{
    if (self = [super init]) {
        _name = name;
        _urlString = urlString;
        _abilities = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)initFromDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    if (![name isKindOfClass:NSString.class]) return nil;

    NSString *urlString = dictionary[@"url"];
    if (![urlString isKindOfClass:NSString.class]) return nil;

    return [self initWithName:name url:urlString];
}

- (BOOL)getDetails:(NSData *)data
{
    NSError *jsonError;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

    if (!dictionary) {
        NSLog(@"Error decoding JSON: %@", jsonError);
    }

    NSNumber *identifier = dictionary[@"id"];
    if (![identifier isKindOfClass:NSNumber.class]) return nil;

    NSString *spriteURLString = dictionary[@"sprites"][@"front_default"];
    if (![spriteURLString isKindOfClass:NSString.class]) return nil;

    NSArray *abilities = dictionary[@"abilities"];
    if (![abilities isKindOfClass:NSArray.class]) return nil;

    NSMutableArray *abilityStrings = [[NSMutableArray alloc] init];
    for (NSDictionary *ability in abilities) {
        NSString *abilityName = ability[@"ability"][@"name"];
        if (![abilityName isKindOfClass:NSString.class]) continue;
        [abilityStrings addObject:abilityName];
    }

    self.spriteURLString = spriteURLString;
    self.abilities = abilityStrings;
    self.identifier = identifier;

    return true;
}

@end
