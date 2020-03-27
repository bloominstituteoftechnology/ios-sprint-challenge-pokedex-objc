//
//  LSIPokemon.h
//  Pokedex
//
//  Created by Alexander Supe on 27.03.20.
//  Copyright © 2020 Alexander Supe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIPokemon : NSObject

@property (nonatomic)NSString *name;
@property (nonatomic, nullable)NSString *identifier;
@property (nonatomic, nullable)NSString *sprite;
@property (nonatomic, nullable)NSArray<NSString *> *abilities;
@property (nonatomic)NSString *urlString;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
