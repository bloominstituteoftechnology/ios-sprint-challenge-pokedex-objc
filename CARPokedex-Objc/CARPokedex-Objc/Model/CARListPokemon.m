//
//  CARListPokemon.m
//  CARPokedex-Objc
//
//  Created by Chad Rutherford on 2/28/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import "CARListPokemon.h"

@implementation CARListPokemon

- (instancetype)initWithName:(NSString *)name url:(NSString *)url {
    self = [super init];
    if (self) {
        _name = [name copy];
        _url = [url copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = [dictionary[@"name"] capitalizedString];
    NSString *url = dictionary[@"url"];
    
    if ([name isKindOfClass:[NSNull class]] || [url isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    self = [self initWithName:name url:url];
    return self;
}

@end
