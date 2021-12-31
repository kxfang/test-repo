#!/bin/bash

CURL="curl -s 'https://www.lg.com/us/shop/innovel/postalcode/check/' \
  -H 'authority: www.lg.com' \
  -H 'x-requested-with: XMLHttpRequest' \
  -H 'sec-ch-ua-platform: \"macOS\"' \
  -H 'cookie: interstitialPostCode=07024' \
  --data-raw 'data%5Bform_key%5D=SQchfZzTJViT9LqA&data%5BcartId%5D=jQAdVl0sFpXIMpUgfhJYsHMnR4VZysL9&data%5Bpostalcode%5D=07024&data%5Bproducts%5D%5B0%5D%5Bindex%5D=0&data%5Bproducts%5D%5B0%5D%5Bsku%5D=MD07521462.OBS&data%5Bproducts%5D%5B0%5D%5Bqty%5D=1&dataType=json'"

echo $CURL

RESULT="$(eval $CURL)"

until [[ $RESULT == *"hasError\":0"* ]]; do
  echo $RESULT
  SLEEP=`jot -r 1  60 90`
  echo "sleeping: $SLEEP"
  sleep $SLEEP
  RESULT="$(eval $CURL)"
done

echo "$RESULT"

curl -X POST https://maker.ifttt.com/trigger/generic_notif/with/key/3HrhQDJ3fFG0MlQiPLt88

echo "DONE"
