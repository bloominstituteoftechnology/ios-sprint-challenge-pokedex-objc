//
//  PokemonDetailViewController.h
//  PokedexObjC
//
//  Created by Carolyn Lea on 10/12/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PokemonDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UILabel *abilitiesLabel;


@end

NS_ASSUME_NONNULL_END
