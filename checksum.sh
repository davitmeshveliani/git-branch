#!/bin/bash

# სკრიპტი სთხოვს მომხმარებელს იმ დირექტორიის გზას, რომლის კონტროლიც სურს.
# ასევე სთხოვს გზას, სადაც უნდა შეინახოს კონტროლის შედეგი.
# ქმნის დირექტორიას შედეგის შესანახად (თუ ის არ არსებობს).
# თითოეული ფაილისთვის მითითებულ დირექტორიაში:
# 1. ეკრანზე გამოაქვს ფაილის სახელი.
# 2. md5sum ბრძანებით ითვლის ფაილის MD5 ჰეშს.
# 3. ინახავს შედეგს (სახელი და ჰეში) $pathcheck-md5sum.txt ფაილში.
read -p "Enter path for control: " pathcheck
read -p "enter pat for result file: " pathresult


mkdir -p "$pathresult"

for var in "$pathcheck"/*
do
    # ვამოწმებთ, რომ ნამდვილად ფაილია
    if [ -f "$var" ]; then
        echo "file name- $var"
        # პირდაპირ ვწერთ გზას, cd აღარ გვჭირდება (რომ არ აიბნეს)
        md5sum "$var" >> "$pathresult/control-md5sum.txt"
    fi
done

echo "Done! Result saved in $pathresult/control-md5sum.txt"
