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
    NSString *identifier = [dictionary valueForKeyPath:@"id"];
    NSString *imageURL = [dictionary valueForKeyPath:@"sprites.front_default"];
    
    NSMutableArray<NSString *> *abilities = [[NSMutableArray alloc] init];
    NSDictionary *abilitiesDict = [dictionary valueForKeyPath:@"abilities"];
    for (NSDictionary *ability in abilitiesDict) {
        [abilities addObject:[ability valueForKeyPath:@"ability.name"]];
    }
    _imageURL = imageURL;
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

- (instancetype)initWithName:(NSString *)name url:(NSString *)url identifier:(NSString *)identifier abilities:(NSArray<NSString *> *)abilities {
    if (self = [super init]) {
        _name = name;
        _identifier = identifier;
        _abilities = abilities;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = [dictionary valueForKeyPath:@"name"];
    NSString *url = [dictionary valueForKeyPath:@"url"];
    
    return [self initWithName:name url:url];
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:_identifier forKey:@"identifier"];
    [encoder encodeObject:_abilities forKey:@"abilities"];
    [encoder encodeObject:_url forKey:@"url"];
    [encoder encodeObject:_imageURL forKey:@"imageURL"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _name = [decoder decodeObjectForKey:@"name"];
        _identifier = [decoder decodeObjectForKey:@"identifier"];
        _abilities = [decoder decodeObjectForKey:@"abilities"];
        _url = [decoder decodeObjectForKey:@"url"];
        _imageURL = [decoder decodeObjectForKey:@"imageURL"];
    }
    return self;
}

@end
