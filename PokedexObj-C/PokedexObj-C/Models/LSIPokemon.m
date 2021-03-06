//
//  LSIPokemon.m
//  PokedexObj-C
//
//  Created by James McDougall on 3/5/21.
//

#import "LSIPokemon.h"

//MARK: - Interface -
@interface LSIPokemon ()

@end

//MARK: - Implementation -
@implementation LSIPokemon

- (instancetype)initWithName:(NSString *)name dataURL:(nonnull NSURL *)dataURL{
    if (self = [super init]) {
        _name = name;
        _dataURL = dataURL;
        _abilities = [[NSMutableArray alloc] initWithArray:@[]];
    }
    return self;
}

/// KVO Compliance methods for Array
- (NSUInteger)countOfAbilities {
    return _abilities.count;
}

- (id)objectInAbilitiesAtIndex:(NSUInteger)index {
    return _abilities[index];
}

- (void)insertObject:(NSString *)object inAbilitiesAtIndex:(int)index {
    [_abilities insertObject:object atIndex:index];
}

- (void)removeObjectFromAbilitiesAtIndex:(int)index {
    [_abilities removeObjectAtIndex:index];
}

@end
