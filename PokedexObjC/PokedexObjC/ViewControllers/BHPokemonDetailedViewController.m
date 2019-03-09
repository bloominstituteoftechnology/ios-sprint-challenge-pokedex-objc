//
//  PokemonDetailedViewController.m
//  PokedexObjC
//
//  Created by Benjamin Hakes on 3/9/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

#import "BHPokemonDetailedViewController.h"
#import "BHPokemon.h"
#import "BHAbility.h"
#import "PokedexObjC-Swift.h"

@interface BHPokemonDetailedViewController ()

@end

@implementation BHPokemonDetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_objectToObserve addObserver:self forKeyPath:@"speciesName" options:0 context:nil];
    [_pokemonAPI fillInDetailsFor:_objectToObserve];
    
    [self updateViews];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // Do any additional setup after loading the view.
    
    [_objectToObserve removeObserver:self forKeyPath:@"speciesName"];
}


// MARK: - Private Methods
- (IBAction)segmentControlTapped:(id)sender {
    [self updateViews];
}

-(void)updateViews {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.nameLabel.text = [self->_objectToObserve name];
        self.speciesLabel.text = [self->_objectToObserve speciesName];
        self.idLabel.text = [self->_objectToObserve identifier];
        
        self.abilitiesLabel.text = @"";
        
        for (BHAbility *ability in [self->_objectToObserve abilities]) {
            
            self.abilitiesLabel.text = [NSString stringWithFormat:@"%@\n%@", self.abilitiesLabel.text, [ability name]];
        }
        NSArray<NSURL *> *images = [self->_objectToObserve images];
        int imageIndex = (int)[self.segmentedControl selectedSegmentIndex];
        
        if (imageIndex == 0){
            imageIndex = 1;
        } else {
            imageIndex = 0;
        }
        
        NSURL *imageURL = images[imageIndex];
        
        NSData *data = [NSData dataWithContentsOfURL:imageURL];
        self.imageView.image = [UIImage imageWithData:data];
        
    });
    
    
}

// MARK: - KVO Methods

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [self updateViews];
}



@end
