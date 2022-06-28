//
//  HomeFeedViewController.h
//  InstagramClone
//
//  Created by Gregorio Floretino Sanchez on 6/27/22.
//

#import <UIKit/UIKit.h>
#import "LogInViewController.h"
#import "AppDelegate.h"
#import "Parse.h"
#import "SceneDelegate.h"
#import "Post.h"
#import "PostViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeFeedViewController : UIViewController

- (IBAction)didTapLogOut:(id)sender;
@property (strong,nonatomic) NSArray *arrayOfPosts;
-  (void)finishedPost;

@end

NS_ASSUME_NONNULL_END
