//
//  OSIPokemonDetailsViewController.m
//  Sprint12
//
//  Created by Sergey Osipyan on 3/8/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "OSIPokemonDetailsViewController.h"
#import "OSIPokemonController.h"
#import "OSIAbility.h"

@interface OSIPokemonDetailsViewController ()
@property OSIAbility *osiAbility;
@property OSIPokemonController *osiPokemonController;
@property OSIPokemon *osiPokemon;


@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *identifier;
@property (weak, nonatomic) IBOutlet UILabel *abilities;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;


@end

@implementation OSIPokemonDetailsViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        _osiPokemonController = [[OSIPokemonController alloc] init];
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.osiPokemonController fetchPokemonWithURL:self.pokemonURL complition:^(OSIPokemon *pokemon, NSError *error) {
        self.osiPokemon = pokemon;
        
        [self updateView];
    }];
}

- (void)updateView {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *name = [NSString stringWithFormat:@"Name: %@", [self->_osiPokemon.name capitalizedString]];
        self->_name.text = name;
        self->_abilities.text = @"Abilities:";
        NSString *identifier = [NSNumberFormatter localizedStringFromNumber:self->_osiPokemon.identifier numberStyle:NSNumberFormatterDecimalStyle];
        NSString *ident = [NSString stringWithFormat:@"ID: %@", identifier];
        self->_identifier.text = ident;
        if (self->_osiPokemon.imageURL) {
        NSURL *imageURL = [NSURL URLWithString:self->_osiPokemon.imageURL];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        self->_imageView.image = image;
        }
        if (self->_osiPokemon.abilities[0].name.length > 0 ) {
        self->_label1.text = self->_osiPokemon.abilities[0].name;
        if (self->_osiPokemon.abilities.count > 1 ) {
        self->_label2.text = self->_osiPokemon.abilities[1].name;
            if (self->_osiPokemon.abilities.count > 2 ) {
        self->_label3.text = self->_osiPokemon.abilities[2].name;
            }
        }
        }
    });
    
}

@end
