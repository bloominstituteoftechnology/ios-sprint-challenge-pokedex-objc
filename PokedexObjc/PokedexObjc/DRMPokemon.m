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

@end
