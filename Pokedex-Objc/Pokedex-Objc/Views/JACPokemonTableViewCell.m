//
//  JACPokemonTableViewCell.m
//  Pokedex-Objc
//
//  Created by Jordan Christensen on 3/28/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

#import "JACPokemonTableViewCell.h"
#import "Pokedex_Objc-Swift.h"
#import "JACPokemon.h"

@interface JACPokemonTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UILabel *pokemonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonIdLabel;

@property JACPokemon *pokemon;

@end

@implementation JACPokemonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setUpCellWithPokemon:(JACPokemon *)pokemon {
    _pokemon = pokemon;
    [self updateViews];
}

- (void)updateViews {
    UIColor *bot = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    [_controller fetchPokemonImageFor:_pokemon completion:^(UIImage * _Nullable image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.pokemonImageView setImage:image];
        });
    }];
    [_pokemonNameLabel setText:_pokemon.name];
    [_pokemonIdLabel setText:[NSString stringWithFormat:@"%@",_pokemon.identifier]];
    [self setBackgroundColor:bot];
}

@end
