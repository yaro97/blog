hexo g
git add -A
git commit -m “updateblogsource”
git push origin master
cp -R E:/hexo/blog/public/* E:/hexo/yaro97.github.io/
cd E:/hexo/yaro97.github.io/
git add -A
git commit -m “updateblog”
git push origin master