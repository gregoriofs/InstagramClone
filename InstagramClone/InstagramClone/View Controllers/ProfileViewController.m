//
//  ProfileViewController.m
//  InstagramClone
//
//  Created by Gregorio Floretino Sanchez on 6/27/22.
//

#import "ProfileViewController.h"
#import "LogInViewController.h"
#import "SceneDelegate.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController
- (IBAction)didTapLogOut:(id)sender {
    
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    LogInViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
    myDelegate.window.rootViewController = loginViewController;
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    
}

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
