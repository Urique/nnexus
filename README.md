NNexus provides an API and an engine for autolinking.

# Current features

## Setting up the server

You need Mojolicious and several other standard perl
modules, which can be installed via apt-get or cpan.

```
apt-get install libmojolicious-perl libxml-simple-perl \
  libunicode-string-perl libgraph-perl libjson-perl
```

Then, in order to quickly run the server:

```
perl Makefile.PL ; make
morbo --listen=http://*:3001 blib/script/nnexus setup/baseconf.xml
```

Note: While morbo is nice for development, deploying through Apache or Hypnotoad would be clearly the way to go for production use.
Work is underway into making NNexus into a proper service that you would be able to boot via the standard

```sh
sudo service nnexus start
```

## Connecting from a client

These two lines of PHP illustrate how NNexus can be used via curl:

```php
  $data = 'function=linkentry&body=' . urlencode($text) . '&format='.$format.'&domain=planetmath';
  $content = planetary_webglue_do_post('http://127.0.0.1:3001/autolink',$data);
```

# Future plans: JSON support

For example, sending JSON like this:

```json
  {"function":"addobject",
   "title":"foo",
   "body":"bla blarg foo blab",
   "objid":123,
   "authorid":3,
   "linkpolicy":null,
   "classes":"11-XX",
   "synonyms":"bla bla",
   "defines":"bla bla bla",
   "batchmode":null}
```

will add the document foo to the repository.  The terms
"foo", "bla bla", and "bla bla bla" will then be
autolinked in the future, if you send in JSON like this:

```json
  {"function":"linkentry",
   "body":"bla bla bar agh garble blorg",
   "format":"xhtml",
   "nolink":null}
```

The exact API functionality and their arguments are as follows:

```perl
  linkentry        : $objid $text $format $nolink
  addobject        : $objid $title $body $authorid $linkpolicy $classes $synonyms $defines $batchmode
  updateobject     : $objid [ $title $body $authorid $linkpolicy $classes $synonyms $defines $batchmode ]
  updatelinkpolicy : $objid $linkpolicy
  deleteobject     : $objid
  checkvalid       : $objid
```

# Status

This is a fork and rewrite of the original NNexus code by James Gardner (pebbler@gmail.com).
The current refactoring is pre-alpha and is under active development. Watch this space for frequent updates.

# Contact

For any questions and support requests, contact the current package maintainers:
Deyan Ginev (d.ginev@jacobs-university.de)