//
//  JGPDetailViewController.m
//  PokedexObjC
//
//  Created by John Pitts on 7/26/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JGPDetailViewController.h"
#import "PokedexObjC-Swift.h"          // gives us access to swift file PokemonAPIController, i THINK!
#import "JGPPokemon.h"

void *KVOContext = &KVOContext;

@interface JGPDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextView *abilitiesTextView;

// don't forget to convert url or string to UIImage
@property (weak, nonatomic) IBOutlet UIImageView *spriteImageView;


@end

@implementation JGPDetailViewController


- (void)setPokemon:(JGPPokemon *)pokemon {
    if (pokemon != _pokemon) {
        _pokemon = pokemon;
        
        [pokemon addObserver:self forKeyPath:@"identifier" options:NSKeyValueObservingOptionInitial context:KVOContext];
        //[self updateViews];     // perhaps this is needed if we get data back from observer, not sure yet
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[JGPPokemonAPIController sharedController] fillInDetailsFor:self.pokemon];    //NO COMPLETION MEANS MUST USE OBSERVER!
    
    //[self updateViews]; //to load the data into DetailVC
}


// OBSERVER:  updatesViews if addObserver in setPokemon sees a change to "identifier"
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"From KVO");
    
    if (context == KVOContext) {

        [self updateViews];
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (void)updateViews {
    NSLog(@"updating views");
    
    dispatch_async(dispatch_get_main_queue(), ^{

        self.nameLabel.text = self.pokemon.name;
        self.idLabel.text = /*[NSString stringWithFormat:@"%@", */[NSString stringWithFormat:@"%d", self.pokemon.identifier]/*]*/;
        [self displayImage];
        //self.abilitiesTextView.text = self.pokemon.abilities; /*@"sucks it \n hates other pokemon \n loves SwiftUI \n hates parsing json";*/
    });
    
    // IMAGES IN TEXTVIEW, must extract abilities from array of dictionaries of abilities
    //self.abilitiesTextView.text = self.pokemon.abilities.reduce("", { $0 + $1) } )   //might be String($0) + String($1)
    
}

- (void)displayImage {            //WORKS, just need to re-enabe comment in line 81 and delete literal...
    
    NSString *imageURLString = [NSString stringWithFormat:/*@"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png"*/@"%@", self.pokemon.sprite];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imageURLString]];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.spriteImageView.image = [UIImage  imageWithData: imageData];
    });
    //[imageData release];   With ARC ("automated release..."), release method is forbidden, it's already done for you.
}



@end
