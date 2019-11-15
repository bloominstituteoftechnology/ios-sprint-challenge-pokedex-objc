//
//  JACPokemon.m
//  Pokedex-Objc
//
//  Created by Jordan Christensen on 11/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

#import "JACPokemon.h"

@implementation JACPokemon

- (void)fillInDetailsWithDictionary:(NSDictionary *)dictionary {
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    
    NSString *identifierString = [dictionary valueForKeyPath:@"id"];
    NSNumber *identifier = [f numberFromString:identifierString];
    
    NSMutableArray<NSString *> *abilities = [[NSMutableArray alloc] init];
    NSDictionary *abilitiesDict = [dictionary valueForKeyPath:@"abilities"];
    for (NSDictionary *ability in abilitiesDict) {
        [abilities addObject:[ability valueForKeyPath:@"ability.name"]];
    }
    
    _identifier = identifier;
    _abilities = abilities;
}

- (instancetype)initWithName:(NSString *)name url:(NSString *)url {
    if (self = [super init]) {
        _name = name;
        _url = url;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name url:(NSString *)url identifier:(NSNumber *)identifier image:(NSData *)image abilities:(NSArray<NSString *> *)abilities {
    if (self = [super init]) {
        _name = name;
        _identifier = identifier;
        _image = image;
        _abilities = abilities;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = [dictionary valueForKeyPath:@"name"];
    NSString *url = [dictionary valueForKeyPath:@"url"];
    
    return [self initWithName:name url:url];
}

@end
