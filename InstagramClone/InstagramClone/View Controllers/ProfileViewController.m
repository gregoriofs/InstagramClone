//
//  ProfileViewController.m
//  InstagramClone
//
//  Created by Gregorio Floretino Sanchez on 6/29/22.
//

#import "ProfileViewController.h"
#import "Parse.h"

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *arrayOfUserPosts;
@property (strong,nonatomic) UIRefreshControl *refreshControl;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    self.username.text = [PFUser currentUser].username;
    
    [self fetchUserPosts];
    
    // Do any additional setup after loading the view.
}


-(void)beginRefresh:(UIRefreshControl *)refreshControl{
    
    [self fetchUserPosts];
    
}


-(void)fetchUserPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    query.limit = 20;
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"author" equalTo:[PFUser currentUser]];
//    [query whereKey:@"userId" equalTo:[PFUser currentUser].objectId];
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.arrayOfUserPosts = posts;
            NSLog(@"%@", posts);
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrayOfUserPosts.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    
    Post *post = self.arrayOfUserPosts[indexPath.row];

    NSDate *createdAt = post.createdAt;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    formatter.dateFormat = @"MM/d/y, hh:mm aa";
    
    UIImage *likeImage = post.liked.boolValue ? [UIImage systemImageNamed:@"heart.fill"] : [UIImage systemImageNamed:@"suit.heart"];
    
    [cell.likeButton setImage:likeImage forState:UIControlStateNormal];
    
    cell.timeStamp.text = [formatter stringFromDate:createdAt];

    cell.caption.text = post.caption;

    PFUser *user = [PFUser currentUser];

    cell.userName.text = [NSString stringWithFormat:@"%@:",user.username];

    [cell setPost:post];

    cell.numLikes.text = [NSString stringWithFormat:@"%d",post.likeCount.intValue];
    
    return cell;
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
