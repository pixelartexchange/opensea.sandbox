#####
# to run use:
#   $ ruby punkoftheday/collection.rb


require_relative '../helper'


require_relative 'config'


## pre-configure collection
Tool.collection = COLLECTION


Tool.main

