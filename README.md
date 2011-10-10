# Ransom Note

This is a Sinatra app for creating messages that simulate the style of ransom notes, commonly used by blackmailers and kidnappers (NOTE: I don't condone such actions). Instead of magazine and newspaper cuts, Flickr is the source of all individual letters, extracted from the groups [One Letter](http://www.flickr.com/groups/oneletter/), [One Digit](http://www.flickr.com/groups/onedigit/) and [Punctuation](http://www.flickr.com/groups/punctuation/).

The app is deployed at [http://ransom-note.heroku.com](http://ransom-note.heroku.com).

## How it works

The app has the following routes are available:

* "/" takes to the message composition, where you can generate a new message and save it.
* "/note/<key>" takes to a specific message. Example: [http://ransom-note.heroku.com/note/1GFM](http://ransom-note.heroku.com/note/1GFM)
* "/admin" takes to the maintenance page where you can browse images from Flickr and add/remove them from the app. Default credentials are admin/Demo123.

## Requirements

The following is required for installing and running the app:

* [MongoDB](http://www.mongodb.org/) for persistence.
* A Flickr API key. It can be obtained [here](http://www.flickr.com/services/api/misc.api_keys.html).
* [Bundler](http://gembundler.com/) for installing Ruby dependencies.

## Installation

To get the latest version and install the dependencies.

    $ curl -skL https://github.com/moonpxi/ransom_flickr/tarball/master > ransom-note.tar.gz; tar -xzf ransom-note.tar.gz
    $ cd <ransom_note_dir>
    $ bundle install

Create a `flickr_key.yaml` file in the base directory with the following:

    key: <your key>
    secret: <your key>

## Usage

From the base directory run:

    $ ruby app/ransom.rb