account_id=$1

lambda_name=$(basename $(pwd))

echo "It's a python lambda."

mkdir function
python3 -m venv venv
source venv/bin/activate

venv/bin/python3 -m pip install --upgrade pip

cp main.py function/main.py
cp __init__.py function/__init__.py

python3 -m pip install \
  --platform manylinux2014_x86_64 \
  --implementation cp \
  --python 3.9 \
  --only-binary=:all: --upgrade \
  --target=function \
  -r requirements.txt

cd function/

zip -r ../"$lambda_name".zip ./*
cd ..

rm -rf function/
rm -rf venv/

aws s3 cp "$lambda_name".zip s3://"$account_id"-lambda-functions/
rm "$lambda_name".zip