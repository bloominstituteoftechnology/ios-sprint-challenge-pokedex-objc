//
//  Pokemon.m
//  PokeDex-OBJC
//
//  Created by Joe on 8/16/20.
//  Copyright © 2020 AlphaGradeINC. All rights reserved.
//

#import "Pokemon.h"

@implementation Pokemon

- (instancetype)initWithName:(NSString *)name
                  identifier:(NSNumber *)identifier
                   abilities:(NSArray *)abilities
                       image:(NSURL *)image
                         url:(NSURL *)url; {
    if (self = [super init]) {
        _name = name;
        _identifier = identifier;
        _abilities = abilities;
        _image = image;
        _url = url;
    }
    return self;
}


- (instancetype)initWithDictioanryForList:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSNumber *identifier = dictionary[@"identifier"];
    NSArray *abilities = dictionary[@"abilities"];
    NSURL *image = dictionary[@"image"];
    NSURL *url = dictionary[@"url"];
    
    return [self initWithName:name identifier:identifier abilities:abilities image:image url:url];
}

@end
