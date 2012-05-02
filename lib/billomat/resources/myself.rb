module Billomat::Resources

  class Myself < Billomat::ReadOnlySingletonBase

    # non standard path
    def self.element_name
      "users/myself"
    end

    # get the billomat user for the logged in person
    def user
      Users.all.each do |user|
        return user if user.id==self.id
      end
      raise StandardError
    end
  end

end
