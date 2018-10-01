# UISearchControllerDemo
按照微信的搜索框自己写了一个UISearchControllerDemo，WeChatSearchController
最近需要做一个搜索效果和微信搜索页面很类似，我使用UISearchController尝试了很多办法，都不能默认显示searchResultController，经过翻墙查找海量资料，终于做成微信的搜索效果，需要设置的地方只有下面一个地方：
```
#pragma mark - UISearchResultsUpdating
//每输入一个字符都会执行一次
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    searchController.searchResultsController.view.hidden = NO;
}
```
就这句，让 searchResultsController 一直显示：

```
searchController.searchResultsController.view.hidden = NO;
```
效果如图：<br>
![SearchController iPhone 8P](http://img.blog.csdn.net/20171214133414034?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvYml5dWh1YXBpbmc=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
![SearchController iPhone X](http://img.blog.csdn.net/20171214133900360?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvYml5dWh1YXBpbmc=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)


如果小伙伴们喜欢，请为我打call！star！么了个哒~
