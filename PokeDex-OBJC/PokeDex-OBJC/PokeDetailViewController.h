//
//  PokeDetailViewController.h
//  PokeDex-OBJC
//
//  Created by Joe on 8/16/20.
//  Copyright © 2020 AlphaGradeINC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PokeDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImage;
@property (weak, nonatomic) IBOutlet UILabel *pokemonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonAbilitiesLabel;


@end

NS_ASSUME_NONNULL_END
