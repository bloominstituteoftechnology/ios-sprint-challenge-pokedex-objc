//
//  JGPAbility.m
//  PokedexObjC
//
//  Created by John Pitts on 7/26/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

#import "JGPAbility.h"

@implementation JGPAbility

- (instancetype)initWithDictionary:(id)dictionary {
    self = [super init];
    if (self) {
        _name = [dictionary valueForKeyPath:@"ability.name"];
    }
    return self;
}

@end
