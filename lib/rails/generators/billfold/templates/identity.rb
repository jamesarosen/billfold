require 'user'

class Identity < ActiveRecord::Base

  include Billfold::ActiveRecordIdentity

end
