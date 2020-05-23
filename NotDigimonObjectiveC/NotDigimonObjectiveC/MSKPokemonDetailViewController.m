//
//  MSKPokemonDetailViewController.m
//  NotDigimonObjectiveC
//
//  Created by Lambda_School_Loaner_268 on 5/23/20.
//  Copyright © 2020 Lambda. All rights reserved.
//


#import "MSKPokemonDetailViewController.h"
#import "NotDigimonObjectiveC-Swift.h"
#import "MSKPokemon.h"
void *kvoContext = &kvoContext;
@interface MSKPokemonDetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *sprite;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *identifier;
@property (strong, nonatomic) IBOutlet UILabel *abilities;

@end

@implementation MSKPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.controller fillInDetailsFor: self.pokemon];
    [self.pokemon addObserver: self forKeyPath:@"identifier" options:0 context:kvoContext];
    [self.pokemon addObserver: self forKeyPath:@"name" options:0 context:kvoContext];
    [self.pokemon addObserver: self forKeyPath:@"abilities" options:0 context:kvoContext];
    [self.pokemon addObserver: self forKeyPath:@"url" options:0 context:kvoContext];
    // Do any additional setup after loading the view.
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context {
    if (context == kvoContext) {
        if ([keyPath isEqualToString: @"identifier"]) {
            [self updateViews];
        }
        if ([keyPath isEqualToString: @"name"]) {
            [self updateViews];
        }
        if ([keyPath isEqualToString: @"abilities"]) {
            [self updateViews];
        }
        
        if ([keyPath isEqualToString:@"url"]){
            [self getImage];
        }
    }
}
-(void)updateViews {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *abilityParent = @" ";
        // componentsJoinedByString?
        //for (NSString *ability in self.pokemon.abilities) {
       // NSString *abilities = [abilityParent stringByAppendingString: ability];
        //self.abilities = abilities
        //  }
        NSString *abilities = [self.pokemon.abilities componentsJoinedByString: abilityParent];
        self.abilities.text = abilities;
        self.name.text = self.pokemon.name;
                
        self.identifier.text = self.pokemon.identifier;
        
    });
}
-(void)getImage {
    [self.controller getImageWithFront_shiny:self.pokemon.image
                           completionHandler:^(UIImage  * _Nullable image,
                                                                                  NSError  * _Nullable error) {
        if (error) {
            NSLog(@"%@",
                  error);
        }
        dispatch_async(dispatch_get_main_queue(),
                       ^{
            [self.sprite setImage:image];
            
        });
    }];
}

                    
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
