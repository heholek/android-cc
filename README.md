# android-cc

This docker image sets up a build environment for cross-compiling to Android.

You should extend this Dockerfile, with something like:

```
FROM maddox/android-cc

ADD build.sh /build/build.sh
```

Where your build.sh contains something like:

```
#!/bin/bash

env -e

git clone <your project>
cd <your project>

export CFLAGS="$CFLAGS <any flags you require>"

./configure
make
mv <your built binary> $OUT/<your built binary>
```

Then run it like:

```
$ docker run -v $(pwd):/out <your image> 
```

After compilation is complete, you will then have:

 - ./arm64-v8a/<your built binary>
 - ./armeabi-v7a/<your built binary>
 - ./x86/<your built binary>
 - ./x86_64/<your built binary>
  
