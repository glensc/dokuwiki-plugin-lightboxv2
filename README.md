Dokuwiki Lightbox Plugin
========================

Dokuwiki plugin to integrate lightbox for all images on wiki pages

Download and Installation
-------------------------

Download and install the plugin using the [Plugin Manager](https://www.dokuwiki.org/plugin:plugin)
using the URLs from [Downloads](https://github.com/glensc/dokuwiki-plugin-lightboxv2/downloads).
Refer to [Plugins](https://www.dokuwiki.org/plugins) on how to install plugins manually.

The plugin can also be installed via git.

    % cd <dokuwiki>/lib/plugins
    % git clone git://github.com/glensc/dokuwiki-plugin-lightboxv2.git lightbox
    % cd lightbox
    % git submodule init
    % git submodule update

Changes by Elan Ruusamäe
------------------------

- 2008-08-08 - release that actually works (again)
- 2009-03-12 - JavaScript compression support; Konqueror support
- 2011-11-24 - Added code to github; no other changes
- 2012-01-03 - ported to use [jquery-lightbox](http://krewenki.github.com/jquery-lightbox) (krewenki/jquery-lightbox@3eba280)
             This version requires DokuWiki Angua release (2011-11-10) due jQuery dependency.
             And older lightbox plugin versions do not work on Angua due the same reason :)
