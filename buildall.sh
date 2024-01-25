account_id=$1

for i in $(ls -d */); do
  echo "It's a lambda."
  echo "${i}"
  cp build-lambda.sh "${i}"/build-lambda.sh
  cd ${i%%/}/
  sh build-lambda.sh "$account_id"
  rm build-lambda.sh
  cd ..
done
