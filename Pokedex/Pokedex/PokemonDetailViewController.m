//
//  PokemonDetailViewController.m
//  Pokedex
//
//  Created by Bobby Keffury on 2/24/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

#import "PokemonDetailViewController.h"

void *KVOContext = &KVOContext;

@interface PokemonDetailViewController ()

//MARK: - Outlets
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextView *abilitiesTextView;

@end

@implementation PokemonDetailViewController

//MARK: - Views

- (void)viewDidLoad {
    [super viewDidLoad];
}

//MARK: - Methods

- (void)updateViews
{
    if (!self.isViewLoaded || !self.pokemonDetail) { return; }
    
    self.imageView.image = [[UIImage alloc] initWithContentsOfFile:self.pokemonDetail.sprite];
    self.nameLabel.text = self.pokemonDetail.name;
    self.idLabel.text = self.pokemonDetail.id;
    self.abilitiesTextView.text = self.pokemonDetail.abilities.description;
}

- (void)setPokemon:(PokemonDetail *)pokemon
{
    if (pokemon != _pokemonDetail) {
        
        if (_pokemonDetail) {
            [_pokemonDetail removeObserver:self forKeyPath:@"pokemonDetail" context:KVOContext];
        }
        
        [self willChangeValueForKey:@"pokemonDetail"];
        _pokemonDetail = pokemon;
        [self didChangeValueForKey:@"pokemonDetail"];
        
        [_pokemonDetail addObserver:self forKeyPath:@"pokemonDetail" options:0 context:KVOContext];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == KVOContext) {
        if ([keyPath isEqualToString:@"pokemonDetail"]) {
            [self updateViews];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}



@end
