//
//  OSIPokemonName.m
//  Sprint12
//
//  Created by Sergey Osipyan on 3/8/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

#import "OSIPokemonName.h"
#define CheckClass(_v, _c) if ([(_v) isKindOfClass:[_c class]] == NO) { return nil; }
@implementation OSIPokemonName

- (instancetype)initWithJSON:(id)json {
    CheckClass(json, NSDictionary);
    
    self = [super init];
    if (self) {
        
        NSDictionary *dict = json;
        
        NSArray *results = dict[@"results"];
        NSArray *names = [results valueForKey:@"name"];
        _names = names;
        NSArray *url = [results valueForKey:@"url"];
        _url = url;
        
        
        
    }
    return self;
}
@end
