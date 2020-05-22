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

- (void) updateViews {
    self.nameLabel.text = self.pokemon.name;
    self.imageView.image = self.pokemon.image;
    self.idLabel.text = [NSString stringWithFormat:@"ID: %@", self.pokemon.identifier];

    NSString *abilityText = [self.pokemon.abilities componentsJoinedByString:@"\n"];

    self.abilityTextField.text = abilityText;
}

- (void)setUpObservers {

    NSLog(@"setUpObservers");

    // Setup KVO - Add Observers

    [self.pokemon addObserver:self forKeyPath:@"image"      options:NSKeyValueObservingOptionInitial context:KVOContext];
    [self.pokemon addObserver:self forKeyPath:@"identifier" options:NSKeyValueObservingOptionInitial context:KVOContext];
    [self.pokemon addObserver:self forKeyPath:@"abilities"  options:NSKeyValueObservingOptionInitial context:KVOContext];
}

- (void)removeObservers {

    NSLog(@"removeObservers");

    // Cleanup KVO - Remove Observers
    [self.pokemon removeObserver:self forKeyPath:@"image"      context:KVOContext];
    [self.pokemon removeObserver:self forKeyPath:@"identifier" context:KVOContext];
    [self.pokemon removeObserver:self forKeyPath:@"abilities"  context:KVOContext];
}

// Review docs and implement observerValueForKeyPath
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == KVOContext) {
        NSLog(@"keypath: %@", keyPath);
        if ([keyPath isEqualToString:@"image"]) {
            // What should I do? Running changed states (NO -> YES)
            NSLog(@"KVO!");
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateViews];
            });
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    // Stop observing KVO (otherwise it will crash randomly)
    [self removeObservers];
}

@end
