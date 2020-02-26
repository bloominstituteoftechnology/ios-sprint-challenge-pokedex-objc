//
//  PokemonDetailViewController.m
//  Pokedex
//
//  Created by Bobby Keffury on 2/24/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

#import "PokemonDetailViewController.h"
#import "Pokemon.h"

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
    
    [_pokemon addObserver:self forKeyPath:@"pokemon" options:0 context:KVOContext];
    [PokemonController.sharedController fillInDetailsFor:self.pokemon];
    [self updateViews];
}

//MARK: - Methods

- (void)updateViews
{
    if (!self.isViewLoaded || !self.pokemon) { return; }
    
    self.imageView.image = [[UIImage alloc] initWithContentsOfFile:self.pokemon.sprite];
    self.nameLabel.text = self.pokemon.name;
    self.idLabel.text = self.pokemon.id;
    self.abilitiesTextView.text = self.pokemon.abilities;
}

//- (void)setPokemon:(Pokemon *)pokemon
//{
//    if (pokemon != _pokemon) {
//
//        if (_pokemon) {
//            [_pokemon removeObserver:self forKeyPath:@"pokemon" context:KVOContext];
//        }
//
//        [self willChangeValueForKey:@"pokemon"];
//        _pokemon = pokemon;
//        [self didChangeValueForKey:@"pokemon"];
//
//        [_pokemon addObserver:self forKeyPath:@"pokemon" options:0 context:KVOContext];
//    }
//}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == KVOContext) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateViews];
        });
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc
{
    self.pokemon = nil;
}

@end
