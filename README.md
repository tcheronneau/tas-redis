## Questions 
### 1.

a. I would choose alpine as for the image distribution since it would give less surface of attach so more security. 
   I would go for version 6.2 right now as it is the latest stable version from official documentation

### 2. 
a. Redis image create a redis user by default so we can use it without having to manage it.  
   We simply need to add the `USER` directive

b. It seems Redis allow you to totally disable command by simply renaming it to empty string.   
   So we simply need to pass our config file and disable both commands.   
   We could also hide those by changing the name to another string. 

c. I don't really understand this part. Since it's in docker we need to bind all interfaces by default.   
   Although I saw it was binding on both ipv4 and ipv6 we can put a bind option to 0.0.0.0 only in config so it bind only on ipv4. 

d. I'm no redis expert but if security is my concern I would at least add some authentication on it using `requirepass` directive in the config. 
   We could also add TLS support directly into it to improve even more the security part. 

### 3.
To build the container : 
`docker build -t redis .`

To test that the image built is what we expect we can run the testing : 
`dgoss run redis`
To run this you either have nix installed and then you simply need to run :  
`nix develop`
or you manually install [dgoss](https://github.com/goss-org/goss/tree/master/extras/dgoss) for your distribution. 

To run the container : 
`docker run -p 6379:6379 redis`


In order to improve the packaging we could provider a docker-compose but without


## Documentation 

### Building the image

This image is shipped with a base configuration in it with few key defined in order to make it a bit more secure.  
In order to build it you simply need to run : `docker build -t <repo>/redis:<tag> .`  
In our example let say our image repo is thales.local :  
`docker build -t thales.local/redis:6.2.12`


### Running the image

In order to run the image we simply need to run : `docker run -d --name redis -p 6379:6379 thales.local/redis:6.2.12`
