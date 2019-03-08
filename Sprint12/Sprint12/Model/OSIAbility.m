//
//  OSIAbility.m
//  Sprint12
//
//  Created by Sergey Osipyan on 3/8/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

#import "OSIAbility.h"

@implementation OSIAbility

- (instancetype)initWithJSON:(id)json {
    if ([json isKindOfClass:[NSDictionary class]] == NO) { return nil; }
    
    self = [super init];
    if (self) {
        _hidden = [[json objectForKey:@"is_hidden"] boolValue];
        _name = [json valueForKeyPath:@"ability.name"];
    }
    return self;
}

@end
