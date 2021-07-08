//
//  PokemonViewController.h
//  Pokedex
//
//  Created by Yvette Zhukovsky on 2/1/19.
//  Copyright © 2019 Yvette Zhukovsky. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YZIPokedexController ;
@class YZIPokedex ;

NS_ASSUME_NONNULL_BEGIN

@interface YZIPokemonViewController : UIViewController

-(void) updateViews;
@property (nonatomic, nullable) YZIPokedexController *pokedexController ;
@property (nonatomic, nullable) YZIPokedex *pokemon ;

@end

NS_ASSUME_NONNULL_END
