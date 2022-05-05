sleep 30
sudo apt update
sudo apt-get install unzip

## Nginx
sudo apt install nginx -y
systemctl enable nginx
sudo rm /etc/nginx/sites-available/default
sudo rm /etc/nginx/sites-enabled/default
sudo cp /tmp/adrianpardo.dev /etc/nginx/sites-available/adrianpardo.dev
sudo ln -s /etc/nginx/sites-available/adrianpardo.dev /etc/nginx/sites-enabled/adrianpardo.dev
sudo systemctl reload nginx

## Git
sudo apt install git-all

## Docker
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

## AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws configure set default.region us-east-1
aws configure set aws_access_key_id $ACCESS_KEY
aws configure set aws_secret_access_key $SECRET_KEY

## Git Clone /  Docker Compose Up
sudo chown -R $USER /var/www
cd /var/www/
git clone https://github.com/apardo04/adrianpardo.dev-react.git
cd adrianpardo.dev-react/
aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 848358406428.dkr.ecr.us-east-1.amazonaws.com
sudo docker-compose pull
sudo docker-compose up -d