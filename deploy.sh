hexo g
git add .
git commit -m “updateblogsource”
git push origin master
cp -R D:/tools/babun/.babun/cygwin/home/yaro/blog/public. D:/tools/babun/.babun/cygwin/home/yaro/yaro97.github.io/
cd D:/tools/babun/.babun/cygwin/home/yaro/yaro97.github.io/
git add .
git commit -m “updateblog”
git push origin master