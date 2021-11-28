sudo rm *.java
sudo rm *.class
scp *.html cloud@sixiangxiang.com:~/IPFS
ssh cloud@sixiangxiang.com "ipfs add -r ~/IPFS/ > ~/IPFS/lastupdate"
publishname=$(ssh cloud@sixiangxiang.com "cat ~/IPFS/lastupdate |tail -1 |grep  -o '[^added]\w*[^IPFS]' ")
echo $publishname
ssh cloud@sixiangxiang.com "ipfs name publish $publishname --allow-offline=true" 

