//
//  MTGDetailViewController.m
//  Pokedex
//
//  Created by Mark Gerrior on 5/22/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

#import "MTGDetailViewController.h"
#import "Pokedex-Swift.h"

void *KVOContext = &KVOContext;

@interface MTGDetailViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UITextView *abilityTextField;

@end

@implementation MTGDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpObservers];

    [self updateViews];

    if (self.pokemon.identifier == nil ||
        self.pokemon.image == nil ||
        self.pokemon.abilities == nil)
    {
        [PokemonAPI.sharedController fillInDetailsFor:self.pokemon];
    }

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

//    [self setUpObservers];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self tearDownObservers];

    [self viewWillDisappear:animated];
}

- (void) updateViews {
    self.nameLabel.text = self.pokemon.name;
    self.imageView.image = self.pokemon.image;
    self.idLabel.text = [NSString stringWithFormat:@"ID: %@", self.pokemon.identifier];

    NSString *abilityText = @"";

    for (int i = 0; i < self.pokemon.abilities.count; i++)
    {
//        NSLog(@"%@", [self.pokemon.abilities objectAtIndex:i]);

        [NSString stringWithFormat:@"%@%@\n", abilityText, [self.pokemon.abilities objectAtIndex:i]];
    }

    self.abilityTextField.text = abilityText;
}

- (void)setUpObservers {

    NSLog(@"setUpObservers");

    // Setup KVO - Add Observers

    [_pokemon.image      addObserver:self forKeyPath:@"viewNeedsUpdate" options:NSKeyValueObservingOptionInitial context:KVOContext];
//    [_pokemon.identifier addObserver:self forKeyPath:@"viewNeedsUpdate" options:NSKeyValueObservingOptionInitial context:KVOContext];
//    [_pokemon.abilities  addObserver:self forKeyPath:@"viewNeedsUpdate" options:NSKeyValueObservingOptionInitial context:KVOContext];
}

- (void)tearDownObservers {

    NSLog(@"tearDownObservers");

    // Cleanup KVO - Remove Observers
    [_pokemon.image      removeObserver:self forKeyPath:@"viewNeedsUpdate" context:KVOContext];
//    [_pokemon.identifier removeObserver:self forKeyPath:@"viewNeedsUpdate" context:KVOContext];
//    [_pokemon.abilities  removeObserver:self forKeyPath:@"viewNeedsUpdate" context:KVOContext];
}

// Review docs and implement observerValueForKeyPath
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == KVOContext) {
        NSLog(@"keypath: %@", keyPath);
        if ([keyPath isEqualToString:@"viewNeedsUpdate"]) {
            // What should I do? Running changed states (NO -> YES)
            [self updateViews];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    // Stop observing KVO (otherwise it will crash randomly)
    [self tearDownObservers];
}

@end
