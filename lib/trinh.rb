require 'trinh/generator'
require 'trinh/acts_as_sequenced'

ActiveRecord::Base.send(:include, Trinh::ActsAsSequenced)
