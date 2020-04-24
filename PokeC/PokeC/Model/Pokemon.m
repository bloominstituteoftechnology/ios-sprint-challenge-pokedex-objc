//
//  Pokemon.m
//  PokeC
//
//  Created by Lotanna Igwe-Odunze on 3/15/19.
//  Copyright © 2019 Sugabelly LLC. All rights reserved.
//

#import "Pokemon.h"

@implementation Pokemon

//Initialisation
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

//Fill in Pokemon information
- (void)fillInWithDictionary:(NSDictionary *)dictionary {
    // Makes sure there isn't already an identifier
    if (self.identifier != nil) { return; }
    
    // Adds the identifier if there's none
    NSString *identifier = dictionary[@"id"];
    _identifier = identifier;
    
    // Adds the sprite image url
    NSString *spriteURLString = dictionary[@"sprites"][@"front_default"];
    NSURL *spriteURL = [NSURL URLWithString: spriteURLString];
    _spriteURL = spriteURL;
    
    
    // Grabs the list of abilities
    NSArray *abilityList = dictionary[@"abilities"];
    NSMutableArray *abilities = [NSMutableArray array];
    
    for (NSDictionary *abilityDictionary in abilityList) {
        NSString *ability = abilityDictionary[@"ability"][@"name"];
        [abilities addObject: ability];
    }
    
    // KVC
    [self willChangeValueForKey:@"abilities"];
    _abilities = abilities;
    [self didChangeValueForKey:@"abilities"];
    
    _abilityString = [self abilitiesAsString] ;
}

//Convert list of abilities into a convenient string
- (NSString *)abilitiesAsString {
    NSString *string = [NSString string];
    for (NSString *ability in self.abilities) {
        string = [string stringByAppendingFormat:@"- %@\n", [ability capitalizedString]];
    }
    return string;
}


@end
