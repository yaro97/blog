hexo g
git add .
git commit -m “updateblogsource”
git push origin master
cp -R d:/tools/linux/hexo/blog/public/. d:/tools/linux/hexo/yaro97.github.io/
cd d:/tools/linux/hexo/yaro97.github.io/
git add .
git commit -m “updateblog”
git push origin master