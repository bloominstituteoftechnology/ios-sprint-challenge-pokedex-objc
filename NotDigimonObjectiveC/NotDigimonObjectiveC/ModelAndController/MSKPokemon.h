//
//  MSKPokemon.h
//  NotDigimonObjectiveC
//
//  Created by Lambda_School_Loaner_268 on 5/22/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSKPokemon: NSObject
@property (nonatomic, copy)  NSString *name;
@property (nonatomic, copy, nullable) NSString *identifier;
@property (nonatomic, copy, nullable) NSString *sprite;
@property (nonatomic, copy, nullable) NSArray<NSString *> *abilities;
@property (nonatomic, copy, nullable) NSString *url;

-(instancetype)initWithName:(NSString *)name url:(NSString *)url;

-(instancetype)initWithName:(NSString *)name
                 identifier:(NSString *)identifier
                     sprite:(NSString *)sprite
                  abilities:(NSArray<NSString *> *)abilities
                        url:(NSString *)url;
-(instancetype)initWithSpecificDict:(NSDictionary *)dict;
-(instancetype)initWithAllDict:(NSDictionary *)dict;
@end
NS_ASSUME_NONNULL_END
