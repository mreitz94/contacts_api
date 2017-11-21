#!/bin/bash

echo '(1/3) Bundling and Installing Gems...'
bundle install

echo '(2/3) Creating Database Schema...'
rake db:create

echo '(3/3) Migrating Database Tables...'
rake db:migrate