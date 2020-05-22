//
//  MSKPokemon.m
//  NotDigimonObjectiveC
//
//  Created by Lambda_School_Loaner_268 on 5/22/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

#import "MSKPokemon.h"

@implementation MSKPokemon: NSObject
-(instancetype)initWithName:(NSString *)name
                 identifier:(NSInteger *)identifier
                    sprites:(MSKSprites *)sprites
                  abilities:(NSArray<MSKAbility *> *)abilities {
    self = [super init];
    if (self) {
        _name = name;
        _identifier = identifier;
        _sprites = sprites;
        _abilities = abilities;
    }
    return self;
}
-(instancetype)initWithDict:(NSDictionary *)dict {
    NSString *name = dict[@"name"];
    
}
@end
