module News
  module Routes
    autoload :Base, 'app/routes/base'

    module V1
      autoload :Stories, 'app/routes/v1/stories'
      autoload :Users,   'app/routes/v1/users'
    end

    module V2
      autoload :Stories, 'app/routes/v2/stories'
      autoload :Users,   'app/routes/v2/users'
    end
  end
end
