//
//  KRCPokemon.m
//  Pokemon
//
//  Created by Christopher Aronson on 7/26/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

#import "KRCPokemon.h"

@interface KRCPokemon ()

@property (nonatomic) NSMutableArray *internalAbilities;

@end

@implementation KRCPokemon

- (instancetype _Nonnull)initWithName:(NSString * _Nonnull)name url:(NSString * _Nonnull)infoURL {
    
    self = [super init];
    
    if (self) {
        
        _name = name;
        _infoURL = infoURL;
        _internalAbilities = [[NSMutableArray alloc] init];
        
    }
    
    return self;
}

- (void)setAbilities:(NSArray<NSString *> *)abilities {
    [[self internalAbilities] setArray:abilities];
}

- (NSArray<NSString *> *)abilities {
    return [[self internalAbilities] copy];
}

@end
