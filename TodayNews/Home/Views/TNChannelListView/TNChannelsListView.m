//
//  TNChannelsListView.m
//  TodayNews
//
//  Created by 云菲 on 2017/7/4.
//  Copyright © 2017年 Freya. All rights reserved.
//

#import "TNChannelsListView.h"
#import "TNChannelCell.h"
#import "TNChannelListHeaderView.h"

@interface TNChannelsListView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic, getter=isEdited) BOOL edited;
@end

@implementation TNChannelsListView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB(240, 240, 240, 1.f);
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake(kScreenW - 64, 0, 64, 64);
        closeBtn.backgroundColor = [UIColor clearColor];
        [closeBtn setTitle:@"X" forState:UIControlStateNormal];
        [closeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        closeBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [closeBtn addTarget:self action:@selector(clickCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)clickCloseBtn:(UIButton *)sender{
    [UIView animateWithDuration:.25 animations:^{
        self.alpha = 0;
        
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}

- (void)longPressCollectionView:(UILongPressGestureRecognizer *)gesture{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[gesture locationInView:self.collectionView]];
            if (indexPath == nil || indexPath.section == 1) {
                break;
            }
            
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
            [self.collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:self.collectionView]];
            break;
            
        case UIGestureRecognizerStateEnded:
            [self.collectionView endInteractiveMovement];
            break;
            
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

- (void)setChannels:(NSMutableArray *)channels{
    _channels = channels;
    
    [self.collectionView reloadData];
}

- (void)deleteChannel:(TNChannel *)channel{
    NSInteger index = [self.myChannels indexOfObject:channel];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    TNChannelCell *cell = (TNChannelCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    cell.edited = NO;
    
    [self.myChannels removeObject:channel];
    [self.channels insertObject:channel atIndex:0];
    [self.collectionView moveItemAtIndexPath:indexPath
                                 toIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
}

- (void)addChannel:(TNChannel *)channel{
    NSInteger index = [self.channels indexOfObject:channel];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:1];
    TNChannelCell *cell = (TNChannelCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    cell.edited = self.isEdited;
    
    [self.myChannels addObject:channel];
    [self.channels removeObject:channel];
    [self.collectionView moveItemAtIndexPath:indexPath
                                 toIndexPath:[NSIndexPath indexPathForItem:self.myChannels.count - 1 inSection:0]];
}

#pragma mark - collection view delegate & datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (_channels) {
        return 2;
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return _myChannels.count;
    }
    
    return _channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TNChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kChannelCellIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.channel = _myChannels[indexPath.item];
        cell.edited = self.isEdited;
    }else{
        cell.channel = _channels[indexPath.item];
        cell.edited = NO;
    }
    
    cell.deleteBlock = ^(TNChannel *channel) {
        [self deleteChannel:channel];
    };
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.item == 0) {
        return NO;
    }
    
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return;
    }
    
    if (indexPath.section == 1) {
        TNChannel *channel = self.channels[indexPath.item];
        [self addChannel:channel];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    [self.myChannels exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        TNChannelListHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kChannelHeaderIdentifier forIndexPath:indexPath];
        headerView.section = indexPath.section;
        headerView.edited = self.isEdited;
        headerView.editBlock = ^(BOOL isEdited){
            _edited = isEdited;
            [collectionView reloadData];
        };
        return headerView;
    }
    
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(CGRectGetWidth(collectionView.bounds), 40);
}


#pragma mark - getters
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.itemSize = CGSizeMake((kScreenW - 30 * 2 - 10 * 3 ) / 4.f, 30);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(30, 64, kScreenW - 30 * 2, kScreenH - 64 - 50) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [_collectionView registerClass:[TNChannelCell class] forCellWithReuseIdentifier:kChannelCellIdentifier];
        [_collectionView registerNib:[UINib nibWithNibName:@"TNChannelListHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kChannelHeaderIdentifier];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2"];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressCollectionView:)];
        [self.collectionView addGestureRecognizer:longPress];
        
    }
    return _collectionView;
}
@end
