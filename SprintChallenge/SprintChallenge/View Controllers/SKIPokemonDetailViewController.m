//
//  SKIPokemonDetailViewController.m
//  SprintChallenge
//
//  Created by Joshua Rutkowski on 6/14/20.
//  Copyright © 2020 Ski. All rights reserved.
//

#import "SKIPokemonDetailViewController.h"
#import "SprintChallenge-Swift.h"
#import "SKIPokemon.h"

@interface SKIPokemonDetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *IDLabel;
@property (strong, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

@implementation SKIPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
