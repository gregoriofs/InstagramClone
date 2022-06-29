//
//  PostCell.m
//  InstagramClone
//
//  Created by Gregorio Floretino Sanchez on 6/28/22.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapLikeButton:(id)sender {
    
    NSLog(@"clicking like button");
    [self updateLikes];
    
}

-(void)updateLikes{
    
    NSLog(@"b4 %d",self.post.liked.boolValue);
    
    self.post.liked = [NSNumber numberWithBool:!([self.post.liked boolValue])];
    
    NSNumber *updatedlikeCount = [self.post.liked boolValue] ? [NSNumber numberWithInt:(self.post.likeCount.intValue + 1)]:[NSNumber numberWithInt:(self.post.likeCount.intValue - 1)];
    
    self.post.likeCount = updatedlikeCount;
    
    [self refreshData:self.post.liked.boolValue];
    
    NSLog(@"likes after click %d", self.post.likeCount.intValue);
    
    [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if(succeeded){
                NSLog(@"Succesfully saved");
            }
            else{
                NSLog(@"%@", error.localizedDescription);
            }
    }];
    
}

-(void)refreshData:(BOOL)liked{
    
    UIImage *newIcon = liked ? [UIImage systemImageNamed:@"heart.fill"]: [UIImage systemImageNamed:@"suit.heart"];
    
    NSString *likeCount = [NSString stringWithFormat:@"%d",self.post.likeCount.intValue];
    
    [self.likeButton setImage:newIcon forState:UIControlStateNormal];
    
    self.numLikes.text = likeCount;
}

- (void)setPost:(Post *)post {
    _post = post;
    self.postImage.file = post[@"image"];
    [self.postImage loadInBackground];
}


@end
