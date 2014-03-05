docker-dancekit
===============

Dockerfile to set up DAnCEKit web server (see [http://dance4water.eng.monash.edu](http://dance4water.eng.monash.edu))

Run following to create the container

~~~
docker build -t dancekit git://github.com/christianurich/docker-dancekit.git
~~~
Run following to start the sever

~~~
docker run -name dancekit_instance -p 80:80 -i -t dancekit 
~~~
