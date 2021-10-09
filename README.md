# RubocopCops
Various custom cops for use with Rubocop

This repo holds the various cops which I have hacked up for use with the Rubocop gem.

# Use
Download the repo
Install Rubocop
```
gem install rubocop
```
Create a .rubocop.yml file in the directory that you will be running Rubocop from and then include the full path to the custom cops that you would like to use in the require section. In the example below the custom cop was put in a "cop" directory off of directory that .rubocop.yml was in.
You must also enable the cop.

``` 
require:
  - ./cop/del_block.rb
  - rubocop-rails
  ```

Most of these cops were thrown together quickly for what I expected to be one off problems; because of this they do not have accompanying tests.
