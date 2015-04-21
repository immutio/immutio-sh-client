sh Client for immut.io
==============================
Store and retrieve arbitrary blobs with immut.io
from the command line.

See [immut.io](http://immut.io) for more information.

Usage
-----

Upload a file

```
$ im myfile.jpg
http://immut.io/blobs/e47c0803-3a8a-4269-bd98-2a7ffe0e59f2
```

Specify a mimetype

```
$ im -t "image/jpeg" myfilename
http://immut.io/blobs/e47c0803-3a8a-4269-bd98-2a7ffe0e59f2
```

Upload data

```
$ echo "<h1>My Title</h1>" | im -t "text/html"
http://immut.io/blobs/e47c0803-3a8a-4269-bd98-2a7ffe0e59f2
```


Installation
------------

```
$ curl https://raw.githubusercontent.com/immutio/immutio-sh-client/master/im.sh > /usr/local/bin/im
```


