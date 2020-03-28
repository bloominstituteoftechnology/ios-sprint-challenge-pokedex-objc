//
//  JACPokemonTableViewCell.m
//  Pokedex-Objc
//
//  Created by Jordan Christensen on 3/28/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

#import "JACPokemonTableViewCell.h"

@interface JACPokemonTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UILabel *pokemonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonIdLabel;

@end

@implementation JACPokemonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setUpCellWithPokemon:(JACPokemon *)pokemon {
    [_pokemonImageView setImage:pokemon.image];
    [_pokemonNameLabel setText:pokemon.name];
    [_pokemonIdLabel setText:[NSString stringWithFormat:@"%@", pokemon.identifier]];
    
    [self updateViews];
}

- (void)updateViews {
    UIColor *bot = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    [self setBackgroundColor:bot];
}

@end
