//
//  TXCDetailViewController.m
//  PokedexObjc
//
//  Created by Thomas Cacciatore on 7/26/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

#import "TXCDetailViewController.h"
#import "TXCPokemon.h"


void *KVOContext = &KVOContext;

@interface TXCDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@property (nonatomic) TXCPokemon *pokemon;

@end

@implementation TXCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setPokemon:(TXCPokemon *)pokemon {
    if (pokemon != _pokemon) {
        [_pokemon removeObserver:self forKeyPath:@"name" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"id" context:KVOContext];
        
        _pokemon = pokemon;
        
        [_pokemon addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"id" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == KVOContext) {
        //fill in details for pokemon?  network call?
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void) dealloc {
    self.pokemon = nil;
}

@end
