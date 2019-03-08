//
//  DRMPokemon.m
//  PokedexObjc
//
//  Created by Dillon McElhinney on 3/8/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

#import "DRMPokemon.h"

@implementation DRMPokemon

- (instancetype)initWithName: (NSString *)name andURL: (NSURL *)url {
    self = [super init];
    if (self != nil && name != nil && url != nil) {
        _name = name;
        _url = url;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary<NSString *,NSString *> *)dictionary {
    NSString *name = dictionary[@"name"];
    NSString *urlString = dictionary[@"url"];
    NSURL *url = [NSURL URLWithString: urlString];
    
    return [self initWithName: name andURL: url];
}

- (void)fillInWithDictionary:(NSDictionary *)dictionary {
    if (self.identifier != nil) { return; }
    
    NSString *identifier = dictionary[@"id"];
    _identifier = identifier;
    
    NSString *spriteURLString = dictionary[@"sprites"][@"front_default"];
    NSURL *spriteURL = [NSURL URLWithString: spriteURLString];
    _spriteURL = spriteURL;
    
    NSArray *abilityArray = dictionary[@"abilities"];
    NSMutableArray *abilities = [NSMutableArray array];
    
    for (NSDictionary *abilityDictionary in abilityArray) {
        NSString *ability = abilityDictionary[@"ability"][@"name"];
        [abilities addObject: ability];
    }
    [self willChangeValueForKey:@"abilities"];
    _abilities = abilities;
    [self didChangeValueForKey:@"abilities"];
}

- (NSString *)abilityString {
    NSString *string = [NSString string];
    for (NSString *ability in self.abilities) {
        string = [string stringByAppendingFormat:@"- %@\n", [ability capitalizedString]];
    }
    return string;
}

@end
