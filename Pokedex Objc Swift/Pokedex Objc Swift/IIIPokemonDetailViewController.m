//
//  IIIPokemonDetailViewController.m
//  Pokedex Objc Swift
//
//  Created by Ilgar Ilyasov on 11/30/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import "IIIPokemonDetailViewController.h"
#import "IIIPokemon.h"

@interface IIIPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UILabel *pokemonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonIdLabel;
@property (weak, nonatomic) IBOutlet UITextView *pokemonAbilitiesTextView;

@end

@implementation IIIPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViews];
}

- (void)updateViews
{
    if (!self.isViewLoaded) { return; }
    
    if (self.pokemon) {
        self.title = self.pokemon.pokemonName;
        self.pokemonNameLabel.text = self.pokemon.pokemonName;
        self.pokemonIdLabel.text = [self.pokemon.pokemonID stringValue];
        self.pokemonAbilitiesTextView.text = [self.pokemon.pokemonAbilities componentsJoinedByString:@", "];
        
//        NSURL *url = [NSURL URLWithString:self.pokemon.pokemonFrontDefaultImageURLString];
//        [PokemonController.sharedController fetchPokemonImageWithUrl:url completion:^(UIImage * image, NSError * error) {
//            self.pokemonImageView.image = image;
//        }];
    }
}

- (void)setPokemon:(IIIPokemon *)pokemon
{
    _pokemon = pokemon;
    [PokemonController.sharedController fillInDetailsFor:pokemon];
    [self updateViews];
}

@end
