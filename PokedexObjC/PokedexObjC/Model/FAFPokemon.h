//
//  FAFPokemon.h
//  PokedexObjC
//
//  Created by Farhan on 11/30/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FAFPokemon : NSObject
    
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *detailURL;
    
@property (nonatomic) NSInteger pokemonID;
@property (nonatomic) NSInteger weight;
@property (nonatomic) NSInteger baseXP;
    
//@property (nonatomic) UIImage *image;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSArray<NSString *> *abilities;
@property (nonatomic, strong) NSArray<NSString *> *types;

- (instancetype)initWithName:(NSString *)name detailURL:(NSString *)detailURL;
    
- (instancetype)initWithName:(NSString *)name pokemonID:(NSInteger)pokemonID detailURL:(NSString *)detailURL weight:(NSInteger)weight baseXP:(NSInteger)baseXP imageURL:(NSString *)imageURL abilities:(NSArray *)abilities types:(NSArray *)types;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
    
@end

NS_ASSUME_NONNULL_END
