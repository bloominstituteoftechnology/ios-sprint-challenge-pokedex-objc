//
//  PokemonDetailViewController.m
//  PokedexObjc
//
//  Created by Kenneth Jones on 2/19/21.
//

#import "PokemonDetailViewController.h"
#import "PokedexObjc-Swift.h"

void *KVOContext = &KVOContext;

@interface PokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *spriteView;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@property (nonatomic) Pokemon *pokemon;
@property (nonatomic) UIImage *sprite;

@end

@implementation PokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PokemonController.shared fetchPokemonWithSearchTerm:self.pokemonName completion:^(Pokemon *pokemon, NSError *error) {
        self.pokemon = pokemon;
        
        self.title = self.pokemon.name.capitalizedString;
        self.idLabel.text = [[NSString alloc] initWithFormat:@"ID: %d", self.pokemon.identifier];
        self.abilitiesLabel.text = [[NSString alloc] initWithFormat:@"Abilities: %@", self.pokemon.abilities];
        
        NSURL *spriteURL = [[NSURL alloc] initWithString:self.pokemon.sprite];
        [PokemonController.shared fetchImageFrom:spriteURL completion:^(UIImage *sprite, NSError *error) {
            self.sprite = sprite;
            self.spriteView.image = self.sprite;
        }];
    }];
    
    [self updateViews];
}

- (void)updateViews {
    self.title = _pokemon.name.capitalizedString;
    self.idLabel.text = [[NSString alloc] initWithFormat:@"ID: %d", _pokemon.identifier];
    self.abilitiesLabel.text = [[NSString alloc] initWithFormat:@"Abilities: %@", _pokemon.abilities];
    self.spriteView.image = _sprite;
}

- (void)setPokemon:(Pokemon *)pokemon {
    
    if (pokemon != _pokemon) {
        
        // willSet
        [_pokemon removeObserver:self
                        forKeyPath:@"identifier"
                           context:KVOContext];
        [_pokemon removeObserver:self
                        forKeyPath:@"name"
                           context:KVOContext];
        [_pokemon removeObserver:self
                        forKeyPath:@"sprite"
                           context:KVOContext];
        [_pokemon removeObserver:self
                        forKeyPath:@"abilities"
                           context:KVOContext];

        [self willChangeValueForKey:@"pokemon"];
        _pokemon = pokemon;
        [self didChangeValueForKey:@"pokemon"];
        
        // didSet
        [_pokemon addObserver:self
                     forKeyPath:@"identifier"
                        options:0
                        context:KVOContext];
        [_pokemon addObserver:self
                     forKeyPath:@"name"
                        options:0
                        context:KVOContext];
        [_pokemon addObserver:self
                     forKeyPath:@"sprite"
                        options:0
                        context:KVOContext];
        [_pokemon addObserver:self
                     forKeyPath:@"abilities"
                        options:0
                        context:KVOContext];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    if (context != KVOContext) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    if ([keyPath isEqualToString:@"identifier"]) {
        [self updateViews];
    } else if ([keyPath isEqualToString:@"name"]) {
        [self updateViews];
    } else if ([keyPath isEqualToString:@"sprite"]) {
        [self updateViews];
    } else if ([keyPath isEqualToString:@"abilities"]) {
        [self updateViews];
    }
}

- (void)dealloc
{
    self.pokemon = nil;
}

@end
