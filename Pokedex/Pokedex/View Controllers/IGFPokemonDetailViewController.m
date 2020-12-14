//
//  IGFPokemonDetailViewController.m
//  Pokedex
//
//  Created by Ian French on 12/12/20.
//

#import "IGFPokemonDetailViewController.h"
#import "IGFPokemonModel.h"
#import "IGFPokemonController.h"

void *KVOContext = &KVOContext;

@interface IGFPokemonDetailViewController()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *spriteImageView;



@end



@implementation IGFPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pokemonController fetchPokemonDetailsFromAPI:self.pokemon];
}

- (void)updateViews {
    if(self.pokemon) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.nameLabel.text = [NSString stringWithFormat:@"Name: %@",self.pokemon.name];
            self.idLabel.text = [NSString stringWithFormat:@"ID: %d", self.pokemon.pokemonId];
            self.spriteImageView.image = self.pokemon.pokemonSprite;
            NSString *abilityString = [[self.pokemon.abilities valueForKey:@"description"] componentsJoinedByString:@", "];
            self.abilitiesLabel.text = [NSString stringWithFormat:@"Abilities: %@", abilityString];
        });
    }
}

- (void)setPokemon:(IGFPokemonModel *)pokemon
{

    [_pokemon removeObserver:self forKeyPath:@"pokemonId" context:KVOContext];
    [_pokemon removeObserver:self forKeyPath:@"abilities" context:KVOContext];
    [_pokemon removeObserver:self forKeyPath:@"pokemonSprite" context:KVOContext];

    _pokemon = pokemon;

    [_pokemon addObserver:self forKeyPath:@"pokemonId" options:NSKeyValueObservingOptionNew context:KVOContext];
    [_pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionNew context:KVOContext];
    [_pokemon addObserver:self forKeyPath:@"pokemonSprite" options:NSKeyValueObservingOptionNew context:KVOContext];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        if([keyPath isEqualToString:@"pokemonId"]) {
            [self updateViews];
        } else if([keyPath isEqualToString:@"abilities"]) {
            [self updateViews];
        } else if([keyPath isEqualToString:@"pokemonSprite"]) {
            [self updateViews];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    self.pokemon = nil;
}

@end
