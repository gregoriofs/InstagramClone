//
//  PostDetailsViewController.m
//  InstagramClone
//
//  Created by Gregorio Floretino Sanchez on 6/28/22.
//

#import "PostDetailsViewController.h"

@interface PostDetailsViewController ()

@end

@implementation PostDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.postImage.file = self.post[@"image"];
    [self.postImage loadInBackground];
    
    PFUser *user = [PFUser currentUser];
    
    NSString *username = user.username;
    
    self.caption.text = [NSString stringWithFormat:@"%@: %@", username, self.post.caption];
    
    NSDate *createdAt = self.post.createdAt;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"MM/d/y, hh:mm aa";
    
    self.timeStamp.text = [formatter stringFromDate:createdAt];
    
    NSString *likeCount = self.post.likeCount.intValue == 1 ? [NSString stringWithFormat:@"%d like", self.post.likeCount.intValue]: [NSString stringWithFormat:@"%d likes", self.post.likeCount.intValue];
    
    self.likeCount.text = likeCount;
    
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
