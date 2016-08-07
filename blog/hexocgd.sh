#!/bin/bash
set i=0
echodot() {
  for((i=0;i<5;i++))
    do
      echo "."
    done
}


echo "------hexo clean start-----"
hexo clean
sleep 3s
echo "------hexo clean end-----"
echodot
echo "------hexo generate start-----"
hexo generate
sleep 2s
echo "------hexo generate end-----"
echodot
echo "------hexo deploy start-----"
hexo d
echo "------hexo deploy end-----"
