# Nginx configuration
```
sudo nano /etc/nginx/sites-available/default
```

Add this part in the top of the file
```
upstream samplecluster {
  server localhost:8081;
  server localhost:8080;
}
```
And modify the default/root location:
```
location / {
        proxy_pass http://samplecluster;
}
```
Run command below to check if the configuration is ok:
```
sudo nginx -t
```
In the end reload Nginx
```
sudo nginx -s reload
```
