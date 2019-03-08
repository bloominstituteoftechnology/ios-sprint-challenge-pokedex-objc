//
//  OSIPokemon.m
//  Sprint12
//
//  Created by Sergey Osipyan on 3/8/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

#import "OSIPokemon.h"

#define CheckClass(_v, _c) if ([(_v) isKindOfClass:[_c class]] == NO) { return nil; }


@implementation OSIPokemon

- (instancetype)initWithJSON:(id)json {
    CheckClass(json, NSDictionary);
    
    self = [super init];
    if (self) {
        
        NSDictionary *dict = json;
        
        NSString *name = dict[@"name"];
        CheckClass(name, NSString)
        
        NSNumber *identifier = dict[@"id"];
        CheckClass(identifier, NSNumber)
        
        _identifier = identifier;
        _name = name;
   
        NSDictionary *spritesInfo = dict[@"sprites"];
        CheckClass(spritesInfo, NSDictionary);
        NSString *spritesURL = spritesInfo[@"front_default"];
      // if (spritesURL == nil) {
        CheckClass(spritesURL, NSString);
        _imageURL = spritesURL;
      
        NSMutableArray *abilities = [NSMutableArray array];
        NSArray *abilityDefs = dict[@"abilities"];
        for (NSDictionary *def in abilityDefs) {
            OSIAbility *ability = [[OSIAbility alloc] initWithJSON:def];
            if (ability != nil) {
                [abilities addObject:ability];
            }
        }
        _abilities = abilities;
    }
    return self;
}





- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {

    NSString *name = dictionary[@"name"];
    NSString *urlString = dictionary[@"url"];
    NSURL *url = [NSURL URLWithString:urlString];

    return [self initWithName:name url:url];
}


@end

