## Questions 
### 1.

a. I would choose alpine as for the image distribution since it would give less surface of attack so more security. 
   I would go for version 6.2 right now as it is the latest stable version from official documentation.

### 2. 
a. Redis image create a redis user by default so we can use it without having to manage it.  
   We simply need to add the `USER` directive

b. It seems Redis allow you to totally disable command by simply renaming it to empty string.   
   So we simply need to put our config file and disable both commands.   
   We could also hide those by changing the name to another string. 

c. I don't really understand this part. Since it's in docker we need to bind all interfaces by default.   
   Although I saw it was binding on both ipv4 and ipv6 so we can put a bind option to 0.0.0.0 only in config so it binds only to ipv4. 

d. I'm no redis expert but if security is my concern I would at least add some authentication on it using `requirepass` directive in the config. 
   We could also add TLS support directly into it to improve even more the security part.   
   There is a Dockerfile_secure available that add the ability to use authentication.  
   This build is not the best since it would put the password as an env in the image but at least you don't have the password inside git.   
   Here is an example on how to use it : 
   `docker build --build-arg PASS=supersecurepass -f Dockerfile_secure -t redis-secure .`  
   Then you simply need to run it and it will be protected with the password provided during the build.  
   `docker run redis-secure`

### 3.
I don't really understand this question because it is a docker image so the deploy part is quite straightforward to me.   
I would build the image locally or via a CI pipeline and then push it to a registry (thales.local for example).  
And then the server / orchestrator tool that would need it would simply pull it and run it.  

Since the question does not seems to expect that I would say the easiest way to deliver it would be via those sources so I would use a git repo to store those sources.   
Then on the remote server I would clone / pull it and run those commands : 

To build the container : 
`docker build -t redis .`

To run the container : 
`docker run -p 6379:6379 redis`

There could be another solution that would be to simply archive this folder and copy it to the remote server and run the above command the same way.  
``` 
tar -czvf ../tas-redis.tgz ../tas-redis
scp ../tas-redis.tgz user@remote:/opt/
ssh user@remote
cd /opt && tar -xzvf tas-redis.tar.gz
cd tas-redis
```
Then run build and run command. 


Below you would find a howto use this image. 

## Documentation 

### Building the image

This image is shipped with a base configuration in it with few key defined in order to make it a bit more secure.  
In order to build it you simply need to run : `docker build -t <repo>/redis:<tag> .`  
In our example let say our image registry is thales.local :  
`docker build -t thales.local/redis:6.2.12`

To build the secure image :  
`docker build -t redis-secure -f Dockerfile_secure --build-arg PASS=supersecurepass .`


### Running the image

In order to run the image we simply need to run : `docker run -d --name redis -p 6379:6379 thales.local/redis:6.2.12`   
If you want to run it in a docker-compose this image part would be : 
```
version: "3.9"
services:
  redis:
    image: "thales.local/redis:6.2.12"
    ports: 
      - "6379:6379"
```

### Testing the image

In order to test the image you will need [dgoss](https://github.com/goss-org/goss/tree/master/extras/dgoss) to be installed.   
Either you install it manually or if you have [nix](https://nixos.org/) installed you can simply run `nix develop` and it would install it for you.   
After this step the best way to test thoses images would be to run the `test.sh` script.  
This script will build automatically the images with the expected parameters to test the correct behavior of our images.   


