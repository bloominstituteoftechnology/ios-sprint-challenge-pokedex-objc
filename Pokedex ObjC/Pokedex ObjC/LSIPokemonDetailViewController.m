//
//  LSIPokemonDetailViewController.m
//  Pokedex ObjC
//
//  Created by macbook on 1/31/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "LSIPokemonDetailViewController.h"
#import "LSIPokemon.h"
#import "Pokedex_ObjC-Swift.h"

@interface LSIPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextView *abilitiesTextview;

@end

@implementation LSIPokemonDetailViewController

void *KVOContext = &KVOContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateViews];
}

- (void)setPokemon:(LSIPokemon *)pokemon {
    
    if (pokemon != _pokemon) {
        
        _pokemon = pokemon;
        
        // didSet
        [_pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"imageURL" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"identifier" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (context == KVOContext) {
        
        if ([keyPath isEqualToString:@"abilities"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateViews];
                NSLog(@"changing abilities for pokemon: %@ \n", self.pokemon.name);
            });
        }
        if ([keyPath isEqualToString:@"imageURL"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateViews];
                NSLog(@"changing imageURL for pokemon: %@ \n", self.pokemon.name);
            });
        }
        if ([keyPath isEqualToString:@"identifier"]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateViews];
                NSLog(@"changing identifier for pokemon: %@ \n", self.pokemon.name);
            });
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (void)updateViews {
    
    if (self.pokemon) {
        
        UIImage *image = [[UIImage alloc] initWithData:self.pokemon.imageURL];
        NSString *idString = @(self.pokemon.identifier).stringValue;
        NSString *abilitiesString = [self.pokemon.abilities componentsJoinedByString:@"\n"];
        
        self.title = self.pokemon.name;
        self.nameLabel.text = self.pokemon.name;
        self.idLabel.text = idString;
        self.photoImageView.image = image;
        self.abilitiesTextview.text = abilitiesString;
    } else {
        self.nameLabel.text = @"";
        self.idLabel.text = @"";
        self.abilitiesTextview.text = @"";
    }
}

@end
