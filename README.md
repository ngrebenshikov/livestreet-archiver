# README

1. Prerequisite: the LiveStreet site should be online to download images from it.
2. Put LiveStreet SQlite3 database (e.g. converted from MySQL) as ```/storage/livestreet.db```
3. Run ```bundle exec rake convert:md```
4. ```/tmp/md``` will contain an archive of markdown files and images for them
