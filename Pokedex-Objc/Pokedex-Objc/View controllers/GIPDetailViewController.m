//
//  GIPDetailViewController.m
//  Pokedex-Objc
//
//  Created by Gi Pyo Kim on 12/20/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

#import "GIPDetailViewController.h"
#import "GIPPokemon.h"

void *KVOContext = &KVOContext;


@interface GIPDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextView *abilityTextView;

@end

@implementation GIPDetailViewController

- (void)setPokemon:(GIPPokemon *)pokemon {
    if (pokemon != _pokemon) {
        [_pokemon removeObserver:self forKeyPath:@"sprite" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"identifier" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"abilities" context:KVOContext];
        
        _pokemon = pokemon;
        
        [_pokemon addObserver:self forKeyPath:@"sprite" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"identifier" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)updateViews {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self isViewLoaded]) {
            if (self.pokemon.sprite && self.pokemon.identifier && self.pokemon.abilities) {
                self.imageView.image = self.pokemon.sprite;
                self.nameLabel.text = self.pokemon.name;
                self.idLabel.text = [NSString stringWithFormat:@"%d", [self.pokemon.identifier intValue]];
                NSMutableString *abilityString = [[NSMutableString alloc] init];
                for (NSString *ability in self.pokemon.abilities) {
                    [abilityString appendString:ability];
                    [abilityString appendString:@"\n"];
                }
                self.abilityTextView.text = abilityString;
            }
        }
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        if ([keyPath isEqualToString:@"sprite"]) {
            [self updateViews];
        }
        if ([keyPath isEqualToString:@"identifier"]) {
            [self updateViews];
        }
        if ([keyPath isEqualToString:@"abilities"]) {
            [self updateViews];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


@end
