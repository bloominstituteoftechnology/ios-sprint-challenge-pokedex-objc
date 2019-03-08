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
        
        NSDictionary *speciesInfo = dict[@"species"];
        CheckClass(speciesInfo, NSDictionary);
        NSString *speciesName = speciesInfo[@"name"];
        CheckClass(speciesName, NSString);
        
        _name = name;
        _speciesName = speciesName;
        
        NSArray *moveInfo = dict[@"moves"];
        NSArray *names = [moveInfo valueForKeyPath:@"move.name"];
        _moves = names;
        
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

@end

@end
